CCOM = /usr/local64/llvm-morello/bin/clang
INCLUDES = -I../../runtime
ASM = ../../runtime/xbMrtime_api_asm.s
CFLAGS = -O0 -lpthread -lm -Iruntime
MY_CC = $(CCOM) $(CFLAGS) $(INCLUDES) $(ASM)

all: ttuC1B ttuC2B ttuC3B ttuC4B ttuC5B

ttuC1B:
	$(MY_CC) -o ttu_c1_baseline_use_of_freed_memory.exe ttu_c1_baseline_use_of_freed_memory.c
ttuC2B:
	$(MY_CC) -o ttu_c2_baseline_race_condition.exe ttu_c2_baseline_race_condition.c
ttuC3B:
	$(MY_CC) -o ttu_c3_baseline_memory_leak.exe ttu_c3_baseline_memory_leak.c
ttuC4B:
	$(MY_CC) -o ttu_c4_control_flow.exe ttu_c4_control_flow.c
ttuC5B:
	$(MY_CC) -o ttu_c5_rop.exe ttu_c5_rop.c

clean:
	rm -f ./*.o ./*.exe ./*.core
