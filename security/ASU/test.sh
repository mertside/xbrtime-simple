#!/bin/sh

echo "Running ASU tests"

# Save all the output for ASU including segmenation faults and other errors

# ./asu_t3_hm_house_of_spirit.exe > asu_t3.out.txt 2> asu_t3.err.txt

echo "ASU_T1:"
asuT1=`./asu_t1_double_free.exe 2>&1`;
echo "$asuT1"

echo "ASU_T2:"
asuT2=`./asu_t2_hm_fake_chunk_malloc.exe 2>&1`;
echo "$asuT2"

echo "ASU_T3:"
asuT3=`./asu_t3_hm_house_of_spirit.exe 2>&1`;
echo "$asuT3"

echo "ASU_T4:"
asuT4=`./asu_t4_hm_parent_and_child_chunk.exe 2>&1`;
echo "$asuT4"

echo "ASU_T5:"
asuT5=`./asu_t5_use_after_free.exe 2>&1`;
echo "$asuT5"


# asuS1=`./asu_s1_free_not_at_start.exe 2>&1`; echo "ASU_S1:$asuS1" > asu_s1_free_not_at_start.txt
# asuS2=`./asu_s2_free_not_on_heap.exe 2>&1`; echo "ASU_S2:$asuS2" > asu_s2_free_not_on_heap.txt
# asuS3=`./asu_s3_null_ptr_dereference.exe 2>&1`; echo "ASU_S3:$asuS3" > asu_s3_null_ptr_dereference.txt
# asuS4=`./asu_s4_oob_read.exe 2>&1`; echo "ASU_S4:$asuS4" > asu_s4_oob_read.txt
# asuS5=`./asu_s5_oob_write.exe 2>&1`; echo "ASU_S5:$asuS5" > asu_s5_oob_write.txt

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