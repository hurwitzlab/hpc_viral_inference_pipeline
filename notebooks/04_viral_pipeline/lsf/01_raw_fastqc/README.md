01: Raw Quality Assessment with FastQC 
=================
This directory contains scripts and configuration files to run FastQC on raw sequencing reads as part of a viral inference pipeline using an LSF job scheduler.

The launcher script `run_raw_fastqc.sh` submits a job array to the LSF scheduler, where each job in the array processes a different sample from the input list through the `01_raw_fastqc.lsf` job script. The configuration file `config.sh` allows you to set parameters such as the input list of samples, working directory, and paths to necessary containers and pass them on to the launcher and the job script.

## Files in this directory
- `run_raw_fastqc.sh`: This is the main launcher script that submits the job array to the LSF scheduler.
- `01_raw_fastqc.lsf`: This is the LSF job script that runs FastQC on the raw sequencing reads for each sample.
- `config.sh`: This configuration file allows you to set parameters such as the input list of samples, working directory, and paths to necessary containers.    

## How to use these scripts
1. Modify the `config.sh` file to set the appropriate paths and parameters for your analysis.
2. Run the `run_raw_fastqc.sh` script to submit the job array to the LSF scheduler.
3. Monitor the job status using LSF commands (e.g., `bjobs`, `bpeek`, etc.) to check the progress of the FastQC analyses.

## Prerequisites
- Access to an HPC cluster with LSF job scheduler.
- Apptainer/Singularity installed on the cluster.
- FastQC container available on the cluster.
- Input FASTQ files available in the specified working directory.  

## Output
The FastQC results will be saved in the specified output directory within the working directory, organized by sample. Each sample will have its own FastQC report files.

## About FastQC
Following import, we always want to check the quality of the data going into an analysis. Unless you have supreme confidence in your viral isolation, extraction, sequencing preparation, and sequencing facility skills, it's always a good idea to know what quality is going into an assembly. To quote a populat CS phrase, "Garbage In, Garbage Out." Essentially, this means that if you put poor quality data into your analysis, you're going to get poor quality results out.

FastQC is a widely used quality control tool for high-throughput sequencing data. It provides a comprehensive overview of the quality metrics of sequencing reads, helping researchers identify potential issues with their data before proceeding to downstream analyses. For more information about FastQC, visit the [FastQC website](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/).  
