#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/


#create index
bwa-mem2 index ${DIR}/genome/Homo_sapiens.GRCh38.dna.toplevel.fa

#mapping
for file1 in ${DIR}/reads/X208SC26024052-Z01-F001_01/01.RawData/*/*_1.fq.gz ${DIR}/reads/X208SC26024052-Z01-F001_02/01.RawData/*/*_1.fq.gz; do
    echo "consider $file1"

    file2=${file1/_1.fq.gz/_2.fq.gz} #matching fq-file for file1 (paired ends)
    base=$(basename "$file1" _1.fq.gz)

    #-M to mark secondary hits (important for MarkDuplicates)
    #https://gatk.broadinstitute.org/hc/en-us/articles/360039568932--How-to-Map-and-clean-up-short-read-sequence-data-efficiently#step3B
    bwa-mem2 mem -M -t 8 ${DIR}/genome/Homo_sapiens.GRCh38.dna.toplevel.fa $file1 $file2 | samtools sort -@ 8 -o ${DIR}/bwa-mem2/${base}_sorted.bam 


done
