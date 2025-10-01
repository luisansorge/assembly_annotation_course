#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=fastp
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lansorge/assembly_annotation_course
INDIR=$WORKDIR/RNAseq_Sha
OUTDIR=$WORKDIR/fastp

R1=$INDIR/*_1.fastq.gz             # Read 1 files (forward reads)
R2=$INDIR/*_2.fastq.gz             # Read 2 files (reverse reads)

# Run fastp inside Apptainer container
apptainer exec --bind /data \
    /containers/apptainer/fastp_0.23.2--h5f740d0_3.sif \
    fastp -w 4 -i $R1 -I $R2 \     # Use 4 threads, input R1 and R2
    -o $OUTDIR/ERR754081_1.trimmed.fastq.gz \   # Output trimmed R1
    -O $OUTDIR/ERR754081_2.trimmed.fastq.gz \   # Output trimmed R2
    -h $OUTDIR/fastp_report.html   # HTML report