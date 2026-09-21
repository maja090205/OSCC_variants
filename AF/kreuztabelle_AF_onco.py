#this script was used for all four files generated in script intersect_onco_AFvariants.sh
#only paths changed

import pandas as pd

#read bed file of variants existing in CDS of TSG with AF<0.01 (in this case)
file = pd.read_csv("/data2/stud_agbio/apcsx/gnomad/onco_tsg/CDS_tsg_AFvariants.bed", sep="\t", header=None)

#define column names
samples =["MKG32", "MKG34", "MKG53", "MKG64", "MKG659", "MKG66a"]
file.columns = ["cds_chr", "cds_start", "cds_end", "ENST", "CHROM", "POS", "ID", "REF", "ALT", "QUAL", "FILTER", "INFO", "FORMAT"]+ samples

table ={}

for index, row in file.iterrows(): #iterate over all rows
    enst = row["ENST"] #ENST number of specific row

    #add enst if ENST number not part of the table yet and set all entries to zero
    if enst not in table:
        table[enst] = {sample: 0 for sample in samples}

    #extract genotype for every sample
    for sample in samples:
        genotype=row[sample].split(":")[0]

        #if variant exists for this sample set entry to 1
        if genotype!="0/0" and genotype!="./.":
            table[enst][sample]=1

#convert to DataFrame
df = pd.DataFrame.from_dict(table, orient="index")

#define ENST as column
df.index.name = "ENST"
df.reset_index(inplace=True)

#read cancer genelist (oncogenes or TSG)
onco = pd.read_csv("/data2/stud_agbio/apcsx/analysis/tsg/cancerGeneList_tsg.tsv", sep="\t")
onco.columns = onco.columns.str.strip()
#only genname and ENST number are important
gen_name = onco[["Hugo Symbol", "GRCh38 Isoform"]]

#rename these columns
gen_name = gen_name.rename(columns={
    "Hugo Symbol": "Gene",
    "GRCh38 Isoform": "ENST"
})
#remove space
gen_name["ENST"] = gen_name["ENST"].str.strip()
df["ENST"] = df["ENST"].str.strip()

#merge based on ENST number
result = gen_name.merge(df, on="ENST")
result["Gene"] = result["Gene"].str.rstrip()

#save table
result.to_csv("/data2/stud_agbio/apcsx/gnomad/onco_tsg/AFkreuztabelle_tsgCDS_genname.tsv", sep="\t", header=True, index=False)