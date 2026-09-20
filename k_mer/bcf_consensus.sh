#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/gatk/VQSR
GENOME=/data2/stud_agbio/apcsx/genome/Homo_sapiens.GRCh38.dna.toplevel.fa 
OUTDIR=/data2/stud_agbio/apcsx/consensus

#run bcftools consensus to create an individual genome which includes all variants of the sample
#-c to create chain file for later
bcftools consensus \
    -s MKG32 \
    -f $GENOME \
    -H A \
    -c ${OUTDIR}/MKG32/MKG32_liftover.chain \
    ${DIR}/snps_and_indels_only_pass.vcf.gz \
    > ${OUTDIR}/MKG32/MKG32_genome.fa

bcftools consensus \
    -s MKG34 \
    -f $GENOME \
    -H A \
    -c ${OUTDIR}/MKG34/MKG34_liftover.chain \
    ${DIR}/snps_and_indels_only_pass.vcf.gz \
    > ${OUTDIR}/MKG34/MKG34_genome.fa

bcftools consensus \
    -s MKG53 \
    -f $GENOME \
    -H A \
    -c ${OUTDIR}/MKG53/MKG53_liftover.chain \
    ${DIR}/snps_and_indels_only_pass.vcf.gz \
    > ${OUTDIR}/MKG53/MKG53_genome.fa

bcftools consensus \
    -s MKG64 \
    -f $GENOME \
    -H A \
    -c ${OUTDIR}/MKG64/MKG64_liftover.chain \
    ${DIR}/snps_and_indels_only_pass.vcf.gz \
    > ${OUTDIR}/MKG64/MKG64_genome.fa

bcftools consensus \
    -s MKG66a \
    -f $GENOME \
    -H A \
    -c ${OUTDIR}/MKG66a/MKG66a_liftover.chain \
    ${DIR}/snps_and_indels_only_pass.vcf.gz \
    > ${OUTDIR}/MKG66a/MKG66a_genome.fa

bcftools consensus \
    -s MKG659 \
    -f $GENOME \
    -H A \
    -c ${OUTDIR}/MKG659/MKG659_liftover.chain \
    ${DIR}/snps_and_indels_only_pass.vcf.gz \
    > ${OUTDIR}/MKG659/MKG659_genome.fa