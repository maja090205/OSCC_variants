In diesem Ordner befinden sich alle Skripte zur Analyse auserwählter Proteinsequenzen. 
Die Skripte wurden in der unten beschriebenen Reihenfolge ausgeführt.

## crossmap.sh
In diesem Skript wird die GFF Datei von GENCODE49 für jeden Patienten personalisiert. 
Dazu werden die liftover/chain Dateien, die in ***bcftools_consensus.sh*** im Ordner **k_mer** erstellt wurden, verwendet.

## gemoma.sh
In diesem Skript wird das Tool GeMoMa verwendet, um anhand der personalisierter GFF Datei und Genom die patientenspezifischen Proteinsequenzen zu extrahieren.
Dazu wurde im ersten Durchlauf der Parameter **p** auf **true** gesetzt, damit die Proteinsequenzen extrahiert werden.
Da viele Proteinsequenzen in den output Dateien nicht existieren, wurde ein erneuter Durchlauf mit **d=false** und **r=true** gestartet.
Dadurch sollten auch einige Proteinsequenzen, die von GeMoMa nicht übersetzt werden würden (z.B. aufgrund eines premature stop), in den Dateien auftauchen.

## mafft.sh
Mit diesem Skript werden Alignments für ausgewählte Proteinsequenzen mittels MAFFT erstellt.

