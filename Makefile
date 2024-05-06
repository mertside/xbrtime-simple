CCOM=~/cheri/cheri-exercises/tools/ccc
ARCH=morello-purecap
MY_CC?=$(CCOM) $(ARCH)
#DIR=~/cheri/output/rootfs-morello-purecap/mert_files/xbrtime-simple

all: matMul gather gupsM broadcast reduction a1 a2 a3 a4 a5 a6 a7 c4a c4b c5a c5b c6

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

a1:
	$(MY_CC) -O0 -lpthread -o a1_double_free.exe security/a1_double_free.c runtime/xbMrtime_api_asm.s -lm -Iruntime

a2:
	$(MY_CC) -O0 -lpthread -o a2_free_not_at_start.exe security/a2_free_not_at_start.c runtime/xbMrtime_api_asm.s -lm -Iruntime

a3:
	$(MY_CC) -O0 -lpthread -o a3_free_not_on_heap.exe security/a3_free_not_on_heap.c runtime/xbMrtime_api_asm.s -lm -Iruntime

a4:
	$(MY_CC) -O0 -lpthread -o a4_null_ptr_dereference.exe security/a4_null_ptr_dereference.c runtime/xbMrtime_api_asm.s -lm -Iruntime

a5:
	$(MY_CC) -O0 -lpthread -o a5_out_of_bounds_read.exe security/a5_out_of_bounds_read.c runtime/xbMrtime_api_asm.s -lm -Iruntime

a6:
	$(MY_CC) -O0 -lpthread -o a6_out_of_bounds_write.exe security/a6_out_of_bounds_write.c runtime/xbMrtime_api_asm.s -lm -Iruntime

a7:
	$(MY_CC) -O0 -lpthread -o a7_use_after_free.exe security/a7_use_after_free.c runtime/xbMrtime_api_asm.s -lm -Iruntime

c4a:
	$(MY_CC) -O0 -lpthread -o c4_control_flow.exe security/c4_control_flow.c runtime/xbMrtime_api_asm.s -lm -Iruntime

c4b:
	$(MY_CC) -O0 -lpthread -o c4_temporal_control.exe security/c4_temporal_control.c runtime/xbMrtime_api_asm.s -lm -Iruntime

c5a:
	$(MY_CC) -O0 -lpthread -o c5_ptr_injection.exe security/c5_ptr_injection.c runtime/xbMrtime_api_asm.s -lm -Iruntime
	
c5b:
	$(MY_CC) -O0 -lpthread -o c5_ptr_over_pipe.exe security/c5_ptr_over_pipe.c runtime/xbMrtime_api_asm.s -lm -Iruntime

c6:
	$(MY_CC) -O0 -lpthread -o c6_ptr_rvk_tmprl_cntrl.exe security/c6_ptr_rvk_tmprl_cntrl.c runtime/xbMrtime_api_asm.s -lm -Iruntime

m1:
	$(MY_CC) -O0 -lpthread -o m1_double_free.exe security/m1_double_free.c runtime/xbMrtime_api_asm.s -lm -Iruntime

m2:	
	$(MY_CC) -O0 -lpthread -o m2_free_not_at_start.exe security/m2_free_not_at_start.c runtime/xbMrtime_api_asm.s -lm -Iruntime

m4:
	$(MY_CC) -O0 -lpthread -o m4_null_ptr_dereference.exe security/m4_null_ptr_dereference.c runtime/xbMrtime_api_asm.s -lm -Iruntime

m7:
	$(MY_CC) -O0 -lpthread -o m7_use_after_free.exe security/m7_use_after_free.c runtime/xbMrtime_api_asm.s -lm -Iruntime

test:
	./matmul.exe
	./gather.exe
	./broadcast8_demo.exe
	./reduction8_demo.exe
	./a1_double_free.exe
	./a2_free_not_at_start.exe
	./a3_free_not_on_heap.exe
	./a4_null_ptr_dereference.exe
	./a5_out_of_bounds_read.exe
	./a6_out_of_bounds_write.exe
	./a7_use_after_free.exe
	./c4_control_flow.exe
	./c4_temporal_control.exe
	./c5_ptr_injection.exe
	./c5_ptr_over_pipe.exe
	./c6_ptr_rvk_tmprl_cntrl.exe
	./m1_double_free.exe
	./m2_free_not_at_start.exe
	./m4_null_ptr_dereference.exe
	./m7_use_after_free.exe

clean:
	rm -f ./*.o ./*.exe
