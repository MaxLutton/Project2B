This contains a SortedList.h header file and SortedList.c source file, both of which have not been changed since the last submission. The file lab2_list.c has been significantly altered in order to implemenet sub-lists. Therefore, in order to display the results graphically from part A, the file old_data.csv has been included. This contains the data from the add program and the list program before I implemented the sub-lists. There is also a Makefile, with all the necessary targets.
My graph #2 is a little messed up because my old-data.csv file contained data from two different versions of my old lab2_list code. The first was before adding in the additional timing mechanisms, and the second (relevant) data came after. In order to see the trend, look at the to blue line for average time per operation.


Question 2.3.1
For add, I'd expect the most cycles to be spent in the
actual mathematical calculations. This is because there are just
so many more of these than any other kinds of instructions.
For list, I'd expect the majority of the cycles to be spent on
actually creating and updating the list and its elements. Again, just
based off of the sheer proportion of code.

In the high-thread spin-lock tests, I'd have to assume that a larger
portion of the run time is spent just spinniing. This is backed up by
my data, as throughput goes down substantially as thread number
increased.

In the high-thread mutex tests, I'm inclined to believe, based off of my data, that although a decent amount of time will be spent blocking, the
slight advantage of some parallelism is able to help mitigate that
penalty, leaving throughput either unchanged or slightly improved.

Question 2.3.2
Below is the result from my gprof:

threads=12 iterations=1000 spin lock
Total: 160 samples
     143  89.4%  89.4%      158  98.8% threadRoutine
      10   6.2%  95.6%       13   8.1% SortedList_insert
       3   1.9%  97.5%        3   1.9% __strcmp_sse42
       2   1.2%  98.8%        2   1.2% SortedList_lookup
       1   0.6%  99.4%        1   0.6% __pthread_create_2_1
       1   0.6% 100.0%        1   0.6% __random_r
       0   0.0% 100.0%      158  98.8% __clone
       0   0.0% 100.0%        2   1.2% __libc_start_main
       0   0.0% 100.0%        1   0.6% __srandom
       0   0.0% 100.0%        1   0.6% __srandom_r
       0   0.0% 100.0%        2   1.2% _start
       0   0.0% 100.0%        2   1.2% main
       0   0.0% 100.0%      158  98.8% start_thread
So the vast majority of time was spent in the threadRoutine function.
Upon further inspection, 143 of the 158 samples from threadRoutine
function were from one line:
	while(__sync_lock_test_and_set(&otherLock, 1));
13 samples were on the line that inserted elements and 2 were on
looking up an element.
This one line of code, where the program was spinning, slowed everything
down, and predictably so. With a decent number of threads, the
threads will just spin for a long time, until they're preempted, not
doing any actual work.

2.3.3
The average lock time, for my implementation, did not see the spike. But, I would attribute a spike, if testing showed one, to the increasing
probability of contention.
Completion time per opertaion would rise less dramatically because
it is insulated from the lock wait time but performing other
tasks over its lifetime, thus having a larger overall sample size.
This would be possible if there were so many threads, that
they were actually waiting more than getting work done, a symptom
of thrashing.

2.3.4
Performance tended to increase as the number of lists grew. This is
likley due to decreasing rate of contention for the lists among
the threads.
Throughput would keep increasing, to a point. Then, limitations
on the machine would start to show, putting a restriction
on throughput, and actually making throughput go down.
This does not appeaar to be the case for the curves. Mainly,
because I do not know what this question means.
