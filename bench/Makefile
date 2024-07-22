CCOM=/usr/local64/llvm-morello/bin/clang
#CCOM=~/old_workspace/cheri/cheri-exercises/tools/ccc
#CCOM=~/cheri/cheri-exercises/tools/ccc
ARCH=morello-purecap
MY_CC?=$(CCOM) #$(ARCH)
#DIR=~/cheri/output/rootfs-morello-purecap/mert_files/xbrtime-simple

all: matMul gather gupsM broadcast reduction gupsM

matMul:
	$(MY_CC) -O0 -lpthread -o matmul.exe matmul_M.c runtime/xbMrtime_api_asm.s -lm -Iruntime

gather:
	$(MY_CC) -O0 -lpthread -o gather.exe gather_M.c runtime/xbMrtime_api_asm.s -lm -Iruntime

gupsM:
	$(MY_CC) -O0 -lpthread -o gups.exe SHMEMRandomAccess.c runtime/xbMrtime_api_asm.s -lm -Iruntime

broadcast:
	$(MY_CC) -O0 -lpthread -o broadcast8_demo.exe broadcast8_demo.c runtime/xbMrtime_api_asm.s -lm -Iruntime

reduction:
	$(MY_CC) -O0 -lpthread -o reduction8_demo.exe reduction8_demo.c runtime/xbMrtime_api_asm.s -lm -Iruntime

test:
	./matmul.exe
	./gather.exe
	./broadcast8_demo.exe
	./reduction8_demo.exe
	./gups.exe

clean:
	rm -f ./*.o ./*.exe
