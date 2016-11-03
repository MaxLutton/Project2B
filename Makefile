build:
	gcc -lpthread -lrt -o lab2_list lab2_list.c SortedList.c
profile:
	LD_PRELOAD=/u/cs/ugrad/maxwelll/cs111/Project2/2b/lib/libprofiler.so.0 CPUPROFILE=raw.perf ./lab2_list --threads=32 --iterations=1000 --sync=s
	echo "32 threads with spin" >> profile
	./pprof --text lab2_list raw.perf >> profile
	LD_PRELOAD=/u/cs/ugrad/maxwelll/cs111/Project2/2b/lib/libprofiler.so.0 CPUPROFILE=raw.perf ./lab2_list --threads=32 --iterations=1000 --sync=m
	echo "32 threads with mutex" >> profile
	./pprof --text lab2_list raw.perf >> profile


graphs:
	./gnuplot graph_script.gp

tarball:
	tar -czf lab2b-604493477.tar.gz SortedList.h SortedList.c lab2_list.c Makefile lab_2b_list.csv lab2b_1.png lab2b_2.png lab2b_3.png lab2b_4.png lab2b_5.png README.txt old_data.csv profile

clean:
	rm profile
	rm lab2_list
	rm lab_2b_list.csv
	rm lab2b_1.png
	rm lab2b_2.png
	rm lab2b_3.png
	rm lab2b_4.png
	rm lab2b_5.png

tests:
	rm -f lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iteraations=1 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iteraations=2 >> lab2_new.cs
	-./lab2_list --yield=id --lists=4 --threads=1 --iteraations=4 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iteraations=8 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iteraations=16 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=2 --iteraations=1 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=2 --iteraations=2 >> lab2_new.cs
	-./lab2_list --yield=id --lists=4 --threads=2 --iteraations=4 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=2 --iteraations=8 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=2 --iteraations=16 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iteraations=1 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iteraations=2 >> lab2_new.cs
	-./lab2_list --yield=id --lists=4 --threads=4 --iteraations=4 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iteraations=8 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iteraations=16 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iteraations=1 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iteraations=2 >> lab2_new.cs
	-./lab2_list --yield=id --lists=4 --threads=8 --iteraations=4 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iteraations=8 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iteraations=16 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iteraations=1 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iteraations=2 >> lab2_new.cs
	-./lab2_list --yield=id --lists=4 --threads=12 --iteraations=4 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iteraations=8 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iteraations=16 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iteraations=1 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iteraations=2 >> lab2_new.cs
	-./lab2_list --yield=id --lists=4 --threads=16 --iteraations=4 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iteraations=8 >> lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iteraations=16 >> lab_2b_list.csv
#with sync=s
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=10 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=20 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=40 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=80 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=10 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=20 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=40 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=80 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=10 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=20 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=40 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=80 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=10 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=20 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=40 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=80 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=10 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=20 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=40 --sync=s >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=80 --sync=s >>lab_2b_list.csv
#with sync=m
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=10 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=20 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=40 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=80 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=10 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=20 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=40 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=80 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=10 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=20 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=40 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=80 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=10 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=20 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=40 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=80 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=10 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=20 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=40 --sync=m >>lab_2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=80 --sync=m >>lab_2b_list.csv

#no yields, mutex
	-./lab2_list --lists=1 --threads=1 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=4 --threads=1 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=8 --threads=1 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=16 --threads=1 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=1 --threads=2 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=4 --threads=2 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=8 --threads=2 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=16 --threads=2 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=1 --threads=4 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=4 --threads=4 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=8 --threads=4 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=16 --threads=4 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=1 --threads=8 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=4 --threads=8 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=8 --threads=8 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=16 --threads=8 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=1 --threads=12 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=4 --threads=12 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=8 --threads=12 --iterations=1000 --sync=m >> lab_2b_list.csv
	-./lab2_list --lists=16 --threads=12 --iterations=1000 --sync=m >> lab_2b_list.csv
#no yield, spin
	-./lab2_list --lists=1 --threads=1 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=4 --threads=1 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=8 --threads=1 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=16 --threads=1 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=1 --threads=2 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=4 --threads=2 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=8 --threads=2 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=16 --threads=2 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=1 --threads=4 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=4 --threads=4 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=8 --threads=4 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=16 --threads=4 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=1 --threads=8 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=4 --threads=8 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=8 --threads=8 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=16 --threads=8 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=1 --threads=12 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=4 --threads=12 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=8 --threads=12 --iterations=1000 --sync=s >> lab_2b_list.csv
	-./lab2_list --lists=16 --threads=12 --iterations=1000 --sync=s >> lab_2b_list.csv
