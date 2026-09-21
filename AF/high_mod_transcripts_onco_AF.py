from cyvcf2 import VCF
import pandas as pd

file = VCF("/data2/stud_agbio/apcsx/gnomad/snpeff/AFsnpeff_high_mod_transcripts.vcf") #read VCF file which contains variants filtered by AF and impact from SnpEff
oncos = pd.read_csv("/data2/stud_agbio/apcsx/analysis/onco/cancerGeneList_onco.tsv", sep="\t") #oncogenes from OnkoKB
tsg = pd.read_csv("/data2/stud_agbio/apcsx/analysis/tsg/cancerGeneList_tsg.tsv", sep="\t") #tumor supressor genes from OnkoKB


table = {}
samples = file.samples
for variant in file: #iterate over all variants in VCF
    info = variant.INFO.get('ANN') #annotations are in INFO column
    if info is None:
        print("keine ANN gefunden")
        continue

    split_info = info.split(",") #separates annotations in INFO column

    enst = [] #to save all ENSTs affected by variant
    for i in split_info: #consider every annotation separately
        split_ann = i.split("|") #separate entries of one annotation

        enst.append(split_ann[6].split(".")[0]) #add ENST number (without version number because ENSTs of oncos/TSG are without)

    #iterate over all affected ENSTs
    for nr in enst:
        if nr not in table: #add ENST number and set entries to 0 if ENST number does not already exist in table
            table[nr] = {sample: 0 for sample in samples}

        for sample, gt in zip(samples, variant.genotypes):
            a1 = gt[0] #allele 1
            a2 = gt[1] #allele 2

            if a1==-1 or a2 == -1: #means ./. -> set to False (0) -> no variant
                table[nr][sample]=0

            elif a1==0 and a2==0: #homozygote REF -> set to False (0) -> no variant
                table[nr][sample]=0

            else:
                table[nr][sample]=1 #variant exists (hetero- and homozygote possible)

#convert table to DataFrame
df = pd.DataFrame.from_dict(table, orient="index")
df = df[["MKG32", "MKG34", "MKG64", "MKG53", "MKG66a", "MKG659"]] #set order of samples (group-specific)

#define ENST as column
df.index.name = "ENST"
df.reset_index(inplace=True)

##oncogenes
#extract columns with genname and ENST number of OnkoKB genlist
oncos.columns = oncos.columns.str.strip()
onco_enst = oncos[["Hugo Symbol", "GRCh38 Isoform"]] #columns with gene name and ENST number

#change column names
onco_enst = onco_enst.rename(columns={
    "Hugo Symbol": "Gene",
    "GRCh38 Isoform": "ENST"
})

#remove space
onco_enst["ENST"] = onco_enst["ENST"].str.strip()
df["ENST"] = df["ENST"].str.strip()

#merge based on ENST number
result = onco_enst.merge(df, on="ENST")
result["Gene"] = result["Gene"].str.rstrip()
result.to_csv("/data2/stud_agbio/apcsx/gnomad/snpeff/AFkreuztabelle_onco_high_mod_transcipts.tsv", sep="\t", header=True, index=False)

##tumor supressor genes
#extract columns with genname and ENST number of OnkoKB genlist
tsg.columns = tsg.columns.str.strip()
tsg_enst = tsg[["Hugo Symbol", "GRCh38 Isoform"]] #columns with gene name and ENST number

#change column names
tsg_enst = tsg_enst.rename(columns={
    "Hugo Symbol": "Gene",
    "GRCh38 Isoform": "ENST"
})
#remove space
tsg_enst["ENST"] = tsg_enst["ENST"].str.strip()

#merge based on ENST number
result_tsg = tsg_enst.merge(df, on="ENST")
result_tsg["Gene"] = result_tsg["Gene"].str.rstrip()
result_tsg.to_csv("/data2/stud_agbio/apcsx/gnomad/snpeff/AFkreuztabelle_tsg_high_mod_transcipts.tsv", sep="\t", header=True, index=False)
