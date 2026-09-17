#!/bin/bash

#using 8GB of memory (otherwise OutOfMemory error; for human genome 8GB is recommended from official SnpEff docu)
export _JAVA_OPTIONS="-Xmx8g"

#load database
snpEff download GRCh38.115

#run SnpEff
snpEff GRCh38.115 /data2/stud_agbio/apcsx/gatk/VQSR/snps_and_indels_only_pass.vcf > /data2/stud_agbio/apcsx/snpEff/variants_ann.vcf