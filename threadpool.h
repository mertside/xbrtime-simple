/*                                                                              
 * _THREADPOOL_H_                                                       
 *
 * on 2022/08/28                                                       
 *                                                                              
 */   
#ifndef __THREADPOOL_H__
#define __THREADPOOL_H__

#include <stdbool.h>
#include <stddef.h>

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

#include <pthread.h>
#include <sys/types.h>

#include "threadpool.h"

// ---------------------------------------------------------------- PROTOTYPES

struct tpool_work_queue;
typedef struct tpool_work_queue tpool_work_queue_t;

typedef void (*thread_func_t)(void *arg);

tpool_work_queue_t *tpool_create(size_t num);
void tpool_destroy(tpool_work_queue_t *wq);

// Adds work to the queue for processing. 
bool tpool_add_work(tpool_work_queue_t *wq, thread_func_t func, void *arg);

// Blocks until all work has been completed.
void tpool_wait(tpool_work_queue_t *wq);

// --------------------------------------------------------------- OBJECT DATA  
// Simple linked list which stores the function to call and its arguments.      
struct tpool_work_unit {                                                             
  thread_func_t           func;                                                      
  void                   *arg;                                                       
  struct tpool_work_unit *next;                                                      
};                                                                              
typedef struct tpool_work_unit tpool_work_unit_t;                                         
                                                                                
struct tpool_work_queue {                                                                  
  tpool_work_unit_t  *work_head;     // queue head pointer                         
  tpool_work_unit_t  *work_tail;     // queue tail pointer                         
  pthread_mutex_t     work_mutex;    // single mutex for all locking               
  pthread_cond_t      work_cond;     // signal: there is work to process   
  pthread_cond_t      working_cond;  // signal: no threads processing              
  size_t              working_cnt;   // number of threads actively working  
  size_t              num_threads;   // number of threads alive                    
  bool                stop;          // stops the threads                          
};                                                                              
                                                                                
// ---------------------------------- Simple helper for creating work objects.  
static tpool_work_unit_t *tpool_work_unit_create(thread_func_t func, void *arg)           
{                                                                               
  tpool_work_unit_t *work;                                                           
                                                                                
  if (func == NULL)                                                             
    return NULL;                                                                
                                                                                
  work       = malloc(sizeof(*work));                                           
  work->func = func;                                                            
  work->arg  = arg;                                                             
  work->next = NULL;                                                            
  return work;                                                                  
}                                                                               
                                                                                
// -------------------------------- Simple helper for destroying work objects.  
static void tpool_work_unit_destroy(tpool_work_unit_t *work)                              
{                                                                               
  if (work == NULL)                                                             
    return;                                                                     
  free(work);                                                                   
}                                                 

// --------------------------------------------------------- GET WORK FUNCTION  
// Handles pulling an object from the list and                                  
//   maintain the list work_head and work_tail references.                      
static tpool_work_unit_t *tpool_work_unit_get(tpool_work_queue_t *wq)                                
{                                                                               
  tpool_work_unit_t *work;                                                           
                                                                                
  if (wq == NULL)                                                               
    return NULL;                                                                
                                                                                
  work = wq->work_head;                                                         
  if (work == NULL)                                                             
    return NULL;                                                                
                                                                                
  if (work->next == NULL) {                                                     
    wq->work_head = NULL;                                                       
    wq->work_tail = NULL;                                                       
  } else {                                                                      
    wq->work_head = work->next;                                                 
  }                                                                             
                                                                                
  return work;                                                                  
}                                                                               
                                                                                
// ----------------------------------------------------------- WORKER FUNCTION  
// At a high level: this function waits for work and processes it.              
static void *tpool_worker(void *arg)                                            
{                                                                               
  tpool_work_queue_t  *wq = arg;                                                       
  tpool_work_unit_t   *work;                                                           
                                                                                
  // This will keep the tread running until exit.                               
  while (1) {                                                                   
    // Locking the mutex so nothing manipulates the pool’s members.             
    pthread_mutex_lock(&(wq->work_mutex));                                      
                                                                                
    // Check if any work available for processing.                              
    while (wq->work_head == NULL && !wq->stop)                                  
      pthread_cond_wait(&(wq->work_cond), &(wq->work_mutex));                   
                                                                                
    // Check if the pool has requested that all threads stop and exit.          
    if (wq->stop)                                                               
      break;                                                                    
    // The thread was signaled there is work.                                   
    work = tpool_work_unit_get(wq);                                                  
    wq->working_cnt++;                                                          
    pthread_mutex_unlock(&(wq->work_mutex));                                    
                                                                                
    // If there was work, process it and destroy the work object.               
    if (work != NULL) {                                                         
      work->func(work->arg);                                                    
      tpool_work_unit_destroy(work);                                                 
    }                                                                           
                                                                                
    // The work has been processed.                                             
    pthread_mutex_lock(&(wq->work_mutex));                                      
    wq->working_cnt--;                                                          
    if (!wq->stop && wq->working_cnt == 0 && wq->work_head == NULL)             
      pthread_cond_signal(&(wq->working_cond));                                 
    pthread_mutex_unlock(&(wq->work_mutex));                                    
  }                                                                             
                                                                                
  // Arrival from break out.                                                    
  wq->num_threads--;                                                            
  pthread_cond_signal(&(wq->working_cond));                                     
  pthread_mutex_unlock(&(wq->work_mutex));                                      
  return NULL;                                                                  
}   

// ------------------------------------------------------ POOL CREATE FUNCTION  
tpool_work_queue_t *tpool_create(size_t num)                                               
{                                                                               
  tpool_work_queue_t   *wq;                                                                
  pthread_t  thread;                                                            
  size_t     i;                                                                 
                                                                                
  // The minumum acceptable number of threads is two threads.                   
  if (num == 0)                                                                 
    num = 2;                                                                    
  // XXX:IDEA: May set the number of core/processors + 1 as the default...      
                                                                                
  wq              = calloc(1, sizeof(*wq));                                     
  wq->num_threads = num;                                                        
                                                                                
  pthread_mutex_init(&(wq->work_mutex), NULL);                                  
  pthread_cond_init(&(wq->work_cond), NULL);                                    
  pthread_cond_init(&(wq->working_cond), NULL);                                 
                                                                                
  wq->work_head = NULL;                                                         
  wq->work_tail = NULL;                                                         
                                                                                
  // The requested threads are started and tpool_worker is specified.           
  for (i=0; i<num; i++) {                                                       
    // Start num of threads; tpool_worker is specified as the thread function.  
    pthread_create(&thread, NULL, tpool_worker, wq);                            
    // XXX: Did NOT store the thread ids; they are not accessed directly.       
    //      If we wanted to implement some kind of force exit,                  
    //      instead of having to wait then we’d need to track the ids.          
    pthread_detach(thread);                                                     
  }                                                                             
                                                                                
  return wq;                                                                    
}                                                                               
                                                                                
// ----------------------------------------------------- POOL DESTROY FUNCTION  
void tpool_destroy(tpool_work_queue_t *wq)                                                 
{                                                                               
  tpool_work_unit_t *work;                                                           
  tpool_work_unit_t *work2;                                                          
                                                                                
  if (wq == NULL)                                                               
    return;                                                                     
                                                                                
  // Throwing away all pending work; caller BEWARE!!!                           
  pthread_mutex_lock(&(wq->work_mutex));                                        
  work = wq->work_head;                                                         
  while (work != NULL) {                                                        
    work2 = work->next;                                                         
    tpool_work_unit_destroy(work);                                                   
    work = work2;                                                               
  }                                                                             
                                                                                
  // Cleaned up the queue; tell the threads they need to stop.                  
  wq->stop = true;                                                              
  pthread_cond_broadcast(&(wq->work_cond));                                     
  pthread_mutex_unlock(&(wq->work_mutex));                                      
                                                                                
  // Wait for the processing threads to finish.                                 
  tpool_wait(wq);                                                               
                                                                                
  pthread_mutex_destroy(&(wq->work_mutex));                                     
  pthread_cond_destroy(&(wq->work_cond));                                       
  pthread_cond_destroy(&(wq->working_cond));                                    
                                                                                
  free(wq);                                                                     
}     

// ---
/*enrty func
{
 // asm get ret
 tpool_add_work()

}
*/

// -------------------------------------------------- Adding work to the queue  
bool tpool_add_work(tpool_work_queue_t *wq, thread_func_t func, void *arg)                 
{    
  /*
   * calculate number of bytes in func to travel up the stack by 
   *    tpool_work_queue_t *wq, thread_func_t func, void *arg
   *
   * 
   * __asm__
   *   get rtrn adrr
   *   
   */
                                                                            
  tpool_work_unit_t *work;                                                           
                                                                                
  if (wq == NULL)                                                               
    return false;                                                               
                                                                                
  // Creating a work object.                                                    
  work = tpool_work_unit_create(func, arg);                                          
  if (work == NULL)                                                             
    return false;                                                               
                                                                                
  pthread_mutex_lock(&(wq->work_mutex));                                        
  // Adding the object to the linked list.                                      
  if (wq->work_head == NULL) {                                                  
    wq->work_head = work;                                                       
    wq->work_tail = wq->work_head;                                              
  } else {                                                                      
    wq->work_tail->next = work;                                                 
    wq->work_tail       = work;                                                 
  }                                                                             
                                                                                
  pthread_cond_broadcast(&(wq->work_cond));                                     
  pthread_mutex_unlock(&(wq->work_mutex));                                      
                                                                                
  return true;                                                                  
}                                                                               
                                                                                
// ---------------------------------------- Waiting for processing to complete  
void tpool_wait(tpool_work_queue_t *wq)                                                    
{                                                                               
  if (wq == NULL) // Will only return when there is no work.                    
    return;                                                                     
                                                                                
  pthread_mutex_lock(&(wq->work_mutex));                                        
  while (1) {                                                                   
    if ((!wq->stop && wq->working_cnt != 0) ||                                  
        (wq->stop && wq->num_threads != 0)) {                                   
      pthread_cond_wait(&(wq->working_cond), &(wq->work_mutex));                
    } else {                                                                    
      break;                                                                    
    }                                                                           
  }                                                                             
  pthread_mutex_unlock(&(wq->work_mutex));                                      
} 

#endif /* __THREADPOOL_H__ */
