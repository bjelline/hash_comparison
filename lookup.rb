no = ARGV[0]
dir = "data"

unless no =~  /^\-\w?\d+$/
  puts "which data set should I use? plasee specify on the command line like this: -5 or -7"
  exit
end

err_no = 0
errors = []



["input#{no}.txt", "positive#{no}.txt", "negative#{no}.txt"].each do |filename|
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

before = get_memory_usage

t0 = Time.now

the_hash = Hash.new

f = open( "#{dir}/input#{no}.txt")
f.each do |l|
  name, number = l.chomp.split
  the_hash[name] = number
end
f.close


t1 = Time.now
t = t1 - t0

puts "READ: #{t}"
after = get_memory_usage

puts "MEM: #{after-before}"


positive = IO.readlines("#{dir}/positive#{no}.txt").map(&:chomp)
negative = IO.readlines("#{dir}/negative#{no}.txt").map(&:chomp)

max_repeat = 10000


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

puts "POSITIVE: #{t}"



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

puts "NEGATIVE: #{t}"

