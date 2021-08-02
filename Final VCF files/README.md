## Final SNP calling results for *D. potatorum* and *M. pyrifera*:



* *D. potatorum*:


After quality control and removong low-quality samples, I ended up with 123 samples. Stacks parameters were optimized to maximize the assembled r80 loci. 
Accordingly, we will use M5, n6 and m3 for de novo assembly of loci.


### gstacks results:





### number of SNPs and missing data for each different *populations* runs with different r parameters:

`-r70 --max-obs-het 0.6`  ->   ( SNPs, loci, missing data)

`-r70 --max-obs-het 0.6 --write-random-snp`   ->  ( SNPs, loci, missing data)

`-r50 --max-obs-het 0.6`   ->  ( SNPs, loci, missing data)

`-r50 --max-obs-het 0.6 --write-random-snp`   ->  ( SNPs, loci, missing data)





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


