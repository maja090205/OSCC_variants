#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/gatk/HaplotypeCaller
OUTDIR=/data2/stud_agbio/apcsx/gatk/GenotypeGVCFs

#combines all 6 VCFs 
 gatk CombineGVCFs \
   -R /data2/stud_agbio/apcsx/genome/Homo_sapiens.GRCh38.dna.toplevel.fa \
   --variant ${DIR}/MKG32/MKG32_HC.vcf.gz \
   --variant ${DIR}/MKG34/MKG34_HC.vcf.gz \
   --variant ${DIR}/MKG53/MKG53_HC.vcf.gz \
   --variant ${DIR}/MKG64/MKG64_HC.vcf.gz \
   --variant ${DIR}/MKG66a/MKG66a_HC.vcf.gz \
   --variant ${DIR}/MKG659/MKG659_HC.vcf.gz \
   -O ${OUTDIR}/CombineGVCFs_result.vcf.gz

#joint genotyping
 gatk GenotypeGVCFs \
   -R /data2/stud_agbio/apcsx/genome/Homo_sapiens.GRCh38.dna.toplevel.fa \
   -V ${OUTDIR}/CombineGVCFs_result.vcf.gz \
   -O ${OUTDIR}/GenotypeGVCFs_result.vcf.gz