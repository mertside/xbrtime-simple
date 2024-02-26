CCOM=~/cheri/cheri-exercises/tools/ccc
ARCH=morello-purecap
MY_CC?=$(CCOM) $(ARCH)
#DIR=~/cheri/output/rootfs-morello-purecap/mert_files/xbrtime-simple

all: matMul gather gupsM broadcast reduction

matMul:
	$(MY_CC) -O0 -lpthread -o matmul.exe bench/matmul_M.c runtime/xbMrtime_api_asm.s -lm -Iruntime

gather:
	$(MY_CC) -O0 -lpthread -o gather.exe bench/gather_M.c runtime/xbMrtime_api_asm.s -lm -Iruntime

gupsM:
	$(MY_CC) -O0 -lpthread -o gups.exe bench/SHMEMRandomAccess.c runtime/xbMrtime_api_asm.s -lm -Iruntime

broadcast:
	$(MY_CC) -O0 -lpthread -o broadcast8_demo.exe bench/broadcast8_demo.c runtime/xbMrtime_api_asm.s -lm -Iruntime

reduction:
	$(MY_CC) -O0 -lpthread -o reduction8_demo.exe bench/reduction8_demo.c runtime/xbMrtime_api_asm.s -lm -Iruntime

control:
	$(MY_CC) -O0 -lpthread -o control_flow.exe security/control_flow.c runtime/xbMrtime_api_asm.s -lm -Iruntime

oobR:
	$(MY_CC) -O0 -lpthread -o oob_read.exe security/oob_read.c runtime/xbMrtime_api_asm.s -lm -Iruntime

test:
	./matmul.exe
	./gather.exe
	./broadcast8_demo.exe
	./reduction8_demo.exe

clean:
	rm -f ./*.o ./*.exe
