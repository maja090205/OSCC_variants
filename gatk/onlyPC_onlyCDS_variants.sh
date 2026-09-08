#!/bin/bash

DIR=/data2/stud_agbio/apcsx/gatk/VQSR/
OUTDIR=/data2/stud_agbio/apcsx/analysis/

grep "gene_type=protein_coding" ${OUTDIR}/gencode.v49.chr_patch_hapl_scaff.annotation.gff3 > ${OUTDIR}/protein_coding.gff3 #filter protein-coding genes
awk -F'\t' '$3 == "CDS"' ${OUTDIR}/protein_coding.gff3 > ${OUTDIR}/CDS.gff3 #filter just coding sequences

#remove 'chr' from the chromosome (chr1 -> 1)
awk 'BEGIN{OFS="\t"} {$1=gensub(/^chr/,"",1,$1); print}' ${OUTDIR}/protein_coding.gff3 > ${OUTDIR}/protein_coding_noChr.gff3
awk 'BEGIN{OFS="\t"} {$1=gensub(/^chr/,"",1,$1); print}' ${OUTDIR}/CDS.gff3 > ${OUTDIR}/CDS_noChr.gff3

#extract only variants existing in protein-coding genes
bedtools intersect \
    -a ${DIR}/snps_and_indels_only_pass.vcf \
    -b ${OUTDIR}/protein_coding_noChr.gff3 \
    -header \
    -u \
    > ${OUTDIR}/onlyPC_variants_gff.vcf

#extract only variants existing in coding sequences
bedtools intersect \
    -a ${DIR}/snps_and_indels_only_pass.vcf \
    -b ${OUTDIR}/CDS_noChr.gff3 \
    -header \
    -u \
    > ${OUTDIR}/onlyCDS_variants_gff.vcf