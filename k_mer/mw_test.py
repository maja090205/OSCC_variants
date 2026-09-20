import pandas as pd

file = pd.read_csv("/data2/stud_agbio/apcsx/consensus/kmer_matrix.tsv", sep="\t") #reads k-mer matrix
print("Matrix eingelesen", flush=True)

results=[]
i=0
for row in file.itertuples(index=False):
    mw_classics = (row.MKG32 + row.MKG34 + row.MKG64) / 3 #calculate mean value of classics
    mw_nonClassics = (row.MKG53 + row.MKG66a + row.MKG659) / 3 #calculate mean value of non-classics
    #calculate difference between group-specific mean values 
    mw_diff = mw_nonClassics - mw_classics #calculate without abs() to filter k-mers which are more present in non-classics easily
    mw = (row.MKG32 + row.MKG34 + row.MKG64 + row.MKG53 + row.MKG66a + row.MKG659) / 6 #calculate mean value of all samples
    p_diff = mw_diff / mw #calculate mean value difference relative to mean value over all samples

    #only keep k-mers which are more present in non-classics than in classics
    if p_diff >= 0.5:
        results.append((row.kmer, row.MKG32, row.MKG34, row.MKG64, row.MKG53, row.MKG66a, row.MKG659, round(mw_classics, 2), round(mw_nonClassics, 2), round(mw, 2), round(mw_diff, 2), round(p_diff, 2)))
    i+=1
    if i % 10000 == 0:
        print(f"{i} Zeilen verarbeitet", flush=True)

#create DataFrame
df = pd.DataFrame(results, columns = ["kmer", "MKG32", "MKG34", "MKG64", "MKG53", "MKG66a", "MKG659", "mw_classics", "mw_nonClassics", "mw_ges", "mw_diff", "p_diff"])
print("DataFrame erstellt", flush=True)

#sorts DataFrame by absolute and relative mean value difference
df_sorted = df.sort_values(by=['mw_diff', 'p_diff'] , ascending=[False, False])
print("DataFrame sortiert", flush=True)

#save sorted DataFrame
df_sorted.to_csv("/data2/stud_agbio/apcsx/consensus/mw_test_sortedMWdiff05.tsv", sep="\t", header=True)
print("Datei gespeichert", flush=True)

