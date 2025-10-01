#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=trinityassembly
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lansorge/assembly_annotation_course/RNAseq_Sha
OUTDIR=/data/users/lansorge/assembly_annotation_course/trinity_assembly

# Load trinity module
module load Trinity/2.15.1-foss-2021a 

# Run Trinity RNA-seq assembler
# --seqType fq   : input reads are FASTQ
# --left / --right : paired-end read files (forward and reverse)
# --CPU          : number of threads to use
# --max_memory   : maximum memory for Trinity
# --output       : directory for assembly output
Trinity --seqType fq --left $WORKDIR/*_1.fastq.gz --right $WORKDIR/*_2.fastq.gz --CPU 16 --max_memory 60G --output $OUTDIR
