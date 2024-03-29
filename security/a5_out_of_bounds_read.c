/*  Benchmark: Out-of-Bounds Read
 *  @author  : Secure, Trusted, and Assured Microelectronics (STAM) Center 
 *             Adaptated by Mert Side for TTU
 *  @brief   : This benchmark is a simple test to demonstrate an out-of-bounds read.
 * 
 *  Copyright (c) 2023 Trireme (STAM/SCAI/ASU)
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.

 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "xbrtime_morello.h"

int main() {

  printf("Starting test: OOB Read\n");
  
  int test_status = 1;

  xbrtime_init();

  int num_pes = xbrtime_num_pes();

  // char *public     = (char *)malloc(6);
  int pub_len = 6;
  char *public     = (char *)xbrtime_malloc(pub_len * sizeof(char) * num_pes);
  strcpy(public, "public");

  // char *private    = (char *)malloc(14);
  int priv_len = 14;
  char *private    = (char *)xbrtime_malloc(priv_len * sizeof(char) * num_pes);
  strcpy(private, "secretpassword");

  for( int j = 0; j < num_pes; j++ ){

      int offset = private-public;
      //  printf("Offset of private array w.r.t public array: %d\n", offset);
      
      printf("Printing characters of public array\n");
      for(int i=0;i<pub_len;i++) {
              printf("%c", public[j*num_pes+i]);
      }
      printf("\n");

      printf("Printing characters of private array from public array\n");
      for(int i=0;i<priv_len;i++) {
              printf("%c", public[j*num_pes+i+offset]);
        if(public[i+offset] == private[j*num_pes+i])
          test_status = 0;
      }
      printf("\n");

      if(test_status == 0)
        printf("Test Failed: OOB Read\n\n");
    
  }

  return 0;
}
