#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=hifiasmassembly
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lansorge/assembly_annotation_course/Abd-0
OUTDIR=/data/users/lansorge/assembly_annotation_course/hifiasm_assembly

# Run hifiasm assembler inside Apptainer container
# -o   : prefix for output files (assembly graph, contigs, etc.)
# -t   : number of threads
# -f0  : disable fast mode (use default/standard assembly)
# Input: PacBio HiFi reads in FASTQ format
apptainer exec --bind /data \
    /containers/apptainer/hifiasm_0.25.0.sif \
    hifiasm -o $OUTDIR/Abd-0.asm -t 16 -f0 $WORKDIR/ERR11437323.fastq.gz
