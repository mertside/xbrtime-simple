CCOM = /usr/local64/llvm-morello/bin/clang
INCLUDES = -I ../../runtime/xbrtime_morello.h
CFLAGS = -O0 -lpthread -lm -Iruntime
MY_CC = $(CCOM) $(CFLAGS) $(INCLUDES)

all: ttuS1 ttuS2 ttuS3 ttuS4 ttuS5 ttuT1 ttuT2 ttuT3 ttuT4 ttuT5 ttuR1 ttuR2 ttuR3 ttuR4 ttuR5

temporal: ttuT1 ttuT2 ttuT3 ttuT4 ttuT5

spatial: ttuS1 ttuS2 ttuS3 ttuS4 ttuS5

real: ttuR1 ttuR2 ttuR3 ttuR4 ttuR5

ttuS1:
	$(MY_CC) -o ttu_s1_free_not_at_start.exe ttu_s1_free_not_at_start.c ../../runtime/xbMrtime_api_asm.s

ttuS2:
	$(MY_CC) -o ttu_s2_free_not_on_heap.exe ttu_s2_free_not_on_heap.c ../../runtime/xbMrtime_api_asm.s

ttuS3:
	$(MY_CC) -o ttu_s3_null_ptr_dereference.exe ttu_s3_null_ptr_dereference.c ../../runtime/xbMrtime_api_asm.s

ttuS4:
	$(MY_CC) -o ttu_s4_OoB_r.exe ttu_s4_OoB_r.c ../../runtime/xbMrtime_api_asm.s

ttuS5:
	$(MY_CC) -o ttu_s5_OoB_w.exe ttu_s5_OoB_w.c ../../runtime/xbMrtime_api_asm.s

ttuT1:
	$(MY_CC) -o ttu_t1_double_free.exe ttu_t1_double_free.c ../../runtime/xbMrtime_api_asm.s

ttuT2:
	$(MY_CC) -o ttu_t2_hm_fake_chunk_malloc.exe ttu_t2_hm_fake_chunk_malloc.c ../../runtime/xbMrtime_api_asm.s

ttuT3:
	$(MY_CC) -o ttu_t3_hm_house_of_spirit.exe ttu_t3_hm_house_of_spirit.c ../../runtime/xbMrtime_api_asm.s

ttuT4:
	$(MY_CC) -o ttu_t4_hm_p_and_c_chunk.exe ttu_t4_hm_p_and_c_chunk.c ../../runtime/xbMrtime_api_asm.s

ttuT5:
	$(MY_CC) -o ttu_t5_use_after_free.exe ttu_t5_use_after_free.c ../../runtime/xbMrtime_api_asm.s

ttuR1:
	$(MY_CC) -o ttu_r1_HeartBleed.exe ttu_r1_HeartBleed.c ../../runtime/xbMrtime_api_asm.s

ttuR2:
	$(MY_CC) -o ttu_r2_dop.exe ttu_r2_dop.c ../../runtime/xbMrtime_api_asm.s

ttuR3:
	$(MY_CC) -o ttu_r3_uaf_to_code_reuse.exe ttu_r3_uaf_to_code_reuse.c ../../runtime/xbMrtime_api_asm.s

ttuR4:
	$(MY_CC) -o ttu_r4_illegal_ptr_deref.exe ttu_r4_illegal_ptr_deref.c ../../runtime/xbMrtime_api_asm.s

ttuR5:
	$(MY_CC) -o ttu_r5_df_switch.exe ttu_r5_df_switch.c ../../runtime/xbMrtime_api_asm.s

runS:
	./ttu_s1_free_not_at_start.exe
	./ttu_s2_free_not_on_heap.exe
	./ttu_s3_null_ptr_dereference.exe
	./ttu_s4_OoB_r.exe
	./ttu_s5_OoB_w.exe

runT:
	./ttu_t1_double_free.exe
	./ttu_t2_hm_fake_chunk_malloc.exe
	./ttu_t3_hm_house_of_spirit.exe
	./ttu_t4_hm_p_and_c_chunk.exe
	./ttu_t5_use_after_free.exe

runR:
	./ttu_r1_HeartBleed.exe
	./ttu_r2_dop.exe
	./ttu_r3_uaf_to_code_reuse.exe
	./ttu_r4_illegal_ptr_deref.exe
	./ttu_r5_df_switch.exe

runA:
	./ttu_s1_free_not_at_start.exe
	./ttu_s2_free_not_on_heap.exe
	./ttu_s3_null_ptr_dereference.exe
	./ttu_s4_OoB_r.exe
	./ttu_s5_OoB_w.exe
	./ttu_t1_double_free.exe
	./ttu_t2_hm_fake_chunk_malloc.exe
	./ttu_t3_hm_house_of_spirit.exe
	./ttu_t4_hm_p_and_c_chunk.exe
	./ttu_t5_use_after_free.exe
	./ttu_r1_HeartBleed.exe
	./ttu_r2_dop.exe
	./ttu_r3_uaf_to_code_reuse.exe
	./ttu_r4_illegal_ptr_deref.exe
	./ttu_r5_df_switch.exe

clean:
	rm -f ./*.o ./*.exe
