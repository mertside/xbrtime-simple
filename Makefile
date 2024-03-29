CCOM=~/cheri/cheri-exercises/tools/ccc
ARCH=morello-purecap
MY_CC?=$(CCOM) $(ARCH)
#DIR=~/cheri/output/rootfs-morello-purecap/mert_files/xbrtime-simple

all: matMul gather gupsM broadcast reduction pointer control oobR injection temporal uaf ptrRvk

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

pointer:
	$(MY_CC) -O0 -lpthread -o ptr_over_pipe.exe security/ptr_over_pipe.c runtime/xbMrtime_api_asm.s -lm -Iruntime

injection:
	$(MY_CC) -O0 -lpthread -o ptr_injection.exe security/ptr_injection.c runtime/xbMrtime_api_asm.s -lm -Iruntime

temporal:
	$(MY_CC) -O0 -lpthread -o temporal_control.exe security/temporal_control.c runtime/xbMrtime_api_asm.s -lm -Iruntime

uaf:
	$(MY_CC) -O0 -lpthread -o uaf.exe security/uaf.c runtime/xbMrtime_api_asm.s -lm -Iruntime

ptrRvk:
	$(MY_CC) -O0 -lpthread -o ptr_rvk_tmprl_cntrl.exe security/ptr_rvk_tmprl_cntrl.c runtime/xbMrtime_api_asm.s -lm -Iruntime

test:
	./matmul.exe
	./gather.exe
	./broadcast8_demo.exe
	./reduction8_demo.exe
	./control_flow.exe
	./oob_read.exe
	./uaf.exe
	./temporal_control.exe
	./ptr_over_pipe.exe
	./ptr_injection.exe
	./ptr_rvk_tmprl_cntrl.exe

clean:
	rm -f ./*.o ./*.exe
