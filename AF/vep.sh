#!/bin/bash

DIR=/data2/stud_agbio/apcsx/gatk/VQSR/
OUTDIR=/data2/stud_agbio/apcsx/gnomad/

#install cache
vep_install -a cf -s homo_sapiens -y GRCh38 -c ~/.vep

#run VEP to annotate VCF file
vep \
    -i ${DIR}/snps_and_indels_only_pass.vcf \
    --assembly GRCh38 \
    --vcf \
    --af_gnomadg \
    --cache \
    --offline \
    -o ${OUTDIR}/variants_with_AF.vcf \

#filter annotated VCF by allele frequency of Non-Finnish-European population
filter_vep -i ${OUTDIR}/variants_with_AF.vcf -o ${OUTDIR}/variants_with_filtered_AF.vcf -filter "gnomADg_NFE_AF < 0.01 or not gnomADg_NFE_AF"