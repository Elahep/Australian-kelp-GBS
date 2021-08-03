# Analyzing GBS data of two Australian kelp species: *Mcrocystis pyrifera* and *Durvillaea potatorum*.

During the past few years, 3 different runs of GBS has been done for these samples (let's call them CF0, CF1, CF2).
Most of the samples do not have enough reads, so we need to only include high-quality samples with a reasonabe number of reads. For this purpose we can exclude "bad samples" at two stage:

1- Before assembling loci by using FastQC and MultiQC.

2- After assembling loci by checking the VCF output file and removing individuals with more than 80% missing sites.

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

Now open *multiqc_report.html* to check the number of reads per sample. We have to consider a threshold to exclude low-quality samples. We can start by 0.5 million.
So any sample with less than 0.5 reads will be excluded. Accordingly, we can create a new *population map* file which only includes samples that passed this QC threshold. This *population map* file will be further updated by doing the 2nd step of quality control (see above).




Here is the list of the samples that failed the 0.5 million read threshold and will be removed from further analysis:

```
##samples in CF0 sequencing run:
rm Dur4mi1.fq.gz
rm DurBic28.fq.gz
rm DurBic29.fq.gz
rm DurBic5.fq.gz
rm DurBic8.fq.gz
rm DurFis7.fq.gz
rm DurLad6.fq.gz
rm DurStH19.fq.gz

##samples in CF1 sequencing run:
rm K1.fq.gz
rm K11.fq.gz
rm K14.fq.gz
rm K15.fq.gz
rm K16.fq.gz
rm K17.fq.gz
rm K18.fq.gz
rm K19.fq.gz
rm K2.fq.gz
rm K20.fq.gz
rm K21.fq.gz
rm K22.fq.gz
rm K23.fq.gz
rm K24.fq.gz
rm K25.fq.gz
rm K3.fq.gz
rm K5.fq.gz
rm K6.fq.gz
rm K7.fq.gz
rm Pass20.fq.gz
rm Pass8.fq.gz
rm SC12.fq.gz
rm TA18.fq.gz
rm TA2.fq.gz
rm TA21.fq.gz
rm TA22.fq.gz
rm TA3.fq.gz
rm TA8.fq.gz
rm TA9.fq.gz

##samples in CF2 sequencing run:
rm Mac4ml36.fq.gz
rm Mac4ml41.fq.gz
rm Mac4ml42.fq.gz
rm MacEdn1.fq.gz
rm MacEdn2.fq.gz
rm MacFish4.fq.gz
rm MacFish5.fq.gz
rm MacFish7.fq.gz
rm MacFish8.fq.gz
rm MacKey1.fq.gz
rm MacKey2.fq.gz
rm MacKey3.fq.gz
rm MacKey5.fq.gz
rm MacKey6.fq.gz
rm MacKey8.fq.gz
rm MacShel10.fq.gz
rm MacShel11.fq.gz
rm MacShel13.fq.gz
rm MacShel14.fq.gz
rm MacShel6.fq.gz
rm MacShel8.fq.gz
rm MacShel9.fq.gz
rm potLady7.fq.gz
rm potPas29.fq.gz
rm potPas30.fq.gz
rm potPas31.fq.gz
rm potPas34.fq.gz
rm potPas35.fq.gz
```


After removing these samples, run *denovo_map.pl* for each species separately and check the amount of missing SNPs per individual using *VCFtools*:

```
denovo_map.pl --samples /*Macrocystis or Durvillaea samples* --popmap /*population map file* -o ./ -M 3 -n 4 -m 3 -r 0.8 -X "populations: --vcf"

vcftools --vcf populations.snps.vcf --missing-indv
```

The following samples had more than 80% missing data in r80 loci:

```
rm K10.fq.gz
rm K12.fq.gz
rm K13.fq.gz
rm K4.fq.gz	
rm K8.fq.gz	
rm K9.fq.gz	
rm potFish27.fq.gz
rm potFish28.fq.gz
rm potFish32.fq.gz
rm potLady1.fq.gz
rm potLady10.fq.gz
rm potLady11.fq.gz
rm potLady12.fq.gz
rm potLady13.fq.gz
rm potLady14.fq.gz
rm potLady15.fq.gz
rm potLady2.fq.gz
rm potLady3.fq.gz
rm potLady4.fq.gz
rm potLady5.fq.gz
rm potLady6.fq.gz
rm potLady8.fq.gz
rm potLady9.fq.gz
rm potRoar35.fq.gz
rm potRoar36.fq.gz
rm potRoar37.fq.gz
rm potRoar38.fq.gz
rm potRoar39.fq.gz
rm potRoar40.fq.gz
rm potRoar41.fq.gz
rm potRoar42.fq.gz
rm potRoar43.fq.gz
rm potRoar44.fq.gz
rm potSkn26.fq.gz
rm potSkn27.fq.gz
rm potSkn28.fq.gz
rm potSkn29.fq.gz
rm potSkn30.fq.gz
rm CF0_DurBic30.fq.gz
rm CF0_DurFis3.fq.gz
rm CF0_DurLad2.fq.gz
rm CF0_DurLad3.fq.gz
rm CF0_DurLad4.fq.gz
rm CF0_DurRoa11.fq.gz
rm CF0_DurRoa21.fq.gz
rm CF0_DurRoa22.fq.gz
rm CF0_DurRoa23.fq.gz
rm CF0_DurRoa24.fq.gz
rm CF0_DurRoa25.fq.gz
rm CF0_DurRoa26.fq.gz
rm CF0_DurRoa27.fq.gz
rm CF0_DurRoa28.fq.gz
rm CF0_DurRoa29.fq.gz
rm CF0_DurRoa3.fq.gz
rm CF0_DurRoa30.fq.gz
rm CF0_SC1.fq.gz
rm CF0_SC11.fq.gz
rm CF0_SC16.fq.gz
rm CF0_SC18.fq.gz
rm CF0_SC4.fq.gz
rm CF0_SC5.fq.gz
rm CF0_SC7.fq.gz
rm CF0_SC8.fq.gz
rm CF0_SC9.fq.gz
rm CF0_TA10.fq.gz
rm CF0_TA17.fq.gz
rm CF0_TA19.fq.gz
rm CF0_TA4.fq.gz
rm CF0_TA5.fq.gz
rm CF0_TA7.fq.gz
rm CF0_TV2.fq.gz
