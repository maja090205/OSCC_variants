#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/gatk/BQSR
OUTDIR=/data2/stud_agbio/apcsx/gatk/HaplotypeCaller

#HaplotypeCaller calculates genotypes 
for file in ${DIR}/*/*_bqsr.bam; do
    base=$(basename $file)
    sample=${base%%_*}

    #-ERC GVCF necessary for joint genotyping
    gatk HaplotypeCaller \
        -R /data2/stud_agbio/apcsx/genome/Homo_sapiens.GRCh38.dna.toplevel.fa \
        -I $file \
        -O ${OUTDIR}/${sample}/${sample}_HC.vcf.gz \
        -ERC GVCF \
        --native-pair-hmm-threads 8 #just to speed up the process a little

done