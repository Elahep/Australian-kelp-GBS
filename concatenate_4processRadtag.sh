#!/bin/bash

##a way to concatenate the results of process_radtags. Run the code below in the directory that ONLY and ONLY includes
##the outputs of process_radtags (4 files per each sample). No other file should be in that directory.

ls | cat | grep -vE "list.txt|concatenate_4processRadtag.sh" > list.txt  ##create a list which includes the names of all files (4 per each sample)
										##created by process_radtags. names are sorted alphabetically.
awk "NR%2==0" list.txt > cat0_1.txt ##cuts even lines from the list file and saves that in a new file
awk "NR%2==1" list.txt > cat1_1.txt  ##cuts the odd lines
awk "NR%2==0" cat0_1.txt > cat0_2.txt ##keep cutting odd and even lines!!
awk "NR%2==1" cat0_1.txt > cat0_3.txt
awk "NR%2==0" cat1_1.txt > cat1_2.txt
awk "NR%2==1" cat1_1.txt > cat1_3.txt
sed 's/rem.*2.//' cat0_2.txt | awk '{print "\t>\t"$0}' > names.txt ##get the names of all your samples (with .fq.gz extension) and add ">" before names.
paste cat0_2.txt cat0_3.txt cat1_2.txt cat1_3.txt names.txt | column -s $'\t' -t | awk '{print "cat\t"$0}' > concatenate.sh ##append files from previous steps columnwise
##to clean up the files you don't need:
rm names.txt cat*.txt list.txt

###Now you have "concatenate.sh" which can be run in the same directory to FINALLY concatenate the 4 files! :)