#!/bin/bash

#remove chr in GFF file
awk 'BEGIN{FS=OFS="\t"} /^#/ {print; next} {$1=gensub(/^chr/,"",1,$1); print}' /data2/stud_agbio/apcsx/analysis/gencode.v49.chr_patch_hapl_scaff.annotation.gff3 > /data2/stud_agbio/apcsx/analysis/gencode.v49.chr_patch_hapl_scaff.annotation.noChr.gff3

DIR=/data2/stud_agbio/apcsx/navip/navip_results

#run all NAVIP steps at once
bash ${DIR}/NAVIP/runnavip.sh \
    -i /data2/stud_agbio/apcsx/gatk/VQSR/snps_and_indels_only_pass.vcf \
    -g /data2/stud_agbio/apcsx/analysis/gencode.v49.chr_patch_hapl_scaff.annotation.noChr.gff3 \
    -f /data2/stud_agbio/apcsx/genome/Homo_sapiens.GRCh38.dna.toplevel.fa \
    -o ${DIR}/navip_results

#run NAVIP steps separate to test if it works now
##VCF preprocessing
python3 navip.py \
    --mode pre \
    --invcf /data2/stud_agbio/apcsx/gatk/VQSR/snps_and_indels_only_pass.vcf \
    --outpath ${DIR}/VCF_Preprocessing/

##NAVIP main
python3 navip.py \
    --mode main \
    --invcf ${DIR}/VCF_Preprocessing/first.vcf \
    --ingff /data2/stud_agbio/apcsx/analysis/gencode.v49.chr_patch_hapl_scaff.annotation.noChr.gff3 \
    --infasta /data2/stud_agbio/apcsx/genome/Homo_sapiens.GRCh38.dna.toplevel.fa \
    --outpath ${DIR}/NAVIP_Main_Output/ 

##SFA
python3 navip.py \
    --mode sfa \
    --innavipvcf ${DIR}/NAVIP_Main_Output/All_VCF.vcf \
    --outpath ${DIR}/SFA_Output/ \
    --format svg
