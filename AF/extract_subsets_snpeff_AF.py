import pandas as pd

#csv file nur mit Variationen in protein_coding
df = pd.read_csv('/data2/stud_agbio/apcsx/gnomad/snpeff_variants_list.csv')

#filter Variationen, die nur in den 3 Nicht-Klassikern vorkommen
nonClassics_df = df[(df['MKG53'] == True) & (df['MKG66a'] == True) & (df['MKG659'] == True) & (df['MKG32'] == False) & (df['MKG34'] == False) & (df['MKG64'] == False)]
nonClassics_df.to_csv("/data2/stud_agbio/apcsx/gnomad/snpeff_AFvariants_nonClassics.csv") #Tabelle speichern

#filter Variationen, die nur in den 3 Klassikern vorkommen
classics_df = df[(df['MKG32'] == True) & (df['MKG34'] == True) & (df['MKG64'] == True) & (df['MKG53'] == False) & (df['MKG66a'] == False) & (df['MKG659'] == False)]
classics_df.to_csv("/data2/stud_agbio/apcsx/gnomad/snpeff_AFvariants_classics.csv") #Tabelle speichern