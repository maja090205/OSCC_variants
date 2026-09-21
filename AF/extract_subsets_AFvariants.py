import pandas as pd

#read CSV file with variants existing in protein coding genes
df_pc = pd.read_csv('/data2/stud_agbio/apcsx/gnomad/PC_CDS/AFvariants_list_onlyPC.csv')

#filter variants only existing in all 3 samples of the group non-classics
PCnonClassics_df = df_pc[(df_pc['MKG53'] == True) & (df_pc['MKG66a'] == True) & (df_pc['MKG659'] == True) & (df_pc['MKG32'] == False) & (df_pc['MKG34'] == False) & (df_pc['MKG64'] == False)]
PCnonClassics_df.to_csv("/data2/stud_agbio/apcsx/gnomad/PC_CDS/AF_PCvariants_nonClassics.csv") #save table

#filter variants only existing in all 3 samples of the group classics
PCclassics_df = df_pc[(df_pc['MKG32'] == True) & (df_pc['MKG34'] == True) & (df_pc['MKG64'] == True) & (df_pc['MKG53'] == False) & (df_pc['MKG66a'] == False) & (df_pc['MKG659'] == False)]
PCclassics_df.to_csv("/data2/stud_agbio/apcsx/gnomad/PC_CDS/AF_PCvariants_classics.csv") #save table


#read CSV file with variants existing in CDS
df_cds = pd.read_csv('/data2/stud_agbio/apcsx/gnomad/PC_CDS/AFvariants_list_onlyCDS.csv')

#filter variants only existing in all 3 samples of the group non-classics
CDSnonClassics_df = df_cds[(df_cds['MKG53'] == True) & (df_cds['MKG66a'] == True) & (df_cds['MKG659'] == True) & (df_cds['MKG32'] == False) & (df_cds['MKG34'] == False) & (df_cds['MKG64'] == False)]
CDSnonClassics_df.to_csv("/data2/stud_agbio/apcsx/gnomad/PC_CDS/AF_CDSvariants_nonClassics.csv") #save table