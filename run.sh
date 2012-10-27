echo -n "" > results.csv

ruby lookup.rb 100     >> results.csv
ruby lookup.rb 1000    >> results.csv
ruby lookup.rb 10000   >> results.csv
ruby lookup.rb 100000  >> results.csv
ruby lookup.rb 1000000 >> results.csv

perl lookup.pl 100     >> results.csv
perl lookup.pl 1000    >> results.csv
perl lookup.pl 10000   >> results.csv
perl lookup.pl 100000  >> results.csv
perl lookup.pl 1000000 >> results.csv


php lookup.php 100     >> results.csv
php lookup.php 1000    >> results.csv
php lookup.php 10000   >> results.csv
php lookup.php 100000  >> results.csv
php lookup.php 1000000 >> results.csv


