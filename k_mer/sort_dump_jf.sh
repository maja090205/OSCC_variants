#!/bin/bash

DIR=/data2/stud_agbio/apcsx/consensus

i=0
for file in ${DIR}/*/*.tsv
do
    echo "processing $file"
    if ((i>=6)); then
        echo "alle samples durch"
        break
    fi

    base=$(basename $file)
    sample=${base%%_*} #extracts sample name
    echo "sample is $sample for $file"

    #sort file based on k-mer (lexikographic)
    sort \
        -k1,1 \
        -T ${DIR}/sorted/ \
        $file \
        > "${DIR}/sorted/${sample}_sorted.tsv"
    ((i++))
done