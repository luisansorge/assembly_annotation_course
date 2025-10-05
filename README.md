# Genome and Transcriptome Assembly Project

This repository contains scripts and instructions for **assembling and evaluating the genome and transcriptome** of Arabidopsis thaliana accessions using PacBio HiFi and Illumina RNA-Seq data.

## Datasets

- **Whole genome PacBio HiFi reads** for each accession (`Abd-0`)  
- **Whole transcriptome Illumina RNA-seq** for accession Sha (`RNAseq_Sha`)  

## Workflow Overview

### 1. Quality Control
- **FastQC**: Assess raw read quality. (`01-run_fastqc.sh`)
- **fastp**: Trim/filter RNA-seq reads and generate base counts for HiFi reads. (`02-run_fastp.sh` / `02a-run_fastp.sh`)

### 2. K-mer Analysis
- **Jellyfish**: Count k-mers (`jellyfish count`) and generate histograms (`jellyfish histo`) for genome size estimation and read analysis. (`03-run_kmercounts.sh`)
- **GenomeScope2**: Visualize k-mer histograms.

### 3. Assembly
- **Genome assembly**:
  - **Flye** (`04-run_flye_assembly.sh`)
  - **Hifiasm** (`04-run_hifiasm_assembly.sh`) – convert GFA to FASTA as needed
  - **LJA** (`04-run_LJA_assembly.sh`)
- **Transcriptome assembly**:
  - **Trinity** (`04-run_trinity_assembly.sh`) – supports multiple fastq files

### 4. Assembly Evaluation
- **BUSCO** (`05-run_BUSCO.sh`) – completeness based on conserved single-copy orthologs
- **QUAST** (`06-run_QUAST.sh`, `06a_run_QUAST_reference.sh`) – genome assembly quality metrics
- **Merqury** (`07_run_merqury.sh`) – k-mer based assembly evaluation

### 5. Genome Comparison
- **NUCmer/MUMmer** (`08_run_nucmer_mummer.sh`) – align assemblies to the reference genome and each other; generate dotplots.

## Notes
- Check the comments in the individual scripts for the specific options used

