#!/bin/bash


#paths
DIR1=/data2/stud_agbio/apcsx/reads/X208SC26024052-Z01-F001_01/01.RawData 
DIR2=/data2/stud_agbio/apcsx/reads/X208SC26024052-Z01-F001_02/01.RawData 
OUTDIR=/data2/stud_agbio/apcsx/fastqc

#run FastQC for raw data
for file in $DIR1/*/*.fq.gz $DIR2/*/*.fq.gz; do
    echo "run fastqc for $file" #just to check the file path
    
    fastqc $file -o $OUTDIR #-o defines output directory
done
