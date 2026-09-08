#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/gatk/readGroups


#AddOrReplaceReadGroups
for file in ${DIR}/*/*.bam; do
    
    samtools index $file
                     
done 