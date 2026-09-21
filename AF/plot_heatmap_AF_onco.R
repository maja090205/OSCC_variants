#this script was used for oncogenes and TSG and their CDS and exons separately
#just the paths changed

library(readr)
library(dplyr)
library(pheatmap)
library(tidyr)

setwd("C:/Users/souku/Bachelorarbeit/data/")

df <- read_tsv("AFkreuztabelle_tsgCDS_genname.tsv") #in this case: CDS of TSG are considered
df <- df %>% select(-ENST) #remove ENST column (not needed)
df <- as.data.frame(df) #df is tibble at the moment -> convert to DataFrame
rownames(df) <- df$Gene #define gennames as row names
df$Gene <- NULL #remove column with gennames (they are row names now)
df <- df[c("MKG32", "MKG34", "MKG64", "MKG53", "MKG66a", "MKG659")] #define order of samples (group-specific)
head(df)
mat <- as.matrix(df) #convert to matrix
head(mat)
#plot heatmap and save as svg file
svg("C:/Users/souku/Bachelorarbeit/plots/AFheatmap_tsg_CDS.svg", width=8, height = 4)
pheatmap(t(mat), cluster_rows = FALSE, fontsize_col = 5, color = c("darkseagreen", "indianred3"), legend_breaks = c(0, 1))
dev.off()








