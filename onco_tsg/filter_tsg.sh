#!/bin/bash

#paths
cd /data2/stud_agbio/apcsx/analysis/
VCF=/data2/stud_agbio/apcsx/gatk/VQSR/

#filter genelist from OnkoKB by tumor supressor genes (TSG)
awk -F'\t' 'NR==1 || $7 ~ /TSG/' cancerGeneList.tsv > tsg/cancerGeneList_tsg.tsv

#extract ENST numbers from TSG and look for CDS entries with matching ENST number
awk '
BEGIN{FS=OFS="\t"}
NR==FNR {
    gsub(/\r/,"",$5)
    gsub(/^ +| +$/,"",$5)
    enst[$5]=1
    next
}
$3=="CDS"{
    match($9,/Parent=([^;]+)/,p)
    split(p[1],str,"\\.")
    gsub(/\r/,"",str[1])

    if(str[1] in enst)
        print $1,$4,$5,str[1]
}' tsg/cancerGeneList_tsg.tsv gencode.v49.chr_patch_hapl_scaff.annotation.gff3 > tsg/tsg_CDS.bed

#each row in the result file stands for one CDS entry belonging to a TSG of this list
sed 's/^chr//' tsg/tsg_CDS.bed > tsg/tsg_CDS_noChr.bed

#only keep CDS with variants
#output file contains CDS coordinates and vcf entry overlapping with it
bedtools intersect \
    -a tsg/tsg_CDS_noChr.bed \
    -b ${VCF}/snps_and_indels_only_pass.vcf \
    -wa -wb \
    > tsg/tsgVar_CDS.bed


#do the same for exons instead of CDS 
#extract ENST numbers from TSG and look for exon entries with matching ENST number
awk '
BEGIN{FS=OFS="\t"}
NR==FNR {
    gsub(/\r/,"",$5)
    gsub(/^ +| +$/,"",$5)
    enst[$5]=1
    next
}
$3=="exon"{
    match($9,/Parent=([^;]+)/,p)
    split(p[1],str,"\\.")
    gsub(/\r/,"",str[1])

    if(str[1] in enst)
        print $1,$4,$5,str[1]
}' tsg/cancerGeneList_tsg.tsv gencode.v49.chr_patch_hapl_scaff.annotation.gff3 > tsg/tsg_exon.bed

#each row in the result file stands for one exon entry belonging to a TSG of this list
sed 's/^chr//' tsg/tsg_exon.bed > tsg/tsg_exon_noChr.bed

#only keep exons with variants
#output file contains exon coordinates and vcf entry overlapping with it
bedtools intersect \
    -a tsg/tsg_exon_noChr.bed \
    -b ${VCF}/snps_and_indels_only_pass.vcf \
    -wa -wb \
    > tsg/tsgVar_exon.bed
