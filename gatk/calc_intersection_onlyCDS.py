from cyvcf2 import VCF
import pandas as pd
import matplotlib.pyplot as plt
from upsetplot import UpSet, from_indicators

file = VCF("/data2/stud_agbio/apcsx/analysis/onlyCDS_variants_gff.vcf") #read VCF with variants existing in coding sequences
samples = file.samples
print(file.samples) #just check if samples are recognized correctly

variants_list = [] #to save binary table

for variant in file: #iterate over all variants
    row = {"variant": f"{variant.CHROM}:{variant.POS}:{variant.REF}:{','.join(variant.ALT)}"} #format: variant:1:10:A:G,T (e.g. multivariants)

    for index, gt in enumerate(variant.genotypes): #for every sample gt = [0,1,False] (e.g.)
        a1 = gt[0] #allele 1
        a2 = gt[1] #allele 2

        if a1==-1 or a2 == -1: #means ./. -> set to False (0) -> no variant
            row[samples[index]] = False

        elif a1==0 and a2==0: #homozygote REF -> set to False (0) -> no variant
            row[samples[index]] = False

        else:
            row[samples[index]] = True #variant exists (hetero- and homozygote possible)

    variants_list.append(row) #add row/variant to table

df = pd.DataFrame(variants_list) #convert to DataFrame
df = df.set_index("variant") ##set column "variant" to index
df.to_csv("/data2/stud_agbio/apcsx/analysis/variants_list_onlyCDS.csv") #save binary table

df = df[["MKG32", "MKG34", "MKG64", "MKG53", "MKG66a", "MKG659"]] #set order of samples (group-specific)
data = from_indicators(df) #convert DF to format for UpSet plot

#UpSet Plot
plot = UpSet(data, subset_size="count", show_counts=False, sort_by="degree", facecolor="black", sort_categories_by=None)

#just some additional design options
plot.style_categories(["MKG32", "MKG34", "MKG64"], shading_facecolor="aliceblue")
plot.style_categories(["MKG53", "MKG66a", "MKG659"], shading_facecolor="lavenderblush")
plot.style_subsets(present=["MKG32", "MKG34", "MKG64"], absent=["MKG53", "MKG66a", "MKG659"], edgecolor="salmon", linewidth=1)
plot.style_subsets(present=["MKG53", "MKG66a", "MKG659"], absent=["MKG32", "MKG34", "MKG64"], edgecolor="salmon", linewidth=1)
plot.plot()

#save plot
plt.savefig("/data2/stud_agbio/apcsx/plots/upset_onlyCDS.pdf")