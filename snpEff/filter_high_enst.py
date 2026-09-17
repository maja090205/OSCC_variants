#this script was used for keeping only the transcripts with HIGH or MODERATE impact or just the transcripts with HIGH impact
#only the paths and filter criteria changed

from cyvcf2 import VCF, Writer

file = VCF("/data2/stud_agbio/apcsx/snpEff/variants_ann_high_moderate.vcf") #in this case: variants with HIGH and MODERATE impact are considered

new_vcf = Writer("/data2/stud_agbio/apcsx/snpEff/variants_ann_high_mod_transcripts.vcf", file)

for variant in file:
    info = variant.INFO.get('ANN') #impact is written down in INFO column
    if info is None:
        print("keine ANN gefunden")
        continue
    
    split_info = info.split(",") #splits INFO column using commas because annotations are separated with commas

    high = []
    for i in split_info:  #considers every annotation separately
        split_ann = i.split("|") #entries within an annotation are separated with "|"

        if (split_ann[2] == "HIGH" or split_ann[2] == "MODERATE"): #filter criteria: impact is HIGH or MODERATE
            high.append(i)

    variant.INFO["ANN"] = ",".join(high) #concat annotations passing the filter criteria

    new_vcf.write_record(variant) #write down variant with new INFO column

new_vcf.close()


