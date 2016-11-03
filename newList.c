#include "SortedList.h"
#include <pthread.h>
#include <getopt.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <sched.h>
#include <stdio.h>
#include <errno.h>
/*
int opt_yield = 0;
int INSERT_YIELD = 0;
int DELETE_YIELD = 0;
int LOOKUP_YIELD = 0;*/
int opt_yield = 0;
char** values; //array of strings
int mutex = 0;
int spin = 0;
int otherLock;
pthread_mutex_t lock;
int listFlag = 0;
int numLists = 1;
SortedList_t** master; //pointer to array of heads
SortedListElement_t** lotsOfElements; //array of element*'s to be inserted

struct argument
{
  int begin;
  int end;
  int work;
};

int hash (const char* key)
{
  int sum = 0;
  int i = 0;
  while (i < 3)
    {
      int temp = key[i];
      if (temp < 0)
	temp *= -1;
     sum +=temp;
     i++;
    }
  int result = sum % numLists; 
  return result;
}

void* threadRoutine(void* arg)
{
  struct argument* um = (struct argument*)arg;
  int begin = um->begin;
  int end = um->end;
  int n = um->work;
  if(spin)
    while(__sync_lock_test_and_set(&otherLock, 1));
  if(mutex)
    if (pthread_mutex_lock(&lock))
      {
	perror("lock error");
	exit(1);
      }
  int i = 0;
  int which = 0;
  for (i = 0; i < n; i++)
    {
      //determine correct list, and insert into that list
      which = hash(lotsOfElements[begin+i]->key);
      SortedList_insert(master[which], lotsOfElements[begin+i]);
    }
  //get the length for some reason
  int len = 0;
  for (i = 0; i < numLists; i++)
    {
      int temp = SortedList_length(master[i]);
      if (temp < 0)
	{
	  perror("corrupt list (length)");
	  exit(1);
	}
      len+= temp;
    }
  //find and delete what we created
  for (i = 0; i < n; i++)
    {
      which = hash(lotsOfElements[begin+i]->key);
      SortedListElement_t* temp = SortedList_lookup(master[which], lotsOfElements[begin+i]->key);
      if (temp == NULL)
	{
	  perror("couldn't find it!");
	  exit(1);
	}
      if ((SortedList_delete(temp)) == 1)
	{
	  perror("Corrupted List (D)");
	  exit(1);
	}
      free(temp);
    }
  if (mutex)
    if (pthread_mutex_unlock(&lock))
      {
	perror("unlocking mutex error");
	exit(1);
      }
  if (spin)
    __sync_lock_release(&otherLock, 0);
  return NULL;
}

struct timespec diff(struct timespec start, struct timespec end)
{
  struct timespec temp;
  if ((end.tv_nsec - start.tv_nsec) < 0)
    {
      temp.tv_sec = end.tv_sec - start.tv_sec-1;
      temp.tv_nsec = 1000000000 + end.tv_nsec - start.tv_nsec;
    }
    else
      {
	temp.tv_sec = end.tv_sec - start.tv_sec;
	temp.tv_nsec = end.tv_nsec - start.tv_nsec;
      }
    return temp;
}

int main(int argc, char* argv[])
{
  int c;
  int numThreads=1;
  int numIts=1;
  int errnum=0;
  char* testName = calloc(40, sizeof(char));//more than enough
  char s;
  strcat(testName, "list-");
  while(1)
    {
      static struct option long_options[] =
	{
	  {"threads", required_argument, 0, 'a'},
	  {"iterations", required_argument, 0, 'b'},
	  {"yield", required_argument, 0, 'c'},
	  {"sync", required_argument, 0, 'd'},
	  {"lists", required_argument, 0, 'e'},
	  {0,0,0,0}
	};
      int option_index=0;
      c = getopt_long(argc, argv, "a:b:c:", long_options, &option_index);

      if (c == -1)
	break;
      switch(c)
	{
	case 'a':
	  numThreads = atoi((strdup(optarg)));
	  break;
	case 'b':
	  numIts = atoi(strdup(optarg));
	  break;
	case 'c':
	  //set flags
	  ;
	  int n = strlen(strdup(optarg));
	  char* str = malloc(sizeof(char)*n);
	  str = strdup(optarg);
	  int j =0;
	  for(j = 0; j < n; j++)
	    {
	      if (str[j] == 'i')
		opt_yield |= 0x01;
	      else if (str[j] == 'd')
		opt_yield |= 0x02;
	      else if (str[j] == 'l')
		opt_yield |= 0x04;
	    }
	  free(str);
	  break;
	case 'd':
	  s = *(strdup(optarg));
	  if (s == 'm')
	    mutex = 1;
	  else if (s == 's')
	    spin = 1;
	  break;
	case 'e':
	  listFlag=0;
	  numLists = atoi(strdup(optarg));
	  break;
	}
    }
  //initializing values and list
  int numValues = numIts * numThreads;
  values = calloc(numValues, sizeof(char*));//array of strings
  int i = 0;
  for(i = 0; i < numValues; i++) //random values for length 3 strings
    {
      values[i] = malloc(sizeof(char)*4);
      int j = 0;
      for (j = 0; j < 3; j++)//1 char at a time
	{
	  srand(time(NULL)+j*i);
	  values[i][j] = rand();
	}
      values[i][3] = '\0';
    }


  int workPerThread = numValues / numThreads;
  int leftOver = numValues % numThreads;
  pthread_t* ids = malloc(sizeof(pthread_t)*numThreads);
  struct argument** args = malloc(sizeof(struct argument*)*numThreads);

  
  //use this to store the pre-allocated, initialized elements
   lotsOfElements = malloc(sizeof(SortedListElement_t*)*numIts*numThreads);
  int numElements = numIts*numThreads;
  for (i = 0; i < numElements; i++)
    {
      lotsOfElements[i] = malloc(sizeof(SortedListElement_t));
      lotsOfElements[i]->key = values[i];
      lotsOfElements[i]->prev = NULL;
      lotsOfElements[i]->next = NULL;
    }
  //initialize master list of head pointers
  master = calloc(numLists, sizeof(SortedList_t*));
  for (i = 0; i < numLists; i++)
    {
      master[i] = calloc(1, sizeof(SortedList_t));
      master[i]->next = NULL;
      master[i]->prev = NULL;
    }
  
  int elementCount =0;
  for (i = 0; i < numThreads; i++)
    {
      if (leftOver > 0)
	{
	  args[i] = malloc(sizeof(struct argument));
	  args[i]->begin = elementCount;
	  elementCount = elementCount + workPerThread + 1;
	  args[i]->end = elementCount - 1;
	  args[i]->work = workPerThread + 1;
	  leftOver--;
	}
      else
	{
	  args[i] = malloc(sizeof(struct argument));
	  args[i]->begin = elementCount;
	  elementCount = elementCount + workPerThread;
	  args[i]->end = elementCount - 1;
	  args[i]->work = workPerThread;
	}
    }
  struct timespec time_init;
  struct timespec time_fin;

  if (mutex)
    {
      if(pthread_mutex_init(&lock, NULL) != 0)
	perror("mutex failed");
    }
  //get initial time right before creating threads
  clock_gettime(CLOCK_MONOTONIC, &time_init);
  for (i = 0; i < numThreads; i++)
    pthread_create(ids + i, NULL, threadRoutine, (void*)args[i]);
  for (i = 0; i < numThreads; i++)
    pthread_join(ids[i], NULL);
  clock_gettime(CLOCK_MONOTONIC, &time_fin);
  int totalOps = 3 * numThreads * numIts;
  
  struct timespec time_diff = diff(time_init, time_fin);
  
  long avg = (time_diff.tv_nsec) / totalOps;
  int totalLen = 0;
  for (i = 0; i < numLists; i++)
    {
      if (SortedList_length(master[i]) != 0)
	{
	  perror("corrupted list (wrong size)");
	  strerror(errnum);
	  exit(errnum);
	}
    }
  //configure output string
  if (opt_yield & INSERT_YIELD)
    strcat(testName, "i");
  if (opt_yield & DELETE_YIELD)
    strcat(testName, "d");
  if (opt_yield & LOOKUP_YIELD)
    strcat(testName, "l");
  if (!opt_yield)
    strcat(testName, "none");
  strcat(testName, "-");
  if(mutex)
    strcat(testName, "m");
  else if(spin)
    strcat(testName, "s");
  else
    strcat(testName, "none");
  printf("%s,%d,%d,%d,%d,%d,%d\n",testName, numThreads, numIts, numLists, totalOps, time_diff.tv_nsec, avg); 
  strerror(errnum);
  if (errnum)
    exit(errnum);
  else
    exit(0);
}
	  
