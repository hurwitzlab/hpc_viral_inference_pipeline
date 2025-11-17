export ID=MY_ID
export IN_LIST="/your/path/to/repo/hpc_viral_inference_pipeline/data/sra_accessions.txt"    # Path to the SRA accessions file
export IN_DIR="/path/to/raw_reads"                                                          # Directory containing raw reads
export FASTQC_SIF="/path/to/container/image"                                                # Path to the Trimmomatic container

# Create output directory if it doesn't exist
mkdir -p /path/to/working/dir/02_trimmomatic_results/clean_reads            # This will be the directory for the clean reads
export OUT_DIR="/path/to/working/dir/02_trimmomatic_results/clean_reads"

mkdir -p /path/to/working/dir/02_trimmomatic_results/unpaired_reads         # This will be the directory for the unpaired reads
export UNPAIR_DIR="/path/to/working/dir/02_trimmomatic_results/unpaired_reads"