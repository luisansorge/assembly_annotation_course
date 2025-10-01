#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=BUSCO
#SBATCH --partition=pibu_el8

INPUT=/data/users/lansorge/assembly_annotation_course/flye_assembly/assembly.fasta
OUTDIR=/data/users/lansorge/assembly_annotation_course

cd $OUTDIR

# Load BUSCO module
module load BUSCO/5.4.2-foss-2021a 

# Run BUSCO genome assessment on different assembly (Flye, higiasm, LJA)
# -i    : input assembly file
# -m    : mode (genome or transcriptome)
# -l    : lineage dataset
# -c    : number of threads
# -o    : output prefix/directory
busco -i $INPUT -m genome -l brassicales_odb10 -c 16 -o flye_busco

#Additional assembly runs with BUSCO
#busco -i $INPUT -m genome -l brassicales_odb10 -c 16 -o hifiasm_busco
#busco -i $INPUT -m genome -l brassicales_odb10 -c 16 -o LJA_busco
#busco -i $INPUT -m transcriptome -l brassicales_odb10 -c 16 -o trinity_busco