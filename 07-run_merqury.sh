#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=merqury
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lansorge/assembly_annotation_course
READS=$WORKDIR/Abd-0/*.fastq.gz
OUTDIR=$WORKDIR/merqury
CONTAINER_PATH="/containers/apptainer/merqury_1.3.sif"

mkdir -p $OUTDIR

FLYE=$WORKDIR/flye_assembly/assembly.fasta
HIFIASM=$WORKDIR/hifiasm_assembly/Abd-0.asm.bp.p_ctg.fa
LJA=$WORKDIR/LJA_assembly/assembly.fasta

# Path inside container
export MERQURY="/usr/local/share/merqury"

# Building meryl DB from HiFi reads
if [ ! -d "$OUTDIR/hifi.meryl" ]; then
  echo "Building meryl DB from reads..."
  apptainer exec --bind /data "$CONTAINER_PATH" \
    meryl count k=21 output "$OUTDIR/hifi.meryl" $READS
else
  echo "Using existing meryl DB: $OUTDIR/hifi.meryl"
fi

# Running Merqury for each assembly
for ASM in flye hifiasm lja; do
    echo "Running Merqury for $ASM..."
    mkdir -p "$OUTDIR/$ASM"
    cd "$OUTDIR/$ASM"
    
    if [ "$ASM" == "flye" ]; then
        ASMFILE="$FLYE"
    elif [ "$ASM" == "hifiasm" ]; then
        ASMFILE="$HIFIASM"
    elif [ "$ASM" == "lja" ]; then
        ASMFILE="$LJA"
    fi

    apptainer exec --bind /data "$CONTAINER_PATH" \
      $MERQURY/merqury.sh "$OUTDIR/hifi.meryl" "$ASMFILE" "$ASM"
done