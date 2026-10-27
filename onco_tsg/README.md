In diesem Ordner sind alle Skripte enthalten, die für die Filterung der Varianten aus dem GATK Workflow auf Onkogene und Tumorsupressorgene (TSG), verwendet wurden.
Die Skripte wurden in der unten angegebenen Reihenfolge ausgeführt.

## filter_oncogene.sh
Dieses Skript extrahiert nur die Varianten, die sich in Exons oder CDS von Onkogenen (aus der Genliste von OnkoKB) befinden.

## filter_tsg.sh
Dieses Skript extrahiert nur die Varianten, die sich in Exons oder CDS von Tumorsupressorgenen (aus der Genliste von OnkoKB) befinden.

## kreuztabelle_onco.py
Dieses Skript erstellt eine Kreuztabelle, in der für jedes Onkogen oder TSG die Information über die Existenz einer Variante für jeden Patienten gespeichert ist.
Dabei wird nur zwischen der Abwesenheit (0) und dem Vorhandensein (1) mindestens einer Variante unterschieden. 
Die Anzahl der Varianten innerhalb eines Transkripts wird hierbei nicht gezählt.

## plot_heatmap_onco.R
Dieses Skript wird für das Erstellen von Heatmaps verwendet. 
In den Heatmaps stehen rote Felder (1) für das Vorhandensein einer Variante in diesem speziellen Transkript. 
Die grünen Felder (0) symbolisieren dementsprechend die Abwesenheit von Varianten.

