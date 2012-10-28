set terminal png
set output "hash_comparison_write_time.png"
set title "Comparing Hashes in Ruby, Perl, PHP: Write Time"
set xlabel "Size of Hash"

set xrange [1000000:10000000]

set style line 1 lt 1 lc 3
set style line 2 lt 1 lc 2
set style line 3 lt 1 lc 1

plot  "results-ruby.csv" using 2:6  title 'Ruby: Write Time' with linespoints ls 1, \
      "results-perl.csv" using 2:6  title 'Perl: Write Time' with linespoints ls 2, \
      "results-php.csv"  using 2:6  title 'PHP: Write Time' with linespoints ls 3
