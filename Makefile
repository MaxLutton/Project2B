default:
	gcc -g -o lab2_list ./lab2_list.c
test:
	LD_PRELOAD=/u/cs/ugrad/maxwelll/cs111/Project2/2b/lib/libprofiler.so.0 CPUPROFILE=raw.perf ./lab2_list --threads=12 --iterations=1000 --sync=s

build:
	gcc -g -lpthread -lrt -o newList newList.c SortedList.c
