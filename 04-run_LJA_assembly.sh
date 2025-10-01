#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=LJAassembly
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lansorge/assembly_annotation_course/Abd-0
OUTDIR=/data/users/lansorge/assembly_annotation_course/LJA_assembly

# Run LJA assembler inside Apptainer container
# -t        : number of threads
# -o        : output directory for assembly results
# --reads   : input PacBio HiFi reads in FASTQ format
apptainer exec --bind /data \
    /containers/apptainer/lja-0.2.sif \
    lja -t 16 -o $OUTDIR --reads $WORKDIR/ERR11437323.fastq.gz