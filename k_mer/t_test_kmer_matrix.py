from scipy.stats import ttest_ind
import pandas as pd
from scipy import stats


file = pd.read_csv("/data2/stud_agbio/apcsx/consensus/kmer_matrix.tsv", sep="\t") #read k-mer matrix

result = []
for row in file.itertuples(index=False):
    #define groups
    classic_counts = [row.MKG32, row.MKG34, row.MKG64]
    nonClassics_counts = [row.MKG53, row.MKG66a, row.MKG659]

    t_statistic, p_value = ttest_ind(classic_counts, nonClassics_counts, equal_var=True) #start t test with equal variance
    result.append([row.kmer, t_statistic, p_value]) #add results to list

#create DataFrame
df = pd.DataFrame(result, columns = ["kmer", "t_statistic", "p_value"])

#corrects p-values with Benjamini-Yekutieli correction
df["p_adj"] = stats.false_discovery_control(df["p_value"], method='by')

#only keep k-mers with p-value less than 0.05
sign_kmers = df[df["p_adj"] < 0.05]

#save DataFrame
sign_kmers.to_csv("/data2/stud_agbio/apcsx/consensus/sign_kmers.tsv", sep="\t", header=True)






