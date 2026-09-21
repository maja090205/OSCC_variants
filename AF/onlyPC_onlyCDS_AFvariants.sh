#!/bin/bash

DIR=/data2/stud_agbio/apcsx/gnomad/

#filter variants present in protein coding genes
bedtools intersect \
    -a ${DIR}/variants_with_filtered_AF.vcf \
    -b /data2/stud_agbio/apcsx/analysis/protein_coding_noChr.gff3 \
    -header \
    -u \
    > ${DIR}/onlyPC_AFvariants.vcf

#filter variants present in coding sequences
bedtools intersect \
    -a ${DIR}/variants_with_filtered_AF.vcf \
    -b /data2/stud_agbio/apcsx/analysis/CDS_noChr.gff3 \
    -header \
    -u \
    > ${DIR}/onlyCDS_AFvariants.vcf