In diesem Ordern befinden sich alle Skripte, die für den GATK Workflow verwendet wurden.
Alle Skripte wurden in der unten beschriebenen Reihenfolge ausgeführt.

## run_AddReadGroups.sh
In diesem Skript werden den Reads jeder bam-Datei eine eindeutige Readgruppe zugeorndet. 
Dieser Schritt ist notwendig, da noch folgende Teilschritte des Workflows Readgruppen voraussetzen.
***AddReadGroups*** wird für jeden Patienten einzeln angewendet.

## run_MarkDuplicates.sh
Dieses Skript wendet ***MarkDuplicates*** auf die bam-Dateien an. 
Dabei werden Duplikate, also Reads die vom gleichen DNA-Fragment entstanden sind, markiert. 
Dadurch wird ein Bias, der für falsch positive Varianten sorgen kann, verhindert.
***MarkDuplicates*** wird für jeden Patienten einzeln angewendet.

## run_bqsr.sh
Die ***Base Quality Score Recalibration*** wird in diesem Skript für jeden Patienten einzeln durchgeführt.
Dabei werden die Qualitätswerte jeder Base korrigiert, um die Anzahl sowohl falsch positiver als auch falsch negativer Varianten zu minimieren.

## run_HaplotypeCaller.sh
In diesem Skript wird der ***HaplotypeCaller*** für jeden Patienten einzeln angewendet. 
Der ***HaplotypeCaller*** rekonstruiert mögliche Haplotypen und berechnten von diesen den Wahrscheinlichsten.
Anschließend wird für jeden Patienten eine VCF mit den enthaltenen Varianten erstellt.

## joint_genotyping.sh
Dieses Skript verwendet ***CombineGVCFs*** und ***GenotypeGVCFs***, um die 6 VCF Dateien der Patienten zu einer gemeinsamen VCF Datei zusammenzufügen.

## run_VQSR.sh
Zum Schluss des Workflows werden die Varianten anhand verschiedenster Qualitätsmetriken gefiltert.

## calc_intersection.py
Mit diesem Skript wird aus der VCF Datei des GATK Workflows ein UpSet Plot erstellt, der die Schnittmengen zwischen den Patienten darstellt.

## onlyPC_onlyCDS_variants.sh
In diesem Skript wird die GFF Datei von GENCODE49 auf Einträge proteinkodierender Gene und CDS gefiltert.
Anschließend wird die VCF Datei einmal auf Varianten, die sich in proteinkodierenden Genen befindet, und einmal auf Varianten, die sich in CDS befinden, beschränkt.

## calc_intersection_onlyPC.py
Dieses Skript ist ähnlich zu ***calc_intersection.py***. 
Der UpSet Plot wird hier lediglich nur für die Varianten erstellt, die sich in proteinkodierenden Genen befinden.

## calc_intersection_onlyCDS.py
Dieses Skript ist ähnlich zu ***calc_intersection.py***. 
Der UpSet Plot wird hier lediglich nur für die Varianten erstellt, die sich in CDS befinden.

## extract_subsets.py
Mithilfe dieses Skripts werden aus allen drei UpSet Plots die Varianten der gruppenspezifischen Schnittmengen extrahiert.


