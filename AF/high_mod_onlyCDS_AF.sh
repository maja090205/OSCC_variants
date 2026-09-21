#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/gnomad/snpeff

#filter variants existing in CDS
bedtools intersect \
    -a ${DIR}/AFsnpeff_high_mod_transcripts.vcf \
    -b /data2/stud_agbio/apcsx/analysis/CDS_noChr.gff3 \
    -header \
    -u \
    > ${DIR}/onlyCDS_AFvariants_high_mod.vcf