#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=fastqc
#SBATCH --partition=pibu_el8

WORKDIR=/data
OUTDIR=$WORKDIR/users/lansorge/assembly_annotation_course/read_QC

# Run FastQC inside Apptainer container
apptainer exec --bind $WORKDIR \
    /containers/apptainer/fastqc-0.12.1.sif \
    fastqc -t 4 -o $OUTDIR $WORKDIR/users/lansorge/assembly_annotation_course/RNAseq_Sha/*.fastq.gz