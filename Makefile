all: hash_comparison_memory.png hash_comparison_read_time.png hash_comparison_write_time.png


%.png: %.gnu  results-perl.csv results-ruby.csv results-php.csv
	gnuplot $<


results-ruby.csv: lookup.rb
	ruby lookup.rb 100      > results-ruby.csv
	ruby lookup.rb 1000     >> results-ruby.csv
	ruby lookup.rb 10000    >> results-ruby.csv
	ruby lookup.rb 100000   >> results-ruby.csv
	ruby lookup.rb 1000000  >> results-ruby.csv
	ruby lookup.rb 10000000 >> results-ruby.csv
	
results-perl.csv: lookup.pl
	perl lookup.pl 100      > results-perl.csv
	perl lookup.pl 1000     >> results-perl.csv
	perl lookup.pl 10000    >> results-perl.csv
	perl lookup.pl 100000   >> results-perl.csv
	perl lookup.pl 1000000  >> results-perl.csv
	perl lookup.pl 10000000 >> results-perl.csv
	
	
results-php.csv: lookup.php
	php lookup.php 100      > results-php.csv
	php lookup.php 1000     >> results-php.csv
	php lookup.php 10000    >> results-php.csv
	php lookup.php 100000   >> results-php.csv
	php lookup.php 1000000  >> results-php.csv
	
	
