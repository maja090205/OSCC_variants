library(ggplot2)
setwd("C:/Users/souku/Bachelorarbeit/data/")

#plot raw counts of CDS with minimum one variant
##files for oncogenes
o_all <- read.csv("onco/cds/CDSoncos_all.csv",header=TRUE)
o_minClassics <- read.csv("onco/cds/CDSoncos_min_classics.csv",header=TRUE)
o_minNonClassics <- read.csv("onco/cds/CDSoncos_min_nonClassics.csv",header=TRUE)
##files for tsg
t_all <- read.csv("tsg/cds/tsgCDS_all.csv",header=TRUE)
t_minClassics <- read.csv("tsg/cds/tsgCDS_min_classics.csv",header=TRUE)
t_minNonClassics <- read.csv("tsg/cds/tsgCDS_min_nonClassics.csv",header=TRUE)
t_onlyNonClassics <- read.csv("tsg/cds/tsgCDS_only_nonClassics.csv",header=TRUE)

df_cds <- data.frame(group = c("all", "all", "minClassics", "minClassics", "minNonClassics", "minNonClassics", "onlyNonClassics", "onlyNonClassics"),
                     names = c("onco", "tsg", "onco", "tsg", "onco", "tsg", "onco", "tsg"), 
                     numbers = c(nrow(o_all), nrow(t_all), nrow(o_minClassics), 
                                 nrow(t_minClassics), nrow(o_minNonClassics), nrow(t_minNonClassics), 
                                 0, nrow(t_onlyNonClassics)))

p <- ggplot(df_cds, aes(x = group, y = numbers, fill=names)) +
  geom_col(position = position_dodge(width = 0.6), width = 0.5) +
  geom_text(
    aes(label = numbers),
    position = position_dodge(width = 0.6),
    vjust = -0.3,
    size = 3
  ) +
  scale_fill_manual(values = c(
    "onco" = "pink3",
    "tsg" = "pink1"
  )) +
  labs(title = "Anzahl CDS, in denen mindestens eine Variante vorkommt")+
  theme_minimal()
ggsave("C:/Users/souku/Bachelorarbeit/plots/anz_schnitt_cds.svg", plot=p, width = 8, height = 5)

#plot raw counts of exons with minimum one variant
##files for oncogenes
o_all_e <- read.csv("onco/exon/exon_oncos_all.csv",header=TRUE)
o_minClassics_e <- read.csv("onco/exon/exon_oncos_min_classics.csv",header=TRUE)
o_minNonClassics_e <- read.csv("onco/exon/exon_oncos_min_nonClassics.csv",header=TRUE)
o_onlyClassics_e <- read.csv("onco/exon/exon_oncos_only_classics.csv",header=TRUE)
##files for tsg
t_all_e <- read.csv("tsg/exon/tsgExon_all.csv",header=TRUE)
t_minClassics_e <- read.csv("tsg/exon/tsgExon_min_classics.csv",header=TRUE)
t_minNonClassics_e <- read.csv("tsg/exon/tsgExon_min_nonClassics.csv",header=TRUE)
t_onlyNonClassics_e <- read.csv("tsg/exon/tsgExon_only_nonClassics.csv",header=TRUE)


df_exon <- data.frame(group = c("all", "all", "minClassics", "minClassics", "minNonClassics", "minNonClassics", "onlyClassics", "onlyClassics", "onlyNonClassics", "onlyNonClassics"),
                     names = c("onco", "tsg", "onco", "tsg", "onco", "tsg", "onco", "tsg", "onco", "tsg"), 
                     numbers = c(nrow(o_all_e), nrow(t_all_e), nrow(o_minClassics_e), 
                                 nrow(t_minClassics_e), nrow(o_minNonClassics_e), nrow(t_minNonClassics_e),
                                 nrow(o_onlyClassics_e), 0, 0, nrow(t_onlyNonClassics_e)))

p_e <- ggplot(df_exon, aes(x = group, y = numbers, fill=names)) +
  geom_col(position = position_dodge(width = 0.6), width = 0.5) +
  geom_text(
    aes(label = numbers),
    position = position_dodge(width = 0.6),
    vjust = -0.3,
    size = 3
  ) +
  scale_fill_manual(values = c(
    "onco" = "pink3",
    "tsg" = "pink1"
  )) +
  labs(title = "Anzahl Exon, in denen mindestens eine Variante vorkommt")+
  theme_minimal()
ggsave("C:/Users/souku/Bachelorarbeit/plots/anz_schnitt_exon.svg", plot=p_e, width = 8, height = 5)


#plot percentage (100% = entries in table) of CDS with minimum one variant
kt_o <- read.csv("onco/cds/kreuztabelle_CDS.tsv", header = TRUE)
kt_t <- read.csv("tsg/cds/kreuztabelle_tsg_CDS.tsv", header = TRUE)

df_cds_p <- data.frame(group = c("all", "all", "minClassics", "minClassics", "minNonClassics", "minNonClassics", "onlyNonClassics", "onlyNonClassics"),
                     names = c("onco", "tsg", "onco", "tsg", "onco", "tsg", "onco", "tsg"), 
                     numbers = c((nrow(o_all)*100)/nrow(kt_o), (nrow(t_all)*100)/nrow(kt_t), (nrow(o_minClassics)*100)/nrow(kt_o), 
                                 (nrow(t_minClassics)*100)/nrow(kt_t), (nrow(o_minNonClassics)*100)/nrow(kt_o), (nrow(t_minNonClassics)*100)/nrow(kt_t), 
                                 0, (nrow(t_onlyNonClassics)*100)/nrow(kt_t)))

pp <- ggplot(df_cds_p, aes(x = group, y = numbers, fill=names)) +
  geom_col(position = position_dodge(width = 0.6), width = 0.5) +
  geom_text(
    aes(label = round(numbers)),
    position = position_dodge(width = 0.6),
    vjust = -0.3,
    size = 3
  ) +
  scale_fill_manual(values = c(
    "onco" = "pink3",
    "tsg" = "pink1"
  )) +
  labs(title = "Anteil CDS, in denen mindestens eine Variante vorkommt (100%=Einträge in Kreuztabelle)", y = "percentage %")+
  theme_minimal()
ggsave("C:/Users/souku/Bachelorarbeit/plots/perc_schnitt_cds.svg", plot=pp, width = 8, height = 5)

#plot percentage (100% = entries in table) of exons with minimum one variant
kt_o_e <- read.csv("onco/exon/kreuztabelle_exon.tsv", header = TRUE)
kt_t_e <- read.csv("tsg/exon/kreuztabelle_tsg_exon.tsv", header = TRUE)

df_cds_p_e <- data.frame(group = c("all", "all", "minClassics", "minClassics", "minNonClassics", "minNonClassics", "onlyClassics", "onlyClassics", "onlyNonClassics", "onlyNonClassics"),
                                    names = c("onco", "tsg", "onco", "tsg", "onco", "tsg", "onco", "tsg", "onco", "tsg"), 
                                    numbers = c((nrow(o_all_e)*100)/nrow(kt_o_e), (nrow(t_all_e)*100)/nrow(kt_t_e), (nrow(o_minClassics_e)*100)/nrow(kt_o_e), 
                                                (nrow(t_minClassics_e)*100)/nrow(kt_t_e), (nrow(o_minNonClassics_e)*100)/nrow(kt_o_e), (nrow(t_minNonClassics_e)*100)/nrow(kt_t_e),
                                                (nrow(o_onlyClassics_e)*100)/nrow(kt_o_e), 0, 0, (nrow(t_onlyNonClassics_e)*100)/nrow(kt_t_e)))

pp_e <- ggplot(df_cds_p_e, aes(x = group, y = numbers, fill=names)) +
  geom_col(position = position_dodge(width = 0.6), width = 0.5) +
  geom_text(
    aes(label = round(numbers)),
    position = position_dodge(width = 0.6),
    vjust = -0.3,
    size = 3
  ) +
  scale_fill_manual(values = c(
    "onco" = "pink3",
    "tsg" = "pink1"
  )) +
  labs(title = "Anteil Exon, in denen mindestens eine Variante vorkommt (100%=Einträge in Kreuztabelle)", y = "percentage %")+
  theme_minimal()
ggsave("C:/Users/souku/Bachelorarbeit/plots/perc_schnitt_exon.svg", plot=pp_e, width = 8, height = 5)

#plot percentage (100% = number of oncogenes or TSG) of CDS with minimum one variant
onco <- read.csv("onco/cancerGeneList_onco.tsv", header = TRUE, sep = "\t")
tsg <- read.csv("tsg/cancerGeneList_tsg.tsv", header = TRUE, sep = "\t")

df_cds_pp <- data.frame(group = c("all", "all", "minClassics", "minClassics", "minNonClassics", "minNonClassics", "onlyNonClassics", "onlyNonClassics"),
                       names = c("onco", "tsg", "onco", "tsg", "onco", "tsg", "onco", "tsg"), 
                       numbers = c((nrow(o_all)*100)/nrow(onco), (nrow(t_all)*100)/nrow(tsg), (nrow(o_minClassics)*100)/nrow(onco), 
                                   (nrow(t_minClassics)*100)/nrow(tsg), (nrow(o_minNonClassics)*100)/nrow(onco), (nrow(t_minNonClassics)*100)/nrow(tsg), 
                                   0, (nrow(t_onlyNonClassics)*100)/nrow(tsg)))

ppp <- ggplot(df_cds_pp, aes(x = group, y = numbers, fill=names)) +
  geom_col(position = position_dodge(width = 0.6), width = 0.5) +
  geom_text(
    aes(label = round(numbers)),
    position = position_dodge(width = 0.6),
    vjust = -0.3,
    size = 3
  ) +
  scale_fill_manual(values = c(
    "onco" = "pink3",
    "tsg" = "pink1"
  )) +
  labs(title = "Anteil CDS, in denen mindestens eine Variante vorkommt (100%=Anzahl Oncos/TSG aus der GeneList)", y = "percentage %")+
  theme_minimal() +
  theme(plot.title = element_text(size = 11))
ggsave("C:/Users/souku/Bachelorarbeit/plots/perc_schnitt_cds_GL.svg", plot=ppp, width = 8, height = 5)

#plot percentage (100% = number of oncogenes or TSG) of exons with minimum one variant
df_cds_pp_e <- data.frame(group = c("all", "all", "minClassics", "minClassics", "minNonClassics", "minNonClassics", "onlyClassics", "onlyClassics", "onlyNonClassics", "onlyNonClassics"),
                         names = c("onco", "tsg", "onco", "tsg", "onco", "tsg", "onco", "tsg", "onco", "tsg"), 
                         numbers = c((nrow(o_all_e)*100)/nrow(onco), (nrow(t_all_e)*100)/nrow(tsg), (nrow(o_minClassics_e)*100)/nrow(onco), 
                                     (nrow(t_minClassics_e)*100)/nrow(tsg), (nrow(o_minNonClassics_e)*100)/nrow(onco), (nrow(t_minNonClassics_e)*100)/nrow(tsg),
                                     (nrow(o_onlyClassics_e)*100)/nrow(onco), 0, 0, (nrow(t_onlyNonClassics_e)*100)/nrow(tsg)))

ppp_e <- ggplot(df_cds_pp_e, aes(x = group, y = numbers, fill=names)) +
  geom_col(position = position_dodge(width = 0.6), width = 0.5) +
  geom_text(
    aes(label = round(numbers)),
    position = position_dodge(width = 0.6),
    vjust = -0.3,
    size = 3
  ) +
  scale_fill_manual(values = c(
    "onco" = "pink3",
    "tsg" = "pink1"
  )) +
  labs(title = "Anteil Exon, in denen mindestens eine Variante vorkommt (100%=Anzahl Oncos/TSG aus der GeneList)", y = "percentage %")+
  theme_minimal()+
  theme(plot.title = element_text(size = 11))
ggsave("C:/Users/souku/Bachelorarbeit/plots/perc_schnitt_exon_GL.svg", plot=ppp_e, width = 8, height = 5)











