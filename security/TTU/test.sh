#!/bin/sh
echo "============================================================"
echo "Running TTU tests" 

echo " "
echo "DATE: " 
date

echo " "
echo "UNAME: " 
uname -a

echo " "
echo "SYSCTL: " 
sysctl -a | egrep -i 'hw.machine|hw.model|hw.ncpu|hw.usermem'

export NUM_OF_THREADS=4

# ----------------------------------------------------------------------------
echo "============================================================"
echo " "

echo "------------------------------"
echo "TTU_T1:"
ttuT1=`./ttu_t1_double_free.exe`;
echo "$ttuT1"
echo " "

echo "------------------------------"
echo "TTU_T2:"
# ttuT2=`./ttu_t2_hm_fake_chunk_malloc.exe`;
# echo "$ttuT2"
echo "SKIPPED"
echo " "

echo "------------------------------"
echo "TTU_T3:"
ttuT3=`./ttu_t3_hm_house_of_spirit.exe`;
echo "$ttuT3"
echo " "

echo "------------------------------"
echo "TTU_T4:"
# ttuT4=`./ttu_t4_hm_p_and_c_chunk.exe`;
# echo "$ttuT4"
echo "SKIPPED"
echo " "

echo "------------------------------"
echo "TTU_T5:"
ttuT5=`./ttu_t5_use_after_free.exe`;
echo "$ttuT5"
echo " "

# ----------------------------------------------------------------------------
echo "============================================================"
echo " "

echo "------------------------------"
echo "TTU_S1:"
ttuS1=`./ttu_s1_free_not_at_start.exe`;
echo "$ttuS1"
echo " "

echo "------------------------------"
echo "TTU_S2:"
ttuS2=`./ttu_s2_free_not_on_heap.exe`;
echo "$ttuS2"
echo " "

echo "------------------------------"
echo "TTU_S3:"
ttuS3=`./ttu_s3_null_ptr_dereference.exe`;
echo "$ttuS3"
echo " "

echo "------------------------------"
echo "TTU_S4:"
ttuS4=`./ttu_s4_OoB_r.exe`;
echo "$ttuS4"
echo " "

echo "------------------------------"
echo "TTU_S5:"
ttuS5=`./ttu_s5_OoB_w.exe`;
echo "$ttuS5"
echo " "

# ----------------------------------------------------------------------------
echo "============================================================"
echo " "

echo "------------------------------"
echo "TTU_R1:"
ttuR1=`./ttu_r1_HeartBleed.exe`;
echo "$ttuR1"
echo " "

echo "------------------------------"
echo "TTU_R2:"
ttuR2=`./ttu_r2_dop.exe`;
echo "$ttuR2"
echo " "

echo "------------------------------"
echo "TTU_R3:"
ttuR3=`./ttu_r3_uaf_to_code_reuse.exe`;
echo "$ttuR3"
echo " "

echo "------------------------------"
echo "TTU_R4:"
ttuR4=`./ttu_r4_illegal_ptr_deref.exe`;
echo "$ttuR4"
echo " "

echo "------------------------------"
echo "TTU_R5:"
# ttuR5=`./ttu_r5_df_switch.exe`;
# echo "$ttuR5"
echo "SKIPPED"
echo " "

# ----------------------------------------------------------------------------
echo "============================================================"
echo " "