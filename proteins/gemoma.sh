#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/consensus
OUTDIR=/data2/stud_agbio/apcsx/consensus/gemoma

#run GeMoMa to extract protein sequences
for file in ${DIR}/*/*.gff3; do
    base=$(basename $file)
    sample=${base%.*}

    #GeMoMa Extractor a=$file g=${DIR}/${sample}/${sample}_genome.fa p=true outdir=${OUTDIR}/${sample}
    GeMoMa Extractor a=$file g=${DIR}/${sample}/${sample}_genome.fa p=true d=false r=true outdir=${OUTDIR}/${sample}

done