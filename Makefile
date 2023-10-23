CCOM=~/cheri/cheri-exercises/tools/ccc
ARCH=morello-purecap
MY_CC?=$(CCOM) $(ARCH)
#DIR=~/cheri/output/rootfs-morello-purecap/mert_files/xbrtime-simple

all: matMul gather gupsM

matMul:
	$(MY_CC) -O0 -lpthread -o matmul.exe matmul_M.c xbMrtime_api_asm.s

gather:
	$(MY_CC) -O0 -lpthread -o gather.exe gather_M.c xbMrtime_api_asm.s

gupsM:
	$(MY_CC) -O0 -lpthread -o gups.exe SHMEMRandomAccess.c xbMrtime_api_asm.s

clean:
	rm -f ./*.o ./*.exe
