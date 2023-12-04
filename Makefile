CCOM=~/cheri/cheri-exercises/tools/ccc
ARCH=morello-purecap
MY_CC?=$(CCOM) $(ARCH)
#DIR=~/cheri/output/rootfs-morello-purecap/mert_files/xbrtime-simple

all: matMul gather gupsM broadcast reduction

matMul:
	$(MY_CC) -O0 -lpthread -o matmul.exe matmul_M.c xbMrtime_api_asm.s -lm

gather:
	$(MY_CC) -O0 -lpthread -o gather.exe gather_M.c xbMrtime_api_asm.s -lm

gupsM:
	$(MY_CC) -O0 -lpthread -o gups.exe SHMEMRandomAccess.c xbMrtime_api_asm.s -lm

broadcast:
	$(MY_CC) -O0 -lpthread -o broadcast8_demo.exe broadcast8_demo.c xbMrtime_api_asm.s -lm

reduction:
	$(MY_CC) -O0 -lpthread -o reduction8_demo.exe reduction8_demo.c xbMrtime_api_asm.s -lm

test:
	./matmul.exe
	./gather.exe
	./broadcast8_demo.exe
	./reduction8_demo.exe

clean:
	rm -f ./*.o ./*.exe
