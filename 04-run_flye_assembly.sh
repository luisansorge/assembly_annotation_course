#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flyeassembly
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lansorge/assembly_annotation_course/Abd-0
OUTDIR=/data/users/lansorge/assembly_annotation_course/flye_assembly

# Run Flye assembler inside Apptainer container
# --pacbio-hifi : input type is PacBio HiFi reads
# --out-dir     : directory where assembly results will be written
# --threads     : number of CPU threads to use
apptainer exec --bind /data \
    /containers/apptainer/flye_2.9.5.sif \
    flye --pacbio-hifi $WORKDIR/ERR11437323.fastq.gz --out-dir $OUTDIR --threads 16
