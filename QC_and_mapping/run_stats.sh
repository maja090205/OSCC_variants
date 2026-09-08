#!/bin/bash


#paths
DIR=/data2/stud_agbio/apcsx/bwa-mem2/
OUTDIR=/data2/stud_agbio/apcsx/stats/


for file in ${DIR}/*.bam; do

    base=$(basename $file _sorted.bam)
    #create index
    samtools index $file

    #run samtools stats
    samtools stats $file > ${OUTDIR}/samtools/${base}.stats

    #run mosdepth
    mosdepth --threads 8 ${OUTDIR}/mosdepth/${base} $file

done

#create MultiQC report
multiqc /data2/stud_agbio/apcsx/fastqc ${OUTDIR} -o ${OUTDIR}/multiqc