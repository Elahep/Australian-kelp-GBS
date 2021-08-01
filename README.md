# Analyzing GBS data of two Australian kelp species: *Mcrocystis pyrifera* and *Durvillaea potatorum*.

During the past few years, 3 different runs of GBS has been done for these samples (let's call them CF0, CF1, CF2).
Most of the samples do not have enough reads, so we need to only include high-quality samples with a reasonabe number of reads. For this purpose we can exclude "bad samples" at two stage:

1- Before assembling loci by using FastQC and MultiQC.

2- After assembling loci and before SNP calling following the guidelines in the recently published paper Cerca et al. 2020 (DOI: 10.1111/2041-210X.13562).

Step 1 will be done for each GBS run seperately. Then, we can put together the demultiplexed samples of each GBS run to assemble loci seperately for each species and then follow step 2.

So let's start by first demultiplexing raw reads and then moving to QC.

## Demultiplexing GBS raw reads using *process_radtags*:

```
module load Stacks
process_radtags -P -p ./CF2 -o ./CF2 -b ./CF2_barcodes_FINAL_forpaper.txt -e pstI -r -c -q -t 10 --inline-inline
```

*process_radtags* outputs 4 files per sample. In order to procede with the rest of the analyses, I will concatenate these four files so I will have only 1 *.fq.gz* file per sample which includes both forward and reverse reads. (Note that *denovo_map.pl* of Stacks has an option (*--paired* flag) which allows you to skip concatinating these 4 files. However, I usually concatenate the files to easily use them for QC using FastQC and MultiQC.)

I have written this bash script (let's call it concatenate_4processRadtag.sh) to make the concatenation easier. Run this in the directory that only contains the 4 output files of *process_radtags* for each sample. This script will create another script called *concatenate.sh* which should be run subsequently and that will eventually concatenate the 4 files per sample.


```
#!/bin/bash
ls | cat | grep -vE "list.txt|concatenate_4processRadtag.sh" > list.txt  ##creates a list which includes the names of all files (4 per each sample)
								         ##created by process_radtags. names are sorted alphabetically.
awk "NR%2==0" list.txt > cat0_1.txt ##cuts even lines from the list file and saves that in a new file
awk "NR%2==1" list.txt > cat1_1.txt  ##cuts the odd lines
awk "NR%2==0" cat0_1.txt > cat0_2.txt ##keep cutting odd and even lines!!
awk "NR%2==1" cat0_1.txt > cat0_3.txt
awk "NR%2==0" cat1_1.txt > cat1_2.txt
awk "NR%2==1" cat1_1.txt > cat1_3.txt
sed 's/rem.*2.//' cat0_2.txt | awk '{print "\t>\t"$0}' > names.txt ##get the names of all your samples (with .fq.gz extension) and add ">" before names.
paste cat0_2.txt cat0_3.txt cat1_2.txt cat1_3.txt names.txt | column -s $'\t' -t | awk '{print "cat\t"$0}' > concatenate.sh ##append files from previous steps columnwise
rm names.txt cat*.txt list.txt  ##to clean up the files you don't need.

###Now you have "concatenate.sh" which can be run in the same directory to FINALLY concatenate the 4 files!
```


## Quality control using FastQC and MultiQC

```
module load FastQC
module load MultiQC
fastqc ./*.fq.gz -t 10
multiqc ./
```

Now open *multiqc_report.html* to check the number of reads per sample. We have to consider a threshold to exclude the low-quality samples. We can start by 0.5 million.
So any sample with less than 0.5 reads will be excluded. Accordingly, we can create a new *population map* file which only includes samples that passed this QC threshold. This *population map* file will be further updated by doing the 2nd step of quality control (see above).
