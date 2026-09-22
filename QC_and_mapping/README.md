In diesem Ordner befinden sich alle Skripte, die für Qualitäts-Checks und das Mapping von Reads, verwendet wurden.
Die Skripte wurden in der unten beschriebenen Reihenfolge ausgeführt.

## run_fastqc.sh
FastQC wird für die Qualitätsüberprüfung der rohen Sequenzierungsdaten verwendet.

## run_bwa-mem2.sh
Die Reads wurden mittels BWA-MEM2 gegen das Referenzgenom gemappt.

## run_stats.sh
In diesem Skript werden samtools stats und mosdepth für weitere Qualitäts-Checks verwendet.

## only_mutliqc.sh
Dieses Skript erstellt aus den Ergebnissen von FastQC, samtools stats und mosdepth einen gemeinsamen MultiQC report.

## merge_bam.sh
Für zwei Patienten war eine Nachsequenzierung nötig. Dadurch besitzen diese zur Zeit zwei bam-Dateien.
Die bam-Dateien werden in diesem Skript zusammengefügt.

