sh_comparison
===============

Compare the read performance and memory consumption of the Hash Datatype in Ruby, Perl, PHP

How to call the scripts to build a hash of 100 key/value pairs and
then read from that hash:
  
  ruby lookup.rb 100
  perl lookup.pl 100
  php -n lookup.php 100

output should be

  ruby 100 3588 3640 52 9.9e-05 10000 50 0.107588 0.094855

* language
* size of hash used
* memory use before loading the hash
* memory use after loading the hash
* diff memory 
* time to load last 50 key/value pairs into the hash (once)
* number of repeats for the read operation
* number of different keys to use in read operation
* time to read 50 keys from the hash (that are actually in the hash) repeated 10000 times
* time to read 50 keys from the hash (that are NOT actually in the hash) repeated 10000 times

## Results

On my macbook air with 4GB Ram, of which approx. 2GB are available
I can run these test with hash up to 10 million keys+values - except for PHP,
which hit's some kind of wall before 10 million:

![Memory usage, log scale](https://raw.github.com/bjelline/hash_comparison/master/comparison_log/hash_comparison_memory.png "Memory Usage")

![Write Time](https://raw.github.com/bjelline/hash_comparison/master/comparison_log/hash_comparison_write_time.png "Write Time")

![Read Time](https://raw.github.com/bjelline/hash_comparison/master/comparison_log/hash_comparison_read_time.png "Read Time")


When I zoom in on sizes from 1 to 10 million keys+values the higher
memory consumption of php becomes more obvious:


![Memory usage, log scale](https://raw.github.com/bjelline/hash_comparison/master/comparison_linear/hash_comparison_memory.png "Memory Usage")

![Write Time](https://raw.github.com/bjelline/hash_comparison/master/comparison_linear/hash_comparison_write_time.png "Write Time")

![Read Time](https://raw.github.com/bjelline/hash_comparison/master/comparison_linear/hash_comparison_read_time.png "Read Time")


