02: Read Quality Control with Trimmomatic 
=================
This directory contains scripts and configuration files to run Trimmomatic on raw sequencing reads as part of a viral inference pipeline using an LSF job scheduler.

The launcher script `run_trimmomatic.sh` submits a job array to the LSF scheduler, where each job in the array processes a different sample from the input list through the `02_trimmomatic.lsf` job script. The configuration file `config.sh` allows you to set parameters such as the input list of samples, working directory, and paths to necessary containers and pass them on to the launcher and the job script.

## Files in this directory
- `run_trimmomatic.sh`: This is the main launcher script that submits the job array to the LSF scheduler.
- `02_trimmomatic.lsf`: This is the LSF job script that runs trimmomatic on the raw sequencing reads for each sample.
- `config.sh`: This configuration file allows you to set parameters such as the input list of samples, working directory, and paths to necessary containers.    

## How to use these scripts
1. Modify the `config.sh` file to set the appropriate paths and parameters for your analysis.
2. Run the `run_trimmomatic.sh` script to submit the job array to the LSF scheduler.
3. Monitor the job status using LSF commands (e.g., `bjobs`, `bpeek`, etc.) to check the progress of the trimmomatic analyses.

## Prerequisites
- Access to an HPC cluster with LSF job scheduler.
- Apptainer/Singularity installed on the cluster.
- trimmomatic container available on the cluster.
- Input FASTQ files available in the specified working directory.  

## Output
The trimmomatic results will be saved in two output directories within the working directory, organized by sample. One directory will contain the paired trimmed reads, and the other will contain the unpaired trimmed reads.

## About Trimmomatic
Trimmomatic is a flexible read trimming tool for Illumina NGS data. It is designed to perform a variety of useful trimming tasks for Illumina paired-end and single-ended data, including **adapter removal**, **quality trimming**, and **filtering of reads based on length**. Trimming low-quality bases and removing adapter sequences can significantly improve the quality of downstream analyses, such as assembly and variant calling. For more information about trimmomatic, visit the [trimmomatic GitHub page](http://www.usadellab.org/cms/?page=trimmomatic).

Here we run Trimmomatic in paired-end mode, which means that both reads in a pair are processed together. If one read in a pair is discarded due to poor quality or other reasons, its mate will be placed in the unpaired output file. This ensures that the integrity of paired-end data is maintained as much as possible while still allowing for the removal of low-quality reads.

### Trimmomatic Parameters Used
The specific Trimmomatic parameters used in this pipeline are as follows:
```bash
apptainer run ${TRIMMOMATIC} trimmomatic PE -phred33 -threads 4 \
    ${IN_DIR}/${SAMPLE}_R1*.fastq* ${IN_DIR}/${SAMPLE}_R2*.fastq* \
    ${OUT_DIR}/${SAMPLE}_R1.fastq.gz ${OUT_DIR}/${SAMPLE}_R1.fastq.gz \
    ${UNPAIR_DIR}/${SAMPLE}_R2.fastq.gz ${UNPAIR_DIR}/${SAMPLE}_R2.fastq.gz \
    ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:100 HEADCROP:15
```
Where the parameters mean:

- `ILLUMINACLIP:TruSeq3-PE.fa:2:30:10`: This parameter specifies the adapter clipping settings. It uses the `TruSeq3-PE.fa` adapter file, allowing up to 2 mismatches, with a palindrome clip threshold of 30 and a simple clip threshold of 10.
- `SLIDINGWINDOW:4:20`: This parameter performs a sliding window trimming, cutting once the average quality within a window of 4 bases falls below a quality score of 20.
- `MINLEN:100`: This parameter discards reads that are shorter than 100 bases after trimming.
- `HEADCROP:15`: This parameter removes the first 15 bases from the start of each read.
These parameters are chosen to balance the removal of low-quality data while retaining as much useful information as possible for downstream analyses.  

