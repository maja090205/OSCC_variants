#this script was used for oncogenes and TSG and their CDS or exons separately
#just the paths changed

library(readr)
library(dplyr)
library(pheatmap)
library(tidyr)

setwd("C:/Users/souku/Bachelorarbeit/data/")

df <- read_tsv("kreuztabelle_tsg_CDS.tsv")
df <- df %>% select(-ENST) #remove ENST column (not needed)
df <- as.data.frame(df) #df is tibble at the moment -> convert to DataFrame
rownames(df) <- df$Gene #define gennames as row names
df$Gene <- NULL #remove column with gennames (they are row names now)
df <- df[c("MKG32", "MKG34", "MKG64", "MKG53", "MKG66a", "MKG659")] #define order of samples (group-specific)
head(df)
mat <- as.matrix(df) #convert to matrix
head(mat)
#plot heatmap and save as svg file
svg("C:/Users/souku/Bachelorarbeit/plots/heatmap_tsg_CDS.svg", width=8, height = 4)
pheatmap(t(mat), cluster_rows = FALSE, fontsize_col = 5, color = c("darkseagreen", "indianred3"), legend_breaks = c(0, 1))
dev.off()

#extract subsets
only_nonClassics <- subset(df, MKG32==0 & MKG34==0 & MKG64==0 & MKG53==1 & MKG66a==1 & MKG659==1) #all non-classics have variant, classics not
only_classics <- subset(df, MKG32==1 & MKG34==1 & MKG64==1 & MKG53==0 & MKG66a==0 & MKG659==0) #classics have variant, non-classics not
min_nonClassics <- subset(df, MKG53==1 & MKG66a==1 & MKG659==1) #min. all non-classics have variant
min_classics <- subset(df, MKG32==1 & MKG34==1 & MKG64==1) #min. all classics have variant
all <- subset(df, MKG32==1 & MKG34==1 & MKG64==1 & MKG53==1 & MKG66a==1 & MKG659==1) #all samples show variant
#save subsets
write.csv(min_nonClassics, file = "data/tsg/tsgCDS_min_nonClassics.csv", row.names = TRUE)
write.csv(min_classics, file = "data/tsg/tsgCDS_min_classics.csv", row.names = TRUE)
write.csv(only_nonClassics, file = "data/tsg/tsgCDS_only_nonClassics.csv", row.names = TRUE)
write.csv(all, file = "data/tsg/tsgCDS_all.csv", row.names = TRUE)







