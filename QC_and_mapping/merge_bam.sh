#!/bin/bash


#paths
DIR=/data2/stud_agbio/apcsx/bwa-mem2/

samtools merge -@ 4 -o $DIR/MKG64_MKDN260007899-1A_23HJNNLT4_merged.bam $DIR/MKG64_MKDN260007899-1A_23CLKFLT4_L7_sorted.bam $DIR/MKG64_MKDN260007899-1A_23HJNNLT4_L2_sorted.bam
samtools index $DIR/MKG64_MKDN260007899-1A_23HJNNLT4_merged.bam

samtools merge -@ 4 -o $DIR/MKG66a_MKDN260007900-1A_23HJNNLT4_merged.bam $DIR/MKG66a_MKDN260007900-1A_23CLKFLT4_L7_sorted.bam $DIR/MKG66a_MKDN260007900-1A_23HJNNLT4_L2_sorted.bam
samtools index $DIR/MKG66a_MKDN260007900-1A_23HJNNLT4_merged.bam
