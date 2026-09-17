#!/bin/bash

DIR=/data2/stud_agbio/apcsx/snpEff/

#filter annotated variants by impact (e.g. stop_gained, framshift, missense, inframe_deletion -> high and moderate)
SnpSift filter "((ANN[*].IMPACT = 'HIGH') | (ANN[*].IMPACT = 'MODERATE'))" ${DIR}/variants_ann.vcf > ${DIR}/variants_ann_high_moderate.vcf

#just filter variants with high impact
SnpSift filter "(ANN[*].IMPACT = 'HIGH')" ${DIR}/variants_ann_high_moderate.vcf > ${DIR}/variants_ann_high.vcf