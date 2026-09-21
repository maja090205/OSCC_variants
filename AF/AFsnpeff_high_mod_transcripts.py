from cyvcf2 import VCF, Writer


file = VCF("/data2/stud_agbio/apcsx/gnomad/snpeff/snpeff_high_mod_AF.vcf") #read VCF file containing variants with HIGH and/or MODERATE impact

new_vcf = Writer("/data2/stud_agbio/apcsx/gnomad/snpeff/AFsnpeff_high_mod_transcripts.vcf", file) #open output file

for variant in file: #iterate over all variants
    info = variant.INFO.get('ANN') #extract INFO column
    if info is None:
        print("keine ANN gefunden")
        continue

    split_info = info.split(",") #separates annotations in INFO column

    high = []
    for i in split_info:  #iterates over all annotations
        split_ann = i.split("|") #separates entries of annotation

        if (split_ann[2] == "HIGH" or split_ann[2] == "MODERATE"): #impact has to be HIGH or MODERATE
            high.append(i)

    variant.INFO["ANN"] = ",".join(high) #concat annotations passing the criteria

    new_vcf.write_record(variant) #add variant with updated INFO column to output file

new_vcf.close()

