# Analyzing GBS data of two Australia kelp species: *Mcrocystis pyrifera* and *Durvillaea potatorum*.

During the past few years, 3 different runs of GBS have been done for these samples (let's call them CF0, CF1, CF2).
Most of the samples do not have enough reads, so we need to only include high-quality samples with enough reads. For this purpose we can exclude bad samples at two stages:

1- Before assembling the loci by using FastQC and MultiQC.
2- After assembling loci and before SNP calling following the guidelines in the recently published paper Cerca et al. 2020 (DOI: 10.1111/2041-210X.13562).

Step 1 will be done for each GBS run seperately. Then, we can put together the demultiplexed samples of each GBS run to assemble loci seperately for each species and then follow step 2.

So let's start by first demultiplexing the raw reads and then moving to QC.

## Demultiplexing GBS raw reads using *process_radtags*:

```
module load Stacks
process_radtags -P -p ./CF2 -o ./CF2 -b ./CF2_barcodes_FINAL_forpaper.txt -e pstI -r -c -q -t 10 --inline-inline
```

## Quality control using FastQC and MultiQC

```
module load FastQC
module load MultiQC
fastqc ./ -t 10
multiqc ./
```

Now open *multiqc_report.html* to check the number of reads per sample. We have to consider a threshold to exclude the low-quality samples. We can start by 0.5 million.
So any sample with less than 0.5 reads will be excluded. Accordingly, we can create a new *population map* file which only includes samples that passed this QC threshold. This *population map* file will be further updated by doing the step 2 quality control (see above).
