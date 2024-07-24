#!/bin/sh
echo "============================================================"
echo "Running ASU tests" 

date

export NUM_OF_THREADS=4

# ----------------------------------------------------------------------------
echo "============================================================"
echo " "

echo "------------------------------"
echo "ASU_T1:"
asuT1=`./asu_t1_double_free.exe`;
echo "$asuT1"
echo " "

echo "------------------------------"
echo "ASU_T2:"
asuT2=`./asu_t2_hm_fake_chunk_malloc.exe`;
echo "$asuT2"
echo " "

echo "------------------------------"
echo "ASU_T3:"
asuT3=`./asu_t3_hm_house_of_spirit.exe`;
echo "$asuT3"
echo " "

echo "------------------------------"
echo "ASU_T4:"
asuT4=`./asu_t4_hm_parent_and_child_chunk.exe`;
echo "$asuT4"
echo " "

echo "------------------------------"
echo "ASU_T5:"
asuT5=`./asu_t5_use_after_free.exe`;
echo "$asuT5"
echo " "

# ----------------------------------------------------------------------------
echo "============================================================"
echo " "

echo "------------------------------"
echo "ASU_S1:"
asuS1=`./asu_s1_free_not_at_start.exe`;
echo "$asuS1"
echo " "

echo "------------------------------"
echo "ASU_S2:"
asuS2=`./asu_s2_free_not_on_heap.exe`;
echo "$asuS2"
echo " "

echo "------------------------------"
echo "ASU_S3:"
asuS3=`./asu_s3_null_ptr_dereference.exe`;
echo "$asuS3"
echo " "

echo "------------------------------"
echo "ASU_S4:"
asuS4=`./asu_s4_oob_read.exe`;
echo "$asuS4"
echo " "

echo "------------------------------"
echo "ASU_S5:"
asuS5=`./asu_s5_oob_write.exe`;
echo "$asuS5"
echo " "

# ----------------------------------------------------------------------------
echo "============================================================"
echo " "

echo "------------------------------"
echo "ASU_R1:"
asuR1=`./asu_r1_heartbleed.exe`;
echo "$asuR1"
echo " "

echo "------------------------------"
echo "ASU_R2:"
asuR2=`./asu_r2_dop.exe`;
echo "$asuR2"
echo " "

echo "------------------------------"
echo "ASU_R3:"
asuR3=`./asu_r3_uaf_to_code_reuse.exe`;
echo "$asuR3"
echo " "

echo "------------------------------"
echo "ASU_R4:"
asuR4=`./asu_r4_ip_large_size.exe`;
echo "$asuR4"
echo " "

echo "------------------------------"
echo "ASU_R5:"
asuR5=`./asu_r5_df_switch_statements.exe`;
echo "$asuR5"
echo " "

# ----------------------------------------------------------------------------
echo "============================================================"
echo " "