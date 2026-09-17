from cyvcf2 import VCF,Writer

file = VCF("/data2/stud_agbio/apcsx/snpEff/variants_ann_high_transcripts.vcf") #VCF file which only contains variants with their HIGH-impact-transcripts

new_vcf = Writer("/data2/stud_agbio/apcsx/snpEff/intron_effects_high.vcf", file)

for variant in file: #iterate over all variants 
    info = variant.INFO.get('ANN') #annotations are written down in INFO column

    info_split = info.split(",") #separates annotations

    introns = []
    for i in info_split:
        eff = i.split("|") #separate entries within one annotation

        if "intron_variant" in eff[1]: #intron_variant has to be a part of the effect 
            introns.append(i)
            
    if len(introns) == 0: #continue if there are no entries with intron effect for variant
        continue

    else:
        variant.INFO["ANN"] = ",".join(introns) #concat annotations with intron effect 

    new_vcf.write_record(variant) #add row for variant to output file

new_vcf.close()

#overlap with oncogenes and TSG were calculated by running snpeff_high_transcripts_onco.py