sh_comparison
===============

Compare the read performance and memory consumption of the Hash Datatype in Ruby, Perl, PHP.
See [Wikipedia](http://en.wikipedia.org/wiki/Hash_table#In_programming_languages) if
you are not familiar with this data type.

How to call the scripts to build a hash of 100 key/value pairs and
then run performance test on reading from that hash:
  
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

## What we expect

Memory consumption should be proportional to the number of keys and values.

Writing to the Hash should be possible in constant time.

Reading from the Hash should be possible in constant time.

## Results: Overview

On my macbook air with 4GB Ram (of which approx. 2GB are available)
I can run these test with hash up to 10 million keys+values - except for PHP,
which hits some kind of wall below 10 million.

In this graph both axes are logarithmic, to cover the range from 100 to 10
million:

![Memory usage, log scale](https://raw.github.com/bjelline/hash_comparison/master/comparison_log/hash_comparison_memory.png "Memory Usage")

Measuring the write time is the least trustworthy part of these measurements:
when reading in 100.000 keys and values into a hash we measure the time to
read in the last 50 keys and values.  This measurement is not repeated, and the
actual time used is very small. 

The measurement seems consistent with a constant write time:

![Write Time](https://raw.github.com/bjelline/hash_comparison/master/comparison_log/hash_comparison_write_time.png "Write Time")

We measure two different types of read: reading a value for a key that exists,
and trying to read for a key that does not exists.  we use 50 different keys
each, and repeat 50 read operations 10.000 times.

The measurement seems consistent with a constant read time. Not finding a key
seems to be faster than finding a key:

![Read Time](https://raw.github.com/bjelline/hash_comparison/master/comparison_log/hash_comparison_read_time.png "Read Time")

## Results: 1 to 10 million

When we zoom in on sizes from 1 to 10 million keys+values and switch to linear
axes the higher memory consumption of php becomes more obvious.  It would seem
that PHP runs out of memory over 8 million and has to start swapping: 

![Memory usage, log scale](https://raw.github.com/bjelline/hash_comparison/master/comparison_linear/hash_comparison_memory.png "Memory Usage")

You can see the breakdown of PHP at around 8 million also in the write and read
times:

![Write Time](https://raw.github.com/bjelline/hash_comparison/master/comparison_linear/hash_comparison_write_time.png "Write Time")

![Read Time](https://raw.github.com/bjelline/hash_comparison/master/comparison_linear/hash_comparison_read_time.png "Read Time")


