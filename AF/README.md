In diesem Ordner befinden sich alle Skripte, die für die Filterung der Varianten 
anhand ihrer Allelfrequenz und die weitere Analyse dieser Varianten, verwendet wurden.
Die Skripte wurden in der unten beschriebenen Reihenfolge ausgeführt.

## vep.sh
Dieses Skript dient dazu, die VCF Datei aus dem GATK Workflow mit VEP zu annotieren 
und dabei die Information über die Allelfrequenz der Variante von gnomAD hinzuzufügen.
Die annotierte VCF wird dann anhand der Allelfrequenz der Nicht-Finnischen-Europäer gefiltert.

## upset_AF_filtered_vcf.py
Dieses Skript erstellt ein UpSet Plot aus der zuvor gefilterten VCF Datei.

## onlyPC_onlyCDS_AFvariants.sh
Die bereits gefilterten Varianten werden zusätzlich noch auf ihr Vorkommen in proteinkodierenden Genen und CDS beschränkt.
Dafür werden die schon aus früheren Analyseschritten gefilterten GFF Dateien verwendet, die nur noch die Annotationen für CDS oder proteincodierende Gene enthalten.

## calc_intersection_onlyPC_AF.py
Dieses Skript erstellt ein UpSet Plot für die Varianten, die sich in proteinkodierenden Genen befinden und das Filterkriterium für die Allelfrequenz erfüllen.
Das Skript ist eigentlich identisch zu ***upset_AF_filtered_vcf.py***. Nur die Dateipfade haben sich geändert.

## calc_intersection_onlyCDS_AF.py
Dieses Skript erstellt ein UpSet Plot für die Varianten, die sich in CDS befinden und das Filterkriterium für die Allelfrequenz erfüllen.
Das Skript ist eigentlich identisch zu ***upset_AF_filtered_vcf.py***. Nur die Dateipfade haben sich geändert.

## extract_subsets_AFvariants.py
Die Varianten der gruppenspezifischen Schnittmengen des UpSet Plots werden mit diesem Skript extrahiert.


# Onko/TSG

## intersect_onco_AFvariants.sh
In diesem Skript werden die anhand der Allelfrequenz gefilterten Varianten auf die CDS und Exons von Onkogenen und Tumorsupressorgenen beschränkt.

## kreuztabelle_AF_onco.py
Dieses Skript erstellt für alle 4 Dateien aus ***intersect_onco_AFvariants.sh*** eine Kreuztabelle.

## plot_heatmap_AF_onco.R
In diesem Skript werden die Daten der Kreuztabellen aus ***kreuztabelle_AF_onco.py*** in Heatmaps veranschaulicht.
Dabei symbolisieren rote Felder (1) das Vorhandensein mindestens einer Variante in diesem Onkogen/TSG und gruüne Felder (0) die Abwesenheit einer solchen Variante.


# SnpEff

## AFvariants_high_moderate.sh
Dieses Skript berechnet die gemeinsame Schnittmenge von Varianten, die von SnpEff 
einen HIGH und/oder MODERATE Impact zugeorndet bekommen haben und deren Allelfrequenz kleiner als 1% ist.

## AFsnpeff_high_mod_transcripts.py
Die übrig gebliebenen Varianten aus ***AFvariants_high_moderate.sh*** müssen auf mindestens ein Transkript einen HIGH oder MODERATE Impact haben.
Dennoch können in der Datei weiterhin Transkripte mit LOW oder MODIFIER als Impact enthalten sein. Diese werden mithilfe dieses Skripts entfernt,
sodass nur noch Transkripte mit HIGH oder MODERATE Impact Inhalt der VCF sind.

## high_mod_onlyCDS_AF.sh
In diesem Skript werden die Varianten, die bereits hinsichtlich ihrer Allelfrequenz und Impact von SnpEff gefiltert wurden, weiterhin auf ihr Vorkommen in CDS beschränkt.

## upset_snpeff_AF.py
Dieses Skript erstellt UpSet Plots. Es wird für Varianten, die eine AF < 1% und einen HIGH und/oder MODERATE Impact haben, verwendet. 
Zusätzlich wird das Skript auch auf die noch zusätzlich auf CDS gefilterten Varianten angewandt.

## extract_subsets_snpeff_AF.py
Dieses Skript extrahiert die Varianten von den gruppenspezifischen Schnittmengen aus dem UpSet Plot. 
Dabei wird nur der UpSet Plot von den Varianten, die eine AF < 1% und einen HIGH und/oder MODERATE Impact haben, betrachtet.

## ensg_count_KT.py
Mit diesem Skript wird eine Kreuztabelle auf Genebene erstellt. 
Jede Zeile stellt ein Gen mit zugehöriger ENSG Nummer dar.
Zu jedem Gen ist außerdem bekannt, wieviele Varianten welcher Patient in diesem Gen aufweist und wieviele Varianten alle Patienten gemeinsam haben.
Dabei werden nur die Varianten betrachtet, die eine AF < 1%, einen HIGH und/oder MODERATE Impact haben und innerhalb einer CDS liegen.
Außerdem wird die Tabelle so gefiltert, dass in mindestens allen Nicht-Klassikern mindestens eine Variante in dem Gen vorkommen muss.


# SnpEff + Onko/TSG

## high_mod_transcripts_onco_AF.py
Dieses Skript filtert die VCF Datei, die alle Varianten enthält, die eine Allelfrequenz unter 1% und einen HIGH und/oder MODERATE Impact haben zusätzlich noch auf Onkogene und Tumorsupressorgene.
Dabei werden Onkogene und TSG separat betrachtet. Es werden Kreuztabellen erstellt, die dann als Input für ***plot_heatmap_AF_onco.R*** dienen, um die Daten als Heatmap darzustellen.




