05: Viral sequence inference with VirSorter2 
=================
This directory contains scripts and configuration files to run VirSorter2 on assembled contigs as part of a viral inference pipeline using an LSF job scheduler.

The launcher script `run_virsorter2.sh` submits a job array to the LSF scheduler, where each job in the array processes a different sample from the input list through the `05_virsorter2.lsf` job script. The configuration file `config.sh` allows you to set parameters such as the input list of samples, working directory, and paths to necessary containers and pass them on to the launcher and the job script.

## Files in this directory
- `run_virsorter2.sh`: This is the main launcher script that submits the job array to the LSF scheduler.
- `05_virsorter2.lsf`: This is the LSF job script that runs virsorter2 on the raw sequencing reads for each sample.
- `config.sh`: This configuration file allows you to set parameters such as the input list of samples, working directory, and paths to necessary containers.    

## How to use these scripts
1. Modify the `config.sh` file to set the appropriate paths and parameters for your analysis.
2. Run the `run_virsorter2.sh` script to submit the job array to the LSF scheduler.
3. Monitor the job status using LSF commands (e.g., `bjobs`, `bpeek`, etc.) to check the progress of the virsorter2 analyses.

## Prerequisites
- Access to an HPC cluster with LSF job scheduler.
- Apptainer/Singularity installed on the cluster.
- VirSorter2 container available on the cluster.
- VirSorter2 database available on the cluster (See 00_data_download).
- Paired reads cleaned with trimmomatic files available in the specified working directory.  

## Output
The VirSorter2 results for each sample will be saved in the specified output directory within the working directory. Each sample will have its own subdirectory containing the identified viral sequences and related files.

## About VirSorter2
VirSorter2 is a tool designed to identify viral sequences from metagenomic data. It uses a combination of reference-based and machine learning approaches to classify sequences as viral or non-viral. For more information, visit the [VirSorter2 documentation](https://github.com/jiarong/VirSorter2). 

VirSorter2 performs equivalent to OR superior than nearly all other tools at 3-5 kb and greater. That said, it is important to recognize that database and algorithm improvements often bias the most recently published tools. Always be aware of the databases used to train the model(s) and benchmarks employed by every virus identification tool. Many tools often only examine/benchmark using viral RefSeq, which is heavily biased towards human and human-affecting (e.g. commercial crops) viruses.

VirSorter2 default parameters are fine to use. If you want to use DRAM-v on the output, you will need to enable the "Enable DRAM-v outputs" flag. Also, be sure to include the virus groups. Since our data derives from a marine sample and has not undergone any type of RNA-focused extraction/amplification, we only need to use dsDNA phage and ssDNA. In this example, I've also enabled "Only output high confidence viral sequences." Other options are either situational or adjust the level of sensitivity or specificity in virus identification.

## VirSorter2 Workflow

The figure below illustrates the VirSorter2 computational workflow for identifying viral sequences from assembled contigs:

![VirSorter2 Workflow Diagram. Figure modified from [Guo et al (2021) Microbiome](https://microbiomejournal.biomedcentral.com/articles/10.1186/s40168-020-00990-y)](virsorter_workflow.png)

### Workflow Steps

**1. Input and Database Integration**
VirSorter2 begins with assembled contigs and integrates multiple customizable databases including:

- Prodigal RBS motifs for gene prediction
- Hidden Markov Model databases (hmmDB)
- Hallmark viral genes
- Pre-trained classifiers

**2. Feature Extraction**
The pipeline performs two key analyses on the contigs:

- **Viral hallmark gene identification**: Detects genes that are characteristic of viral genomes
- **Circular sequence detection**: Identifies circular viral genomes, a common feature of many viruses
- **Gene prediction**: Uses Prodigal to predict at least 2 genes per contig, generating both nucleotide (faa - amino acid) and nucleotide (gff - gene feature format) files

**3. Feature Annotation**
Predicted genes are annotated with:

- HMM-based functional annotations
- Taxonomic features derived from database matches
- Genomic features including structural characteristics

**4. Classification and Scoring**
Multiple classifiers evaluate each contig and generate scores based on the extracted features. These scores are compiled into a comprehensive feature table and score table.

**5. Sequence Categorization**
Sequences are classified based on their maximum classifier scores relative to a cutoff threshold:

- **Max score ≥ cutoff**: Classified as "near full viral sequences"
- **Max score < cutoff**: Classified as "other sequences"

**6. Final Output**
The workflow produces two categories of output:

- **Trimmed full viral sequences**: High-confidence complete or near-complete viral genomes after boundary trimming
- **Partial viral sequences**: Viral sequences extracted using the "provirus extraction" module, which identifies integrated viral sequences within larger contigs

This multi-tiered approach combining reference databases, gene-based features, and machine learning classifiers enables VirSorter2 to accurately identify viral sequences while distinguishing them from cellular sequences in metagenomic assemblies.

## Parameters used in this pipeline: 
```bash
apptainer exec ${VIRSORTER_SIF} virsorter run -w ${OUT_DIR}/${SAMPLE}_virsorter2_output \
    -i ${IN_DIR}/${SAMPLE}_metaspades_output/${SAMPLE}_contigs.fasta \
    --include-groups dsDNAphage,ssDNA \
    --min-length 3000 \
    --min-score 0.5 \
    -j 16 \
    all \
    --prep-for-dramv
```
- `-w`: This option specifies the working directory where the VirSorter2 results will be saved.        
- `-i`: This option specifies the input file containing the assembled contigs to be analyzed.
- `--include-groups`: This option allows you to specify which viral groups to include in the analysis. In this case, both dsDNA phages and ssDNA viruses are included.
- `--min-length`: This option sets the minimum length for contigs to be considered for viral identification. Contigs shorter than this length will be ignored. In this case, contigs shorter than 3000 base pairs will not be analyzed.
- `--min-score`: This option sets the minimum score threshold for classifying a sequence as viral. Sequences with scores below this threshold will not be classified as viral. In this case, a minimum score of 0.5 is used.
- `-j`: This option sets the number of threads to be used for the VirSorter2 process, allowing for parallel processing and faster execution. Default is set to 16 threads.
- `all`: This argument specifies that all available databases and models should be used for viral identification.   
- `--prep-for-dramv`: This flag prepares the output for downstream annotation with DRAM-v, a tool for annotating viral genomes.


