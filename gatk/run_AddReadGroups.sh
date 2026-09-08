#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/bwa-mem2
OUTDIR=/data2/stud_agbio/apcsx/gatk/readGroups


#AddOrReplaceReadGroups adds readgroups (necessary e.g. for MarkDuplicates)
for file in ${DIR}/*.bam; do
    base=$(basename $file)
    #skip files merged in the step before (merge_bam.sh)
    if [[ $base == "MKG64_MKDN260007899-1A_23CLKFLT4_L7_sorted.bam" || $base == "MKG64_MKDN260007899-1A_23HJNNLT4_L2_sorted.bam" || $base == "MKG66a_MKDN260007900-1A_23CLKFLT4_L7_sorted.bam" || $base == "MKG66a_MKDN260007900-1A_23HJNNLT4_L2_sorted.bam" ]] 
    then 
        echo "skip file $base"
        continue
    fi 

    echo "process file $base"

    sample=${base%%_*} #e.g. MKG32, MKG34 ...
    gatk AddOrReplaceReadGroups -I $file \
                                -O ${OUTDIR}/${sample}/${sample}_with_RG.bam \
                                -RGID ${sample} \
                                -RGSM ${sample} \
                                -RGLB lib1 \
                                -RGPL ILLUMINA \
                                -RGPU "$(echo "$base" | cut -d'_' -f3)"

    samtools index ${OUTDIR}/${sample}/${sample}_with_RG.bam
                     
done 

