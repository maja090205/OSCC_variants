In diesem Ordner finden sich alle Skripte zur Erstellung der patientenbezogenen Genome und K-Mer Analyse.
Die Skripte wurden in der unten dargestellten Reihenfolge ausgeführt.

## bcftools_consensus.sh
Dieses Skript erstellt mithilfe von bcftools consensus ein personenbezogenes Genom für jeden Patienten.
Dafür werden die Varianten des jeweiligen Patienten aus der VCF Datei in das Referenzgenom übernommen.

## jellyfish.sh 
In diesem Skript wird das Tool Jellyfish verwendet, um die patientenbezogenen Genome jeweils in K-Mere zu unterteilen und deren Häufigkeit zu dokumentieren.

## sort_dump_jf.sh
Um das Erstellen einer Matrix aus den K-Meren im nächsten Schritt zu vereinfachen, werden hier die count-Dateien, in denen die Häufigkeit jedes K-Mers dokumentiert ist, lexikografisch sortiert.

## kmer_matrix.py
Aus den 6 count-Dateien aller Patienten wird nun eine gemeinsame Matrix erstellt. 
Jede Zeile repräsentiert ein K-Mer mit zugehöriger Häufigkeit für jeden Patienten.
Die Matrix wird aufgrund der Menge an K-Meren bereits gefiltert, bevor sie gespeichert wird. 

## t_test_kmer_matrix.py
Ein T-Test wird verwendet, um signifikante Unterschiede im Vorkommen von K-Meren zwischen den Gruppen, zu erfassen.
Dabei wird der Student's T-Test (Annahme gleicher Varianz) angewendet. 

## mw_test.py
Da die Daten nicht für den T-Test geeignet sind, wird die "Signifikanz" anhand von Mittelwert-Vergleichen berechnet. 