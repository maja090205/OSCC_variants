Dieser Ordner enthält alle Skripte, die für die Analyse mit SnpEff verwendet wurden. Zusätzlich ist das Skript zum Starten von NAVIP enthalten.
Die Skripte wurden in der unten aufgelisteten Reihenfolge ausgeführt.

## run_snpeff.sh
In diesem Skript wird die VCF Datei aus dem GATK Workflow mittels SnpEff annotiert.

## snpSift.sh
Dieses Skript dient der Filterung der annotierten VCF hinsichtlich der Auswirkungen der einzelnen Varianten. 
Dabei ist zu beachten, dass nach Varianten und nicht nach Transkripten gefiltert wird. 
Das bedeutet, dass die übrigen Varianten auch Transkripte enthalten können, die die Filterungsbedingung nicht erfüllen.
Die Varianten brauchen lediglich mindestens ein Transkript, welches die Bedingungen erfüllt, um auch nach der Filterung in der Datei enthalten zu bleiben.

## intersect_onlyCDS.sh
Die bereits nach Auswirkung auf das Protein gefilterten Varianten werden hier zusätzlich auf ihre Lage innerhalb einer CDS beschränkt.
Das bedeutet, es werden nur die Varianten behalten, die sich innerhalb einer CDS befinden.

## filter_high_enst.py
Die bisher auf HIGH und/oder MODERATE Impact gefilterten Varianten enthalten mindestens ein Transkript mit dieser Eigenschaft. 
Die Dateien enthalten aber auch noch Transkripte, die ein LOW oder MODIFIER Impact haben. Dieses Skript dient dazu, all diese Transkripte, 
die nicht HIGH und/oder MODERATE sind, zu entfernen.

## snpeff_high_transcripts_onco.py
Die zuletzt gefilterte Datei enthält nun zu jeder Variante nur noch die Transkripte, die einen HIGH und/oder MODERATE Impact enthalten. 
Anhand dieser Transkripte werden nun die Varianten auf krebsassoziierte Gene gefiltert. Somit wird eine Datei erstellt, die nur die Varianten enthält, 
die in Onkogenen/TSG vorkommen und auf diese einen HIGH und/oder MODERATE Impact haben. Zusätzlich ist bekannt, in welchen der Patienten die Variante vorkommt und in welchen nicht.

## extract_introns_effects.py
Mit diesem Skript werden Varianten gefiltert, die auf mindestens ein Transkript einen HIGH Impact haben und Introns betreffen. 
Dazu wird die Effekt-Annotation von SnpEff verwendet. 
Anschließend werden diese Varianten mittels snpeff_high_transcripts_onco.py auf Onkogene und TSG beschränkt.

## extract_snpEffect.py
In diesem Skript werden zu jedem Onkogen oder Tumorsupressorgen, welche mindestens eine Variante mit HIGH Impact haben, zusätzlich die von SnpEff bestimmten Effekte extrahiert.

## plot_snpeff_high_transcripts.py
Mit diesem Skript werden UpSet Plots erstellt. Das Skript wurde mehrfach verwendet mit jeweils einer anderen Eingabedatei.

## plot_heatmap.R
Dieses Skript wird für das Erstellen von Heatmaps verwendet. Hier wird das Skript nur für die Varianten verwendet, die einen HIGH/MODERATE Impact auf mindestens ein Transkript haben, welches zu einem Onkogen oder TSG gehört.
In den Heatmaps stehen rote Felder (1) für das Vorhandensein einer solchen Variante in diesem speziellen Transkript. Die grünen Felder (0) symbolisieren dementsprechend die Abwesenheit einer solchen Variante.

## navip.sh
Dieses Skript enthält beide Versuche, NAVIP erfolgreich zu verwenden.

