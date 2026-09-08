#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/gatk/readGroups/
OUTDIR=/data2/stud_agbio/apcsx/gatk/MarkDuplicates

#MarkDuplicates
for file in ${DIR}/*/*.bam; do
    base=$(basename $file)

    echo "process file $base"

    sample=${base%%_*} #e.g. MKG32, MKG34 ...
    gatk MarkDuplicates -I $file \
                        -O ${OUTDIR}/${sample}/${sample}_markedDupl.bam \
                        -M ${OUTDIR}/${sample}/${sample}_metrics.txt

    samtools index ${OUTDIR}/${sample}/${sample}_markedDupl.bam

done 