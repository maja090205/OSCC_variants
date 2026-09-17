#!/bin/bash

DIR=/data2/stud_agbio/apcsx/analysis/

#extract all exon annotations in the GFF file
awk -F'\t' '$3 == "exon"' ${DIR}/gencode.v49.chr_patch_hapl_scaff.annotation.gff3 > ${DIR}/filtered_gff/exon.gff3

#extract all gene annotations in the GFF file
awk -F'\t' '$3 == "gene"' ${DIR}/gencode.v49.chr_patch_hapl_scaff.annotation.gff3 > ${DIR}/filtered_gff/gene.gff3

#extract all start codon annotations in the GFF file
awk -F'\t' '$3 == "start_codon"' ${DIR}/gencode.v49.chr_patch_hapl_scaff.annotation.gff3 > ${DIR}/filtered_gff/start_codon.gff3

#extract all stop codon annotations in the GFF file
awk -F'\t' '$3 == "stop_codon"' ${DIR}/gencode.v49.chr_patch_hapl_scaff.annotation.gff3 > ${DIR}/filtered_gff/stop_codon.gff3

#extract all transcript annotations in the GFF file
awk -F'\t' '$3 == "transcript"' ${DIR}/gencode.v49.chr_patch_hapl_scaff.annotation.gff3 > ${DIR}/filtered_gff/transcript.gff3
