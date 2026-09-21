#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx

#finds intersections between VCF of variants with AF<0.01 and VCF of variants with HIGH and/or MODERATE impact prediction from SnpEff
bcftools isec \
    -n=2 \
    -w 1 \
    ${DIR}/snpEff/variants_ann_high_moderate.vcf.gz \
    ${DIR}/gnomad/variants_with_filtered_AF.vcf.gz \
    -Oz \
    -o ${DIR}/gnomad/snpeff_high_mod_AF.vcf.gz

