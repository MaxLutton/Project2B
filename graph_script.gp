
set terminal png
set datafile separator ","

set xtics

set title "Lab2b-1: Throughput vs Threads"
set xlabel "Threads"
set logscale x 2
set xrange [0.75:]
set ylabel "Throughput"
set logscale y 10
set output 'lab2b_1.png'
set key left top
plot \
     "< grep 'list-none-m,' old_data.csv" using ($2):(1e9)/($7) \
	title 'list mutex' with linespoints lc rgb 'green',    \
	"< grep 'list-none-s,' old_data.csv" using ($2):(1e9)/($7) \
	title 'list spin' with linespoints lc rgb 'blue',    \
	"< grep 'add-m,' old_data.csv" using ($2):(1e9)/($6) \
	title 'add mutex' with linespoint lc rgb 'red',     \
	"<grep 'add-s,' old_data.csv" using ($2):(1e9)/($6)   \
	title 'add spin' with linespoint lc rgb 'orange'


set title "Lab2b-2: Timing Mutex Waits"
set xlabel "Threads"
set logscale x 2
set xrange [0.75:]
set ylabel "time"
set logscale y 10
set output 'lab2b_2.png'
set key left top
plot \
     "< grep 'list-none-m,' old_data.csv" using ($2):($8) \
	title 'wait for lock time' with linespoints lc rgb 'green',    \
	"< grep 'list-none-m,' old_data.csv" using ($2):($7) \
	title 'avg time per operation' with linespoints lc rgb 'blue'

     
set title "lab2b-3: Iterations that run without failure w/ yield=id"
set xlabel "Threads"
set logscale x 2
set xrange [0.75:]
set ylabel "successful iterations"
set logscale y 10
set output 'lab2b_3.png'
set key left top
plot \
     "< grep 'list-id-none,' lab_2b_list.csv" using ($2):($3) \
	title 'no sync' with points lc rgb 'green',    \
	"< grep 'list-id-m,' lab_2b_list.csv" using ($2):($3) \
	title 'w/ mutex' with points lc rgb 'blue', \
	"< grep 'list-id-s,' lab_2b_list.csv" using ($2):($3) \
        title 'w/ spin' with points lc rgb 'red'


set title "Lab2b-4: Throughput vs Threads, w/ mutex"
set xlabel "Threads"
set logscale x 2
set xrange [0.75:]
set ylabel "Throughput"
set logscale y 10
set output 'lab2b_4.png'
set key left top
plot \
     "< grep 'list-none-m,.*,.*,1' lab_2b_list.csv" using ($2):(1e9)/($7) \
	title '1 list' with linespoints lc rgb 'green',    \
	"< grep 'list-none-m,.*,.*,4' lab_2b_list.csv" using ($2):(1e9)/($7)\
	title '4 lists' with linespoints lc rgb 'blue',    \
	"< grep 'list-none-m,.*,.*,8' lab_2b_list.csv" using ($2):(1e9)/($7)\
	title '8 lists' with linespoints lc rgb 'red',    \
      "< grep 'list-none-m,.*,.*,16' lab_2b_list.csv" using ($2):(1e9)/($7) \
	title '16 lists' with linespoints lc rgb 'violet'


set title "Lab2b-5: Throughput vs Threads, w/ spin"
set xlabel "Threads"
set logscale x 2
set xrange [0.75:]
set ylabel "Throughput"
set logscale y 10
set output 'lab2b_5.png'
set key left top
plot \
     "< grep 'list-none-s,.*,.*,1' lab_2b_list.csv" using ($2):(1e9)/($7) \
	title '1 list' with linespoints lc rgb 'green',    \
	"< grep 'list-none-s,.*,.*,4' lab_2b_list.csv" using ($2):(1e9)/($7)\
	title '4 lists' with linespoints lc rgb 'blue',    \
	"< grep 'list-none-s,.*,.*,8' lab_2b_list.csv" using ($2):(1e9)/($7)\
	title '8 lists' with linespoints lc rgb 'red',    \
      "< grep 'list-none-s,.*,.*,16' lab_2b_list.csv" using ($2):(1e9)/($7) \
	title '16 lists' with linespoints lc rgb 'violet'