#!/bin/bash


#paths
DIR=/data2/stud_agbio/apcsx/

#run multiqc
multiqc ${DIR}/fastqc ${DIR}/stats -o ${DIR}/stats/multiqc