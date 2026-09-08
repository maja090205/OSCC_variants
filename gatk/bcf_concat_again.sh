#!/bin/bash

OUTDIR=/data2/stud_agbio/apcsx/gatk/VQSR

#vergessen im Skript variantFiltration.sh diese Dateien zu indexieren, deswegen hat concat nicht funktioniert
bcftools index ${OUTDIR}/snps_only_pass.vcf.gz
bcftools index ${OUTDIR}/indels_only_pass.vcf.gz

bcftools concat -a -Oz -o ${OUTDIR}/snps_and_indels_only_pass.vcf.gz ${OUTDIR}/snps_only_pass.vcf.gz ${OUTDIR}/indels_only_pass.vcf.gz
bcftools index ${OUTDIR}/snps_and_indels_only_pass.vcf.gz