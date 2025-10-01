#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=fastp
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lansorge/assembly_annotation_course
INDIR=$WORKDIR/Abd-0
OUTDIR=$WORKDIR/fastp

# Create output directory if it doesn't exist
mkdir -p $OUTDIR

# Input read (single-end)
R1=$INDIR/ERR11437323.fastq.gz

# Run fastp without filtering, just to get total bases in HTML report
apptainer exec --bind /data \
    /containers/apptainer/fastp_0.23.2--h5f740d0_3.sif \
    fastp \
    -w 4 \                                                # Use 4 threads
    -i $R1 \                                              # Input FASTQ
    -o $OUTDIR/ERR11437323.fastp_out.fastq.gz \           # Output FASTQ
    -h $OUTDIR/fastp_report.html \                        # HTML report
    --disable_adapter_trimming \                          # Disable adapter trimming
    --disable_quality_filtering \                         # Disable quality filtering
    --disable_length_filtering                            # Disable length filtering