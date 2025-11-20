export ID=MY_ID
export IN_LIST="/your/path/to/repo/hpc_viral_inference_pipeline/data/sra_accessions.txt"          # Path to the SRA accessions file
export IN_DIR="/path/to/checkv_output"                                                            # Directory containing assembled contigs
export PROKKA_SIF="/path/to/container/image"                                                      # Path to the metaSPAdes container

# Create output directory if it doesn't exist
mkdir -p /path/to/working/dir/07_prokka_output
export OUT_DIR="/path/to/working/dir/07_prokka_output"              # Output directory for Prokka results