CCOM=/usr/local64/llvm-morello/bin/clang
MY_CC?=$(CCOM)

all: asuS1 asuS2 asuS3 asuS4 asuS5 asuT1 asuT2 asuT3 asuT4 asuT5 asuR1 asuR2 asuR3 asuR4 asuR5

temporal: asuT1 asuT2 asuT3 asuT4 asuT5

spatial: asuS1 asuS2 asuS3 asuS4 asuS5

real: asuR1 asuR2 asuR3 asuR4 asuR5

asuS1:
	$(MY_CC) -O0 -lpthread -o asu_s1_free_not_at_start.exe asu_s1_free_not_at_start.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuS2:
	$(MY_CC) -O0 -lpthread -o asu_s2_free_not_on_heap.exe asu_s2_free_not_on_heap.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuS3:
	$(MY_CC) -O0 -lpthread -o asu_s3_null_ptr_dereference.exe asu_s3_null_ptr_dereference.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuS4:
	$(MY_CC) -O0 -lpthread -o asu_s4_oob_read.exe asu_s4_oob_read.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuS5:
	$(MY_CC) -O0 -lpthread -o asu_s5_oob_write.exe asu_s5_oob_write.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuT1:
	$(MY_CC) -O0 -lpthread -o asu_t1_double_free.exe asu_t1_double_free.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuT2:
	$(MY_CC) -O0 -lpthread -o asu_t2_hm_fake_chunk_malloc.exe asu_t2_hm_fake_chunk_malloc.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuT3:
	$(MY_CC) -O0 -lpthread -o asu_t3_hm_house_of_spirit.exe asu_t3_hm_house_of_spirit.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuT4:
	$(MY_CC) -O0 -lpthread -o asu_t4_hm_parent_and_child_chunk.exe asu_t4_hm_parent_and_child_chunk.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuT5:
	$(MY_CC) -O0 -lpthread -o asu_t5_use_after_free.exe asu_t5_use_after_free.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuR1:
	$(MY_CC) -O0 -lpthread -o asu_r1_heartbleed.exe asu_r1_heartbleed.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuR2:
	$(MY_CC) -O0 -lpthread -o asu_r2_dop.exe asu_r2_dop.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuR3:
	$(MY_CC) -O0 -lpthread -o asu_r3_uaf_to_code_reuse.exe asu_r3_uaf_to_code_reuse.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuR4:
	$(MY_CC) -O0 -lpthread -o asu_r4_ip_large_size.exe asu_r4_ip_large_size.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

asuR5:
	$(MY_CC) -O0 -lpthread -o asu_r5_df_switch_statements.exe asu_r5_df_switch_statements.c ../../runtime/xbMrtime_api_asm.s -lm -Iruntime

runS:
	./asu_s1_free_not_at_start.exe
	./asu_s2_free_not_on_heap.exe
	./asu_s3_null_ptr_dereference.exe
	./asu_s4_oob_read.exe
	./asu_s5_oob_write.exe

runT:
	./asu_t1_double_free.exe
	./asu_t2_hm_fake_chunk_malloc.exe
	./asu_t3_hm_house_of_spirit.exe
	./asu_t4_hm_parent_and_child_chunk.exe
	./asu_t5_use_after_free.exe

runR:
	./asu_r1_heartbleed.exe
	./asu_r2_dop.exe
	./asu_r3_uaf_to_code_reuse.exe
	./asu_r4_ip_large_size.exe
	./asu_r5_df_switch_statements.exe

runA:
	./asu_s1_free_not_at_start.exe
	./asu_s2_free_not_on_heap.exe
	./asu_s3_null_ptr_dereference.exe
	./asu_s4_oob_read.exe
	./asu_s5_oob_write.exe
	./asu_t1_double_free.exe
	./asu_t2_hm_fake_chunk_malloc.exe
	./asu_t3_hm_house_of_spirit.exe
	./asu_t4_hm_parent_and_child_chunk.exe
	./asu_t5_use_after_free.exe
	./asu_r1_heartbleed.exe
	./asu_r2_dop.exe
	./asu_r3_uaf_to_code_reuse.exe
	./asu_r4_ip_large_size.exe
	./asu_r5_df_switch_statements.exe

clean:
	rm -f ./*.o ./*.exe
