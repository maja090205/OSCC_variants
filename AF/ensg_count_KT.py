import pandas as pd
from cyvcf2 import VCF

#read VCF file which contains only variants filtered by AF, SnpEff Impact and location in CDS
vcf = VCF("/data2/stud_agbio/apcsx/gnomad/snpeff/onlyCDS_AFvariants_high_mod.vcf")
samples = vcf.samples


table = {}
same_var = {}

#iterate over all variants
for variant in vcf:

    #define ID for every variant
    var_id = f"{variant.CHROM},{variant.POS}" #considers only position of the variant (no difference within multiallelic variants)

    #extract INFO column
    info = variant.INFO.get('ANN')
    if info is None:
        print("keine ANN gefunden")
        continue

    split_info = info.split(",") #separates annotation

    split_ann = split_info[0].split("|") #extracts only first annotation and separates entries because we only need ENSG number, not ENST

    ensg = split_ann[4] #extract ENSG number
    name = split_ann[3] #extract name of the gene

    #set gene name to 'NA' if gene has no specific name 
    if ensg == name: 
        name = "NA"

    #
    if ensg not in table:
        table[ensg] = {"genname": name, **{sample: 0 for sample in samples}} #create entry for this gene
        same_var[ensg] = {sample: set() for sample in samples} #define empty sets

    for index, gt in enumerate(variant.genotypes):
        a1 = gt[0] #allele 1
        a2 = gt[1] #allele 2
        if a1 > 0 or a2 > 0: #variant exists for sample (homozygote and heterozygote possible)
            table[ensg][samples[index]] += 1 #increase number of variants for this gene and sample
            same_var[ensg][samples[index]].add(var_id) #save ID of variant

#calculate shared variants for each gene
for ensg in table:
    same = None
    for sample in samples:
        if len(same_var[ensg][sample]) > 0: #sample has to have at least one variant in this gene
            if same is None:
                same = same_var[ensg][sample].copy() #add Id of variant
            else:
                same &= same_var[ensg][sample] #calculates intersection
    table[ensg]["same_variants"]= len(same)

#convert to DataFrame
df = pd.DataFrame.from_dict(table, orient="index")

#define ENSG as column
df.index.name = "ENSG"
df.reset_index(inplace=True)

#save DataFrame
df.to_csv("/data2/stud_agbio/apcsx/gnomad/snpeff/ensg_count_kreuztabelle_high_mod_AF_CDS.tsv", sep="\t", header=True, index=False)

#filter table for only these genes in which all non-classics have at least one variant (ran this command on command line)
# awk -F'\t' ' NR == 1 || ($5 > 0 && $7 > 0 && $8 > 0)' ensg_count_kreuztabelle_high_mod_AF_CDS.tsv > minNK_ensg_count_KT.tsv