07: Viral protein annotation with Prokka 
=================
This directory contains scripts and configuration files to run Prokka on high-quality viral inferences as part of a viral inference pipeline using an LSF job scheduler.

The launcher script `run_prokka.sh` submits a job array to the LSF scheduler, where each job in the array processes a different sample from the input list through the `07_prokka.lsf` job script. The configuration file `config.sh` allows you to set parameters such as the input list of samples, working directory, and paths to necessary containers and pass them on to the launcher and the job script.

## Files in this directory
- `run_prokka.sh`: This is the main launcher script that submits the job array to the LSF scheduler.
- `07_prokka.lsf`: This is the LSF job script that runs prokka on the raw sequencing reads for each sample.
- `config.sh`: This configuration file allows you to set parameters such as the input list of samples, working directory, and paths to necessary containers.    

## How to use these scripts
1. Modify the `config.sh` file to set the appropriate paths and parameters for your analysis.
2. Run the `run_prokka.sh` script to submit the job array to the LSF scheduler.
3. Monitor the job status using LSF commands (e.g., `bjobs`, `bpeek`, etc.) to check the progress of the prokka analyses.

## Prerequisites
- Access to an HPC cluster with LSF job scheduler.
- Apptainer/Singularity installed on the cluster.
- Prokka container available on the cluster.
- Prokka database available on the cluster (See 00_data_download).
- Paired reads cleaned with trimmomatic files available in the specified working directory.  

## Output


## About Prokka
Prokka is a software tool used for the rapid annotation of prokaryotic genomes, including viral genomes. It identifies genes, coding sequences (CDS), and other genomic features, and assigns functional annotations based on various databases. Prokka is widely used in microbial genomics for its speed and accuracy in genome annotation. For more information, visit the [Prokka documentation]()

## Parameters used in this pipeline: 
```bash
apptainer exec ${PROKKA_SIF} prokka \
    --outdir "${OUT_DIR}/${SAMPLE}_prokka_output" \
    --prefix "${SAMPLE}_prokka" \
    --cpus 2 \                                   
    --kingdom Viruses \
    --addgenes \
    --force \
    "${IN_DIR}/${SAMPLE}_checkv_output/${SAMPLE}_checkv_complete.fasta"
```
- `--outdir`: Specifies the output directory for Prokka results.
- `--prefix`: Sets the prefix for output files.
- `--cpus`: Allocates the number of CPU threads for Prokka to use.
- `--kingdom Viruses`: Indicates that the input sequences are viral genomes.
- `--addgenes`: Instructs Prokka to add gene features to the output
- `--force`: Overwrites existing output files if they already exist.


