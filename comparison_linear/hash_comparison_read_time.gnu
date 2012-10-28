set terminal png
set output "hash_comparison_read_time.png"
set title "Comparing Hashes in Ruby, Perl, PHP: Read Time"
set xlabel "Size of Hash"

set xrange [1000000:10000000]

set style line 1 lt 1 lc 3
set style line 2 lt 1 lc 2
set style line 3 lt 1 lc 1

plot  "results-ruby.csv" using 2:9  title 'Ruby: Read Time (found)' with linespoints ls 1 points 1, \
                      "" using 2:10 title 'Ruby: Read Time (not found)' with linespoints ls 1 points 0, \
      "results-perl.csv" using 2:9  title 'Perl: Read Time (found)' with linespoints ls 2 points 1, \
                      "" using 2:10 title 'Perl: Read Time (not found)' with linespoints ls 2 points 0, \
      "results-php.csv"  using 2:9  title 'PHP: Read Time (found)' with linespoints ls 3 points 1, \
                      "" using 2:10 title 'PHP: Read Time (not found)' with linespoints ls 3 points 0
