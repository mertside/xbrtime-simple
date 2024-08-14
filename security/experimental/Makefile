CCOM = cc
# CCOM = /usr/local64/llvm-morello/bin/clang
# CFLAGS = -O0 -lpthread -lm -Iruntime
CFLAGS = -g -O2 -Wall -lpthread -lm
INCLUDES = -I../../runtime
ASM = ../../runtime/xbMrtime_api_asm.s
MY_CC = $(CCOM) $(CFLAGS) $(INCLUDES) $(ASM)

all: ttuC1B ttuC4B ttuC5B ttuC6B

ttuC1B:
	$(MY_CC) -o ttu_c1_baseline_use_of_freed_memory.exe ttu_c1_baseline_use_of_freed_memory.c
ttuC2B:
	$(MY_CC) -o ttu_c2_baseline_race_condition.exe ttu_c2_baseline_race_condition.c
ttuC3B:
	$(MY_CC) -o ttu_c3_baseline_memory_leak.exe ttu_c3_baseline_memory_leak.c
ttuC4B:
	$(MY_CC) -o ttu_c4_baseline_control_flow.exe ttu_c4_baseline_control_flow.c
ttuC5B:
	$(MY_CC) -o ttu_c5_baseline_rop.exe ttu_c5_baseline_rop.c
ttuC6B:
	$(MY_CC) -o ttu_c6_baseline_use_after_realloc.exe ttu_c6_baseline_use_after_realloc.c

clean:
	rm -f ./*.o ./*.exe ./*.core
