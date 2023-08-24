CCOM=~/cheri/cheri-exercises/tools/ccc
ARCH=morello-purecap
MY_CC?=$(CCOM) $(ARCH)
#DIR=~/cheri/output/rootfs-morello-purecap/mert_files/xbrtime-simple

all: matMul gather

matMul:
	$(MY_CC) -O0 -lpthread -o matmul_M.exe matmul_M.c xbMrtime_api_asm.s

gather:
	$(MY_CC) -O0 -lpthread -o gather_M.exe gather_M.c xbMrtime_api_asm.s

matMul2:
	$(MY_CC) -O0 -lpthread -o matmul_M_v2.exe matmul_M_v2.c xbMrtime_api_asm.s

clean:
	rm -f ./*.o ./*.exe
