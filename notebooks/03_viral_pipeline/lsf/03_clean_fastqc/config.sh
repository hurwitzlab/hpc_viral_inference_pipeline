export ID=MY_ID
export IN_LIST="/your/path/to/repo/hpc_viral_inference_pipeline/data/sra_accessions.txt"    # Path to the SRA accessions file
export IN_DIR="/path/to/clean_reads"                                                        # Directory containing clean reads
export FASTQC_SIF="/path/to/container/image"                                                # Path to the FastQC container    # Path to the FastQC container

# Create output directory if it doesn't exist
mkdir -p /path/to/working/dir/03_clean_fastqc_results
OUT_DIR="/path/to/working/dir/03_clean_fastqc_results"