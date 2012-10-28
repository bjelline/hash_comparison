#
# lookup.rb - Memory and Performance Test for Ruby Hashes
#
=begin

 Copyright (C) 2012 Brigitte Jellinek <code@brigitte-jellinek.at>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

=end


             no = ARGV[0]                            # number of keys+values to read into hash
            dir = "#{File.dirname(__FILE__)}/data"   # absolute path to data directory
no_of_test_data = 50                                 # number of keys+values to read from hash
     max_repeat = 10000                              # no of repeats of read operations (times no_of_test_data!)

unless no =~  /^\d+$/
  puts "how many lines should I use? please specify on the command line!"
  exit
end

no = no.to_i

if no > 10000000
  puts "create more input data, only have 10 million lines!"
  exit
end

err_no = 0
errors = []


["input.txt",  "negative.txt"].each do |filename|
  unless File.exists?("#{dir}/#{filename}")
    err_no += 1
    errors.push "Cannot read file #{filename} from folder #{dir}."
  end
end

if err_no > 0 
  puts "Fehlende Dateien: "
  errors.each do |m| 
    puts m 
  end 
  exit
end

def get_memory_usage
  `ps -o rss= -p #{Process.pid}`.to_i
end

data = ['ruby', no]

before = get_memory_usage
data.push(before)


the_hash = Hash.new

count = 0
counted = false
f = open( "#{dir}/input.txt")
t0 = Time.now
f.each do |l|
  name, number = l.chomp.split
  the_hash[name] = number
  count += 1
  break if count >= no
  # only count the last 50 inserts
  if count + no_of_test_data == no then
    t0 = Time.now
    counted = true
  end
end
f.close

if ! counted then
  puts "could not measure time to load last #{no_of_test_data} lines of data"
  exit
end
t1 = Time.now
t = t1 - t0

after = get_memory_usage

data.push(after)
data.push(after-before)
data.push(t)


positive = IO.readlines("#{dir}/input.txt").first(no_of_test_data).map{|l| l.split(/ /).first }
negative = IO.readlines("#{dir}/negative.txt").map(&:chomp)

die("should have #{no_of_test_data} negative examples, not #{negative.count}!") unless negative.count==no_of_test_data

data.push(max_repeat)
data.push(no_of_test_data)

t0 = Time.now
max_repeat.times do 
  positive.each do |name|
    unless the_hash.has_key?( name )
      puts "could not find #{name}!"
      exit
    end
  end
end
t1 = Time.now
t = t1 - t0

data.push(t)



t0 = Time.now

max_repeat.times do 
  negative.each do |name|
    if the_hash.has_key?( name )
       puts "found #{name}!"
       exit
    end
  end
end
t1 = Time.now
t = t1 - t0

data.push(t)


puts data.join(" ")
