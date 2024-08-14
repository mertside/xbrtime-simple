CCOM = cc
# CCOM = /usr/local64/llvm-morello/bin/clang
# CFLAGS = -O0 -lpthread -lm -Iruntime
CFLAGS = -g -O2 -Wall -lpthread -lm
INCLUDES = -I../../runtime
ASM = ../../runtime/xbMrtime_api_asm.s
MY_CC = $(CCOM) $(CFLAGS) $(INCLUDES) $(ASM)
#DIR=~/cheri/output/rootfs-morello-purecap/mert_files/xbrtime-simple

all: matMul gather gupsM broadcast reduction gupsM

matMul:
	$(MY_CC) -o matmul.exe matmul_M.c

gather:
	$(MY_CC) -o gather.exe gather_M.c

gupsM:
	$(MY_CC) -o gups.exe SHMEMRandomAccess.c

broadcast:
	$(MY_CC) -o broadcast8_demo.exe broadcast8_demo.c

reduction:
	$(MY_CC) -o reduction8_demo.exe reduction8_demo.c

test:
	./matmul.exe
	./gather.exe
	./broadcast8_demo.exe
	./reduction8_demo.exe
	./gups.exe

clean:
	rm -f ./*.o ./*.exe
