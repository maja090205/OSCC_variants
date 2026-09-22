#!/bin/bash

#paths
DIR=/data2/stud_agbio/apcsx/selected_genes/AF_CDS_TSG

#run MAFFT with clustal format for better visualization of the result
mafft --auto --clustalout ${DIR}/WRN.fasta > ${DIR}/alignment_WRN.clustal