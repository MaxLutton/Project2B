32 threads with spin
Total: 13541 samples
   13077  96.6%  96.6%    13523  99.9% threadRoutine
     230   1.7%  98.3%      230   1.7% SortedList_lookup
     165   1.2%  99.5%      165   1.2% __strcmp_sse42
      48   0.4%  99.8%      216   1.6% SortedList_insert
      13   0.1%  99.9%       13   0.1% __random_r
       4   0.0% 100.0%       17   0.1% __srandom_r
       3   0.0% 100.0%        3   0.0% _init
       1   0.0% 100.0%        1   0.0% __munmap
       0   0.0% 100.0%    13523  99.9% __clone
       0   0.0% 100.0%        1   0.0% __deallocate_stack
       0   0.0% 100.0%        1   0.0% __free_stacks
       0   0.0% 100.0%       18   0.1% __libc_start_main
       0   0.0% 100.0%       17   0.1% __srandom
       0   0.0% 100.0%       18   0.1% _start
       0   0.0% 100.0%       18   0.1% main
       0   0.0% 100.0%        1   0.0% pthread_join
       0   0.0% 100.0%    13523  99.9% start_thread
32 threads with mutex
Total: 299 samples
     122  40.8%  40.8%      122  40.8% __strcmp_sse42
      97  32.4%  73.2%       97  32.4% SortedList_lookup
      44  14.7%  88.0%      168  56.2% SortedList_insert
      15   5.0%  93.0%       15   5.0% __random_r
      10   3.3%  96.3%       10   3.3% __GI___pthread_mutex_unlock
       4   1.3%  97.7%       19   6.4% __srandom_r
       2   0.7%  98.3%        2   0.7% __GI___pthread_mutex_lock
       2   0.7%  99.0%        2   0.7% _init
       2   0.7%  99.7%        2   0.7% _int_free
       1   0.3% 100.0%        1   0.3% _int_malloc
       0   0.0% 100.0%        1   0.3% __GI___libc_malloc
       0   0.0% 100.0%      279  93.3% __clone
       0   0.0% 100.0%       20   6.7% __libc_start_main
       0   0.0% 100.0%       19   6.4% __srandom
       0   0.0% 100.0%       20   6.7% _start
       0   0.0% 100.0%       20   6.7% main
       0   0.0% 100.0%      279  93.3% start_thread
       0   0.0% 100.0%      279  93.3% threadRoutine
