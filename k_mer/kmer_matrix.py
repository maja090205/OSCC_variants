#paths to dump files from jellyfish
paths = ["/data2/stud_agbio/apcsx/consensus/sorted/MKG32_sorted.tsv",
         "/data2/stud_agbio/apcsx/consensus/sorted/MKG34_sorted.tsv",
         "/data2/stud_agbio/apcsx/consensus/sorted/MKG64_sorted.tsv",
         "/data2/stud_agbio/apcsx/consensus/sorted/MKG53_sorted.tsv",
         "/data2/stud_agbio/apcsx/consensus/sorted/MKG66a_sorted.tsv",
         "/data2/stud_agbio/apcsx/consensus/sorted/MKG659_sorted.tsv"]

samples = ["MKG32", "MKG34", "MKG64", "MKG53", "MKG66a", "MKG659"] #same order as in paths

#opens all files to have access to all of them at the same time
files = []
for path in paths:
    files.append(open(path, "r")) #opens with only read access

#creates list for all files that have already been completed (False means not completed yet)
finish = [False] * 6 

#opens output file
out = open("/data2/stud_agbio/apcsx/consensus/kmer_matrix.tsv", "w")
out.write("kmer\t" + "\t".join(samples) + "\n") #adds header

kmers = []
counts = []
#considers first row of every file
for j, file in enumerate(files):
    line=file.readline() #reads out single row
        
    kmer = line.split()[0] #extracts k-mer 
    count = int(line.split()[1]) #extracts count for this k-mer
    #adds k-mer and count to list
    kmers.append(kmer)
    counts.append(count)

#loop runs until all files are completed
while not all(finish): 

    not_none_kmers = [kmer for kmer in kmers if kmer is not None] #do not consider None-entries
    curr_kmer = min(not_none_kmers) #save lexicografic smallest k-mer
    curr_counts = [] #to save counts for curr_kmer

    for k in range(6):
        if (kmers[k] == curr_kmer): #check if k-mer exists in sample
            curr_counts.append(counts[k]) #save count of this k-mer
            line= files[k].readline() #move on to next row in this file

            #file is not completed if line still exists 
            if line:
                kmer = line.split()[0] #extracts k-mer
                count = int(line.split()[1]) #extracts count for k-mer
                kmers[k] = kmer #update to next k-mer of this sample
                counts[k] = count #update count of the next k-mer

            else: #file is completed
                finish[k] = True
                counts[k] = 0
                kmers[k] = None 

        else:
            curr_counts.append(0) #add 0 as count if curr_kmer does not exists in sample
            

    #write entry in output file if k-mer passes the criteria
    if (sum(curr_counts[0:6]) >= 10):
        out.write(curr_kmer + "\t"+ "\t".join(str(x) for x in curr_counts) + "\n")

#close files
for file in files:
    file.close()

out.close()
