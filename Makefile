CC=/home/parallels/cheri/cheri-exercises/tools/ccc
ARCH=morello-purecap
DIR=/home/parallels//cheri/output/rootfs-morello-purecap/mert_files/xbrtime-simple

all: matMul gather

matMul:
	$(CC) $(ARCH) -o $(DIR)/matmul_M.exe $(DIR)/matmul_M.c $(DIR)/xbMrtime_api_asm.s

gather:
	$(CC) $(ARCH) -o $(DIR)/gather_M.exe $(DIR)/gather_M.c $(DIR)/xbMrtime_api_asm.s

clean:
	rm -f ./*.o ./*.exe
