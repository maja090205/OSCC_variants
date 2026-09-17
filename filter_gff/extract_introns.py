import gffpandas.gffpandas as gffpd

#read GFF file which has already been filtered down to transcript annotations and convert it to DataFrame
transcript = gffpd.read_gff3('/data2/stud_agbio/apcsx/analysis/filtered_gff/transcript.gff3').df 
print(transcript.head())
#read GFF file which has already been filtered down to exon annotations and convert it to DataFrame
exon = gffpd.read_gff3('/data2/stud_agbio/apcsx/analysis/filtered_gff/exon.gff3').df 
print(exon.head())
print(transcript.columns)

#create a dictionary to save all exons related to one ENST number
exon_dict = {}
for i2, ex in exon.iterrows(): #iterate over all exon annotations
        attr_ex = ex["attributes"]
        enst_ex = attr_ex.split("Parent=")[1].split(";")[0] #extract ENST number of the exon

        if enst_ex not in exon_dict: #if ENST number doesn't exist in the dictionary already, add it
             exon_dict[enst_ex] = []
        
        exon_dict[enst_ex].append(ex) #add exon 
             

introns = []
#iterate over all transcript annotations
for i, tr in transcript.iterrows():
    attr = tr["attributes"]
    enst = attr.split("ID=")[1].split(";")[0] #extract ENST number

    exons = exon_dict.get(enst, []) #return exons if ENST of transcript exists in dictionary
        
    #at least two exons are necessary for one intron
    if len(exons)<2:
        continue

    #sort exons by start position (probably not necessary because GFF file is already sorted)
    exons = sorted(exons, key=lambda x: x["start"])

    #calculate introns
    for index in range(len(exons)-1):
        start_intron = exons[index]["end"]+1 #next position after the end of the exon before
        end_intron = exons[index+1]["start"]-1 #position before the next exon starts

        #add intron to list
        introns.append({"seq_id": tr["seq_id"], "start_intron": start_intron, "end_intron": end_intron, "strand": tr["strand"], "ENST": enst})

#save introns in GFF format
with open("/data2/stud_agbio/apcsx/analysis/filtered_gff/introns.gff3", "w") as out:
     for intron in introns:
          out.write(
            f"{intron['seq_id']}\t"
            f"script\t"
            f"intron\t"
            f"{intron['start_intron']}\t"
            f"{intron['end_intron']}\t"
            f".\t"
            f"{intron['strand']}\t"
            f".\t"
            f"Parent={intron['ENST']}\n"
        )