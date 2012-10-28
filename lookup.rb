no = ARGV[0]
dir = "#{File.dirname(__FILE__)}/data"
no_of_test_data = 50

unless no =~  /^\d+$/
  puts "how many lines should I use? please specify on the command line!"
  exit
end

no = no.to_i

if no > 10000000
  puts "create more input data, only have 10 million lines!"
  exit
end

suffix = "-7"

err_no = 0
errors = []


["input#{suffix}.txt", "positive#{suffix}.txt", "negative#{suffix}.txt"].each do |filename|
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
f = open( "#{dir}/input#{suffix}.txt")
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


positive = IO.readlines("#{dir}/input#{suffix}.txt").first(no_of_test_data).map{|l| l.split(/ /).first }
negative = IO.readlines("#{dir}/negative#{suffix}.txt").map(&:chomp)

die("should have #{no_of_test_data} negative examples, not #{negative.count}!") unless negative.count==no_of_test_data
max_repeat = 10000

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
