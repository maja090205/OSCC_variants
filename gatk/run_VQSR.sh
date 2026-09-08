#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/gatk/GenotypeGVCFs
OUTDIR=/data2/stud_agbio/apcsx/gatk/VQSR

#SNPs and Indels has to be considered separately
#extract SNPs
gatk SelectVariants \
    -V ${DIR}/GenotypeGVCFs_result.vcf.gz \
    -select-type-to-include SNP \
    -O ${OUTDIR}/select_snps.vcf.gz

#extract Indels
gatk SelectVariants \
    -V ${DIR}/GenotypeGVCFs_result.vcf.gz \
    -select-type-to-include INDEL \
    -O ${OUTDIR}/select_indels.vcf.gz

#filter SNPs (threshold from GATK examples)
##marks variants which pass the filters with PASS
gatk VariantFiltration \
    -V ${OUTDIR}/select_snps.vcf.gz \
    -filter "QD < 2.0" --filter-name "QD2" \
    -filter "SOR > 3.0" --filter-name "SOR3" \
    -filter "FS > 60.0" --filter-name "FS60" \
    -filter "MQ < 40.0" --filter-name "MQ40" \
    -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
    -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
    -O ${OUTDIR}/filtered_snps.vcf.gz

#filter Indels (threshold from GATK examples)
##marks variants which pass the filters with PASS
gatk VariantFiltration \
    -V ${OUTDIR}/select_indels.vcf.gz \
    -filter "QD < 2.0" --filter-name "QD2" \
    -filter "FS > 200.0" --filter-name "FS200" \
    -filter "SOR > 10.0" --filter-name "SOR10" \
    -filter "ReadPosRankSum < -20.0" --filter-name "ReadPosRankSum-20" \
    -O ${OUTDIR}/filtered_indels.vcf.gz

#extract variants marked with PASS
bcftools view -f PASS ${OUTDIR}/filtered_snps.vcf.gz -Oz -o ${OUTDIR}/snps_only_pass.vcf.gz
bcftools view -f PASS ${OUTDIR}/filtered_indels.vcf.gz -Oz -o ${OUTDIR}/indels_only_pass.vcf.gz

bcftools sort -Oz -o ${OUTDIR}/snps_only_pass_sorted.vcf.gz ${OUTDIR}/snps_only_pass.vcf.gz
bcftools sort -Oz -o ${OUTDIR}/indels_only_pass_sorted.vcf.gz ${OUTDIR}/indels_only_pass.vcf.gz

bcftools index ${OUTDIR}/snps_only_pass.vcf.gz
bcftools index ${OUTDIR}/indels_only_pass.vcf.gz

#combine SNPs and Indels
bcftools concat -a -Oz -o ${OUTDIR}/snps_and_indels_only_pass.vcf.gz ${OUTDIR}/snps_only_pass_sorted.vcf.gz ${OUTDIR}/indels_only_pass_sorted.vcf.gz 
bcftools index ${OUTDIR}/snps_and_indels_only_pass.vcf.gz