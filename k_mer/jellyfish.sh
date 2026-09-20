#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/consensus/

for file in ${DIR}/*/*.fa; do #iterate over all personalized genomes
    base=$(basename $file)
    sample=${base%%_*}

    #counts all k-mers (k=21)
    jellyfish count \
        -C \
        -m 21 \
        -s 5G \
        -t 16 \
        -o ${DIR}/${sample}_k21.jf \
        $file

    #writes the counts in one file
    jellyfish dump -c ${DIR}/${sample}_k21.jf > ${DIR}/${sample}_k21_dump.tsv

done