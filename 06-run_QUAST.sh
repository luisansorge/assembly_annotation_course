#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=QUAST
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lansorge/assembly_annotation_course
OUTDIR=/data/users/lansorge/assembly_annotation_course/QUAST

# Run QUAST inside Apptainer container to evaluate genome assemblies
# Input assemblies:
#   - Flye assembly FASTA
#   - Hifiasm primary contigs FASTA
#   - LJA assembly FASTA
# Options:
#   -o            : output directory for QUAST report
#   --eukaryote   : perform eukaryotic-specific assessment
#   --est-ref-size: estimated genome size
#   --threads     : number of threads
#   --labels      : custom labels for assemblies
#   --pacbio      : input PacBio reads for additional evaluation
#   --no-sv       : skip structural variant analysis
apptainer exec --bind /data \
    /containers/apptainer/quast_5.2.0.sif \
    quast.py \
    $WORKDIR/flye_assembly/assembly.fasta \
    $WORKDIR/hifiasm_assembly/Abd-0.asm.bp.p_ctg.fa \
    $WORKDIR/LJA_assembly/assembly.fasta \
    -o $OUTDIR \
    --eukaryote --est-ref-size 135000000 --threads 16 --labels Flye,Hifiasm,LJA --pacbio $WORKDIR/Abd-0/*fastq.gz --no-sv 
     

