set terminal png
set output "hash_comparison_memory.png"
set title "Comparing Hashes in Ruby, Perl, PHP: Memory"
set xlabel "Size of Hash"

set xrange [100:1000000]
set logscale y
set logscale x

plot  "results-ruby.csv" using 2:5  title 'Ruby: Memory' with linespoints, \
      "results-perl.csv" using 2:5  title 'Perl: Memory' with linespoints, \
      "results-php.csv" using 2:5  title 'PHP: Memory' with linespoints
