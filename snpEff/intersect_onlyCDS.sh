#!/bin/bash

DIR=/data2/stud_agbio/apcsx/

#filter variants located in CDS with at least one HIGH-Impact-transcript
bedtools intersect \
    -a ${DIR}/snpEff/high/variants_ann_high_transcripts.vcf \
    -b ${DIR}/analysis/CDS_noChr.gff3 \
    -header \
    -u \
    > ${DIR}/snpEff/high/onlyCDS_high_variants.vcf

#filter variants located in CDS with at least one HIGH-Impact-transcript or MODERATE-Impact-transcript
bedtools intersect \
    -a ${DIR}/snpEff/high_mod/variants_ann_high_mod_transcripts.vcf \
    -b ${DIR}/analysis/CDS_noChr.gff3 \
    -header \
    -u \
    > ${DIR}/snpEff/high_mod/onlyCDS_high_mod_variants.vcf