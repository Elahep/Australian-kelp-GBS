## Final SNP calling results for *D. potatorum* and *M. pyrifera*:


* *D. potatorum*:

After quality control and removong low-quality samples, I ended up with 123 samples. Stacks parameters were optimized to maximize the assembled r80 loci. 
Accordingly, we will use M5, n6 and m3 for de novo assembly of loci.

### gstacks results:

### samples depth of coverage:

### number of SNPs and missing data for each different *populations* runs with different r parameters:

-r70 --max-obs-het 0.6  ->   ( SNPs, loci, missing data)

-r70 --max-obs-het 0.6 --write-random-snp   ->  ( SNPs, loci, missing data)

-r50 --max-obs-het 0.6   ->  ( SNPs, loci, missing data)

-r50 --max-obs-het 0.6 --write-random-snp   ->  ( SNPs, loci, missing data)




* *M. pyrifera*:

After quality control and removong low-quality samples, I ended up with 50 samples. Stacks parameters were optimized to maximize the assembled r80 loci. 
Accordingly, we will use M3, n4 and m3 for de novo assembly of loci.

### gstacks results:

Genotyped 76483 loci:
  effective per-sample coverage: mean=42.9x, stdev=10.7x, min=18.3x, max=70.1x
  
### number of SNPs and missing data for each different *populations* runs with different r parameters:

(*missing SNP per sample for each VCF file can be found in attached .imiss files*)

-r70 --max-obs-het 0.6 ->  (11534 SNPs,11534 loci,29.4% missing data)

-r70 --max-obs-het 0.6 --write-random-snp  ->  (18,634 SNPs,11648 loci,33.72% missing data)

-r50 --max-obs-het 0.6  ->  (25356 SNPs,14649 loci,38.43% missing data)

-r50 --max-obs-het 0.6 --write-random-snp  ->  (14544 SNPs,14544 loci,32.71% missing data)


