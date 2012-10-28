all: hash_comparison_memory.png hash_comparison_read_time.png hash_comparison_write_time.png 


%.png: %.gnu  results-perl.csv results-ruby.csv results-php.csv
	gnuplot $<

results-ruby.csv: ../lookup.rb
	ruby ../lookup.rb 1000000   > results-ruby.csv
	ruby ../lookup.rb 2000000  >> results-ruby.csv
	ruby ../lookup.rb 3000000  >> results-ruby.csv
	ruby ../lookup.rb 4000000  >> results-ruby.csv
	ruby ../lookup.rb 5000000  >> results-ruby.csv
	ruby ../lookup.rb 6000000  >> results-ruby.csv
	ruby ../lookup.rb 7000000  >> results-ruby.csv
	ruby ../lookup.rb 8000000  >> results-ruby.csv
	ruby ../lookup.rb 9000000  >> results-ruby.csv
	ruby ../lookup.rb 10000000  >> results-ruby.csv
	
results-perl.csv: ../lookup.pl
	perl ../lookup.pl 1000000   > results-perl.csv
	perl ../lookup.pl 2000000  >> results-perl.csv
	perl ../lookup.pl 3000000  >> results-perl.csv
	perl ../lookup.pl 4000000  >> results-perl.csv
	perl ../lookup.pl 5000000  >> results-perl.csv
	perl ../lookup.pl 6000000  >> results-perl.csv
	perl ../lookup.pl 7000000  >> results-perl.csv
	perl ../lookup.pl 8000000  >> results-perl.csv
	perl ../lookup.pl 9000000  >> results-perl.csv
	perl ../lookup.pl 10000000  >> results-perl.csv
	
	
results-php.csv: ../lookup.php
	php -n ../lookup.php 1000000   > results-php.csv
	php -n ../lookup.php 2000000  >> results-php.csv
	php -n ../lookup.php 3000000  >> results-php.csv
	php -n ../lookup.php 4000000  >> results-php.csv
	php -n ../lookup.php 5000000  >> results-php.csv
	php -n ../lookup.php 6000000  >> results-php.csv
	php -n ../lookup.php 7000000  >> results-php.csv
	php -n ../lookup.php 8000000  >> results-php.csv
	php -n ../lookup.php 9000000  >> results-php.csv
	
