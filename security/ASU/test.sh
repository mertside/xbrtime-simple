#!/bin/sh

echo "Running ASU tests"

# Save all the output for ASU including segmenation faults and other errors

asuT1=`./asu_t1_double_free.exe 2>&1`; echo "$asuT1" > asu_t1_double_free.txt
asuT2=`./asu_t2_hm_fake_chunk_malloc.exe 2>&1`; echo "$asuT2" > asu_t2_hm_fake_chunk_malloc.txt
asuT3=`./asu_t3_hm_house_of_spirit.exe 2>&1`; echo "$asuT3" > asu_t3_hm_house_of_spirit.txt
asuT4=`./asu_t4_hm_parent_and_child_chunk.exe 2>&1`; echo "$asuT4" > asu_t4_hm_parent_and_child_chunk.txt
asuT5=`./asu_t5_use_after_free.exe 2>&1`; echo "$asuT5" > asu_t5_use_after_free.txt

asuS1=`./asu_s1_free_not_at_start.exe 2>&1`; echo "$asuS1" > asu_s1_free_not_at_start.txt
asuS2=`./asu_s2_free_not_on_heap.exe 2>&1`; echo "$asuS2" > asu_s2_free_not_on_heap.txt
asuS3=`./asu_s3_null_ptr_dereference.exe 2>&1`; echo "$asuS3" > asu_s3_null_ptr_dereference.txt
asuS4=`./asu_s4_oob_read.exe 2>&1`; echo "$asuS4" > asu_s4_oob_read.txt
asuS5=`./asu_s5_oob_write.exe 2>&1`; echo "$asuS5" > asu_s5_oob_write.txt

# ./asu_s2_free_not_on_heap.exe
# ./asu_s3_null_ptr_dereference.exe
# ./asu_s4_oob_read.exe
# ./asu_s5_oob_write.exe
# ./asu_t1_double_free.exe
# ./asu_t2_hm_fake_chunk_malloc.exe
# ./asu_t3_hm_house_of_spirit.exe
# ./asu_t4_hm_parent_and_child_chunk.exe
# ./asu_t5_use_after_free.exe
# ./asu_r1_heartbleed.exe
# ./asu_r2_dop.exe
# ./asu_r3_uaf_to_code_reuse.exe
# ./asu_r4_ip_large_size.exe
# ./asu_r5_df_switch_statements.exe