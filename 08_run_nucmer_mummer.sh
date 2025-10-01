#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=nucmer_mummer
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lansorge/assembly_annotation_course
OUTDIR=$WORKDIR/nucmer_mummer
CONTAINER_PATH="/containers/apptainer/mummer4_gnuplot.sif"

# Reference genome
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

# Assemblies to compare
FLYE=$WORKDIR/flye_assembly/assembly.fasta
HIFIASM=$WORKDIR/hifiasm_assembly/Abd-0.asm.bp.p_ctg.fa
LJA=$WORKDIR/LJA_assembly/Elh-2_assembly/assembly.fasta

# Create output directory if it doesn't exist
mkdir -p $OUTDIR

# Run Nucmer/MUMmer inside Apptainer container
apptainer run --bind /data $CONTAINER_PATH bash <<EOF

# Move into output directory so nucmer/mummerplot write results here
cd $OUTDIR

# Align assemblies against reference 

# --prefix          : prefix for output files
# --breaklen 1000   : minimum length of a maximal exact match cluster
# --mincluster      : minimum bases in a cluster
# -R                : reference sequence for plot
# -Q                : query sequence for plot
# --filter          : filter small/ambiguous matches
# -t png            : output format PNG
# --large           : large genome mode
# --layout          : scaled axes layout
# --fat             : thick lines for matches 
# -p                : output prefix

nucmer --prefix=flye_vs_ref --breaklen 1000 --mincluster 1000 $REF $FLYE
mummerplot -R $REF -Q $FLYE --filter -t png --large --layout --fat -p flye_vs_ref flye_vs_ref.delta

nucmer --prefix=hifiasm_vs_ref --breaklen 1000 --mincluster 1000 $REF $HIFIASM
mummerplot -R $REF -Q $HIFIASM --filter -t png --large --layout --fat -p hifiasm_vs_ref hifiasm_vs_ref.delta

nucmer --prefix=lja_vs_ref --breaklen 1000 --mincluster 1000 $REF $LJA
mummerplot -R $REF -Q $LJA --filter -t png --large --layout --fat -p lja_vs_ref lja_vs_ref.delta

# Compare assemblies to each other
nucmer --prefix=flye_vs_hifiasm --breaklen 1000 --mincluster 1000 $FLYE $HIFIASM
mummerplot -R $FLYE -Q $HIFIASM --filter -t png --large --layout --fat -p flye_vs_hifiasm flye_vs_hifiasm.delta

nucmer --prefix=flye_vs_lja --breaklen 1000 --mincluster 1000 $FLYE $LJA
mummerplot -R $FLYE -Q $LJA --filter -t png --large --layout --fat -p flye_vs_lja flye_vs_lja.delta

nucmer --prefix=hifiasm_vs_lja --breaklen 1000 --mincluster 1000 $HIFIASM $LJA
mummerplot -R $HIFIASM -Q $LJA --filter -t png --large --layout --fat -p hifiasm_vs_lja hifiasm_vs_lja.delta

EOF