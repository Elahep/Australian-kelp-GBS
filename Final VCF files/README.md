## Final SNP calling results for *D. potatorum* and *M. pyrifera*:



* *D. potatorum*:


After quality control and removong low-quality samples, I ended up with 155 samples. Stacks parameters were optimized to maximize the assembled r80 loci. 
Accordingly, we will use M5, n6 and m3 for de novo assembly of loci.

Note that at the end, some *D. potatorum* samples had 80% missing data. However, I did not exclude them and I kept them in the final VCFs. You can always use *VCFtools* to check the number of missing SNP per sample and remove those samples that you think may cause problems in your population genomic inference due to the high levels of missing data.


### gstacks results:

Genotyped 258026 loci:
  effective per-sample coverage: mean=70.8x, stdev=19.7x, min=32.4x, max=174.2x



### number of SNPs and missing data for each different *populations* runs with different r parameters:

`-r70 --max-obs-het 0.6`  ->   17175 loci, 59,729 SNPs, 56.47 percent missing data

`-r70 --max-obs-het 0.6 --write-random-snp`   ->  16903 SNPs, 62.66 percent missing data

`-r50 --max-obs-het 0.6`   ->  25344 loci, 87,081 SNPs, 59.72 percent missing data

`-r50 --max-obs-het 0.6 --write-random-snp`   ->  25026 SNPs, 66.96 percent missing data



  *****       *****     *****
  

* *M. pyrifera*:




After quality control and removong low-quality samples, I ended up with 50 samples. Stacks parameters were optimized to maximize the assembled r80 loci. 
Accordingly, we will use M3, n4 and m3 for de novo assembly of loci.


### gstacks results:

Genotyped 76483 loci:
  effective per-sample coverage: mean=42.9x, stdev=10.7x, min=18.3x, max=70.1x
  
  
### number of SNPs and missing data for each different *populations* runs with different r parameters:

(*missing SNP per sample for each VCF file can be found in attached .imiss files*)

`-r70 --max-obs-het 0.6` ->  11648 loci, 18,633 SNPs, 33.72 percent missing data

`-r70 --max-obs-het 0.6 --write-random-snp`  ->  11476 SNPs, 29.85 percent missing data 

`-r50 --max-obs-het 0.6`  ->  14650 loci, 25,357 SNPs, 38.43 percent missing data

`-r50 --max-obs-het 0.6 --write-random-snp`  ->  14487 SNPs, 33.18 percent missing data


