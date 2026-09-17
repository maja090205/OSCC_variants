from cyvcf2 import VCF
import pandas as pd

onco = pd.read_csv("/data2/stud_agbio/apcsx/snpEff/kreuztabelle_onco_high_transcipts.tsv", sep="\t") #oncogenes with HIGH-Impact-variants
tsg = pd.read_csv("/data2/stud_agbio/apcsx/snpEff/kreuztabelle_tsg_high_transcipts.tsv", sep="\t") #TSG with HIGH-Impact-variants
vcf = VCF("/data2/stud_agbio/apcsx/snpEff/variants_ann_high_transcripts.vcf") #VCF file which only contains variants with their HIGH-impact-transcripts


effects = {} #dictionary with key=ENST, value=effects

for variant in vcf: #iterate over all variants
    info = variant.INFO.get('ANN') #annotations are written down in INFO column
    if info is None:
        continue

    info_split = info.split(",") #separates annotations

    for split in info_split: #iterate over all annotations
        split_split = split.split("|") #separarte entries within one annotation
        enst = split_split[6].split(".")[0] #extract ENST number without version number because ENST numbers from cancer genlist are without
        effect = split_split[1] #extract effect annotated from SnpEff
        effects.setdefault(enst, set()).add(effect) #save effects (without the same effect written down more than one time)

#convert dictionary to DataFrame with one row for each ENST number 
df = pd.DataFrame.from_dict({"ENST": effects.keys(), "effects": [",".join(map(str, eff)) for eff in effects.values()]}) 

#calculate overlap with oncogenes based on ENST number
df_onco = pd.DataFrame(onco)
merged_onco = pd.merge(df, df_onco, on = "ENST")
merged_onco.to_csv("/data2/stud_agbio/apcsx/snpEff/onco_effects.tsv", sep="\t", header=True, index=False)

#calculate overlap with tumor supressor genes based on ENST number
df_tsg = pd.DataFrame(tsg)
merged_tsg = pd.merge(df, df_tsg, on = "ENST")
merged_tsg.to_csv("/data2/stud_agbio/apcsx/snpEff/tsg_effects.tsv", sep="\t", header=True, index=False)

