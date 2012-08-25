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

t0 = Time.now


f = open "#{dir}/positive#{no}.txt"
f.each do |name|
  name.chomp!
  unless the_hash.has_key?( name )
    puts "could not find #{name}!"
    exit
  end
end
f.close

t1 = Time.now
t = t1 - t0

puts "POSITIVE: #{t}"



t0 = Time.now

f = open "#{dir}/negative#{no}.txt" 
f.each do |name|
  name.chomp!
  if the_hash.has_key?( name )
     puts "found #{name}!"
     exit
  end
end
f.close

t1 = Time.now
t = t1 - t0

puts "NEGATIVE: #{t}"

