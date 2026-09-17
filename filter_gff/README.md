Mit den Skripten, die sich in diesem Ordner befinden, wurde die GFF Datei von GENCODE49 anhand der genomischen Features gefiltert.
Die Skripte wurden in der unten angegeben Reihenfolge gestartet.

## filter_gff.sh
Die GFF Datei wird nach Genen, Transkripten, Exons, CDS, Startcodons und Stopcodons gefiltert, sodass für jedes genomische Feature eine separate Datei existiert.

## extract_introns.py
Da keine Annotationen über Introns in der GFF Datei enthalten sind, werden diese anhand von Exons berechnet.