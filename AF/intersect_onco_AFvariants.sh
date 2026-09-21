#!/bin/bash

#paths
BED=/data2/stud_agbio/apcsx/analysis
DIR=/data2/stud_agbio/apcsx/gnomad

##filter by oncogenes
#filter CDS of oncogenes in which variants exists
bedtools intersect \
    -a ${BED}/onco/onco_CDS_noChr.bed \
    -b ${DIR}/variants_with_filtered_AF.vcf \
    -wa -wb \
    > ${DIR}/onco_tsg/CDS_onco_AFvariants.bed

#filter exons of oncogenes in which variants exists
bedtools intersect \
    -a ${BED}/onco/onco_exon_noChr.bed \
    -b ${DIR}/variants_with_filtered_AF.vcf \
    -wa -wb \
    > ${DIR}/onco_tsg/exon_onco_AFvariants.bed


##filter by tumor supressor genes
#filter CDS of tumor supressor genes in which variants exists
bedtools intersect \
    -a ${BED}/tsg/tsg_CDS_noChr.bed \
    -b ${DIR}/variants_with_filtered_AF.vcf \
    -wa -wb \
    > ${DIR}/onco_tsg/CDS_tsg_AFvariants.bed

#filter exons of tumor supressor genes in which variants exists
bedtools intersect \
    -a ${BED}/tsg/tsg_exon_noChr.bed \
    -b ${DIR}/variants_with_filtered_AF.vcf \
    -wa -wb \
    > ${DIR}/onco_tsg/exon_tsg_AFvariants.bed

