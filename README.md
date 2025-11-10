# HPC Viral Inference Pipeline

This repository contains training materials and scripts for running a viral metagenomic analysis pipeline based on the workflow from [KBase narrative 126189/27](https://kbase.us/n/126189/27/).



## Overview

This pipeline demonstrates how to process metagenomic datasets to identify, classify, and annotate viral sequences using bioinformatics tools. It serves as both a learning resource and a practical implementation guide for viral metagenomics on high-performance computing (HPC) systems.

## Pipeline Workflow

The pipeline processes a single metagenomic dataset from the Global Ocean Viromes collection through the following steps:

1. **Data Acquisition**: Download metagenomic data from NCBI SRA
2. **Assembly**: Assemble reads using metaSPAdes
3. **Viral Identification**: Identify viral sequences with VirSorter2
4. **Classification**: Classify viral contigs using vConTACT2
5. **Annotation**: Annotate sequences with:
   - Prokka (gene prediction and functional annotation)
   - DRAM-v (viral metabolic annotation)


## Contents
```
├── scripts/          # Pipeline execution scripts
├── data/            # Sample data and test datasets
├── configs/         # Configuration files for tools
├── notebooks/       # Training notebooks and tutorials
└── docs/            # Additional documentation
```

## Prerequisites

- Access to an HPC cluster with job scheduling (e.g., SLURM, PBS)
- Apptainer or Singularity installed for containerized execution
- Basic knowledge of command-line operations and bioinformatics tools (See [link to training on UNIX])


## Contact

[Contact information for questions and support]