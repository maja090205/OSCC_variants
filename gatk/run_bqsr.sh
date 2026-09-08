#!/bin/bash


#paths
DIR=/data2/stud_agbio/apcsx/gatk/MarkDuplicates
OUTDIR=/data2/stud_agbio/apcsx/gatk/BQSR

#databases of known polymorphic sites https://console.cloud.google.com/storage/browser/gcp-public-data--broad-references/hg38/v0?pageState=(%22StorageObjectListTable%22:(%22f%22:%22%255B%255D%22))
#change chr1 -> 1 in vcf files
bcftools annotate --rename-chrs ${OUTDIR}/data/remove-chr.txt ${OUTDIR}/data/dbsnp.vcf.gz -Oz -o ${OUTDIR}/data/dbsnp_noChr.vcf.gz
bcftools annotate --rename-chrs ${OUTDIR}/data/remove-chr.txt ${OUTDIR}/data/known_indels.vcf.gz -Oz -o ${OUTDIR}/data/known_indels_noChr.vcf.gz

#indexieren
tabix -p vcf ${OUTDIR}/data/dbsnp_noChr.vcf.gz
tabix -p vcf ${OUTDIR}/data/known_indels_noChr.vcf.gz
samtools faidx /data2/stud_agbio/apcsx/genome/Homo_sapiens.GRCh38.dna.toplevel.fa
gatk CreateSequenceDictionary -R /data2/stud_agbio/apcsx/genome/Homo_sapiens.GRCh38.dna.toplevel.fa #creates sequence dictionary for reference

#Base Quality Score Recalibration
for file in ${DIR}/*/*_markedDupl.bam; do
    base=$(basename $file)
    sample=${base%%_*}

    #First Step: BaseRecalibrator
    ##builds recalibration model by skipping known sites
    gatk BaseRecalibrator \
                        -I $file \
                        -R /data2/stud_agbio/apcsx/genome/Homo_sapiens.GRCh38.dna.toplevel.fa \
                        --known-sites ${OUTDIR}/data/dbsnp_noChr.vcf.gz \
                        --known-sites ${OUTDIR}/data/known_indels_noChr.vcf.gz \
                        -O ${OUTDIR}/${sample}/${sample}_recal_data.table

    #Second Step: ApplyBQSR
    ##adjusts base quality based on the model

    gatk ApplyBQSR \
                    -R /data2/stud_agbio/apcsx/genome/Homo_sapiens.GRCh38.dna.toplevel.fa \
                    -I $file \
                    --bqsr-recal-file ${OUTDIR}/${sample}/${sample}_recal_data.table \
                    -O ${OUTDIR}/${sample}/${sample}_bqsr.bam

    samtools index ${OUTDIR}/${sample}/${sample}_bqsr.bam

done