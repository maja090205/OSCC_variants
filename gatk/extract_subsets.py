import pandas as pd

#read CSV from GATK workflow
df = pd.read_csv('/data2/stud_agbio/apcsx/analysis/variants_list.csv')

#variants only non-classics
nonClassics_df = df[(df['MKG53'] == True) & (df['MKG66a'] == True) & (df['MKG659'] == True) & (df['MKG32'] == False) & (df['MKG34'] == False) & (df['MKG64'] == False)]
nonClassics_df.to_csv("/data2/stud_agbio/apcsx/analysis/subsets/variants_nonClassics.csv") #save table

#variants only classics
classics_df = df[(df['MKG32'] == True) & (df['MKG34'] == True) & (df['MKG64'] == True) & (df['MKG53'] == False) & (df['MKG66a'] == False) & (df['MKG659'] == False)]
classics_df.to_csv("/data2/stud_agbio/apcsx/analysis/subsets/variants_classics.csv") #save table



#read CSV with variants existing in protein-coding genes
df_pc = pd.read_csv('/data2/stud_agbio/apcsx/analysis/variants_list_onlyPC.csv')

#variants only non-classics
PCnonClassics_df = df_pc[(df_pc['MKG53'] == True) & (df_pc['MKG66a'] == True) & (df_pc['MKG659'] == True) & (df_pc['MKG32'] == False) & (df_pc['MKG34'] == False) & (df_pc['MKG64'] == False)]
PCnonClassics_df.to_csv("/data2/stud_agbio/apcsx/analysis/subsets/PCvariants_nonClassics.csv") #save table

#variants only classics
PCclassics_df = df_pc[(df_pc['MKG32'] == True) & (df_pc['MKG34'] == True) & (df_pc['MKG64'] == True) & (df_pc['MKG53'] == False) & (df_pc['MKG66a'] == False) & (df_pc['MKG659'] == False)]
PCclassics_df.to_csv("/data2/stud_agbio/apcsx/analysis/subsets/PCvariants_classics.csv") #save table



#read CSV with variants existing in coding sequences
df_cds = pd.read_csv('/data2/stud_agbio/apcsx/analysis/variants_list_onlyCDS.csv')

#variants only non-classics
CDSnonClassics_df = df_cds[(df_cds['MKG53'] == True) & (df_cds['MKG66a'] == True) & (df_cds['MKG659'] == True) & (df_cds['MKG32'] == False) & (df_cds['MKG34'] == False) & (df_cds['MKG64'] == False)]
CDSnonClassics_df.to_csv("/data2/stud_agbio/apcsx/analysis/subsets/CDSvariants_nonClassics.csv") #save table

#variants only classics
CDSclassics_df = df_cds[(df_cds['MKG32'] == True) & (df_cds['MKG34'] == True) & (df_cds['MKG64'] == True) & (df_cds['MKG53'] == False) & (df_cds['MKG66a'] == False) & (df_cds['MKG659'] == False)]
CDSclassics_df.to_csv("/data2/stud_agbio/apcsx/analysis/subsets/CDSvariants_classics.csv") #save table