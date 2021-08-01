#!/bin/bash
#SBATCH --account=***
#SBATCH --job-name=prrtags
#SBATCH --partition=large
#SBATCH --time=14:00:00
#SBATCH --mem=8G
#SBATCH --output=./CF2/process_radtags.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=***
#SBATCH --cpus-per-task=10

#=======Load the module/software Environment
module load Stacks


##======My_Commands================
process_radtags -P -p ./CF2 -o ./CF2 -b ./CF2_barcodes_FINAL_forpaper.txt -e pstI -r -c -q -t 68 --inline-inline