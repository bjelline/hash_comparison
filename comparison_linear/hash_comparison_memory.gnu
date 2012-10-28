set terminal png
set output "hash_comparison_memory.png"
set title "Comparing Hashes in Ruby, Perl, PHP: Memory"
set xlabel "Size of Hash"

set xrange [1000000:10000000]

set style line 1 lt 1 lc 3
set style line 2 lt 1 lc 2
set style line 3 lt 1 lc 1

plot  "results-ruby.csv" using 2:5  title 'Ruby: Memory' with linespoints lt 1, \
      "results-perl.csv" using 2:5  title 'Perl: Memory' with linespoints lt 2, \
      "results-php.csv"  using 2:5  title 'PHP: Memory'  with linespoints lt 3
