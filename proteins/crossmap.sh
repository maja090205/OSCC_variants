#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/consensus
GFF=/data2/stud_agbio/apcsx/analysis/gencode.v49.chr_patch_hapl_scaff.annotation.noChr.gff3

#personalize GFF file based on chain/liftover file for every patient
for file in ${DIR}/*/*.chain; do
    base=$(basename $file)
    sample=${base%%_*}

    CrossMap gff $file --chromid s $GFF ${DIR}/${sample}/${sample}.gff3

done