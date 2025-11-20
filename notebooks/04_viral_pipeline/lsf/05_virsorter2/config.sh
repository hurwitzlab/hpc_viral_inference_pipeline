export ID=MY_ID
export IN_LIST="/your/path/to/repo/hpc_viral_inference_pipeline/data/sra_accessions.txt"    # Path to the SRA accessions file
export IN_DIR="/path/to/contigs"                                                            # Directory containing assembled contigs
export VIRSORTER_SIF="/path/to/container/image"                                             # Path to the metaSPAdes container

# Create output directory if it doesn't exist
mkdir -p /path/to/working/dir/05_virsorter2_output
export OUT_DIR="/path/to/working/dir/05_virsorter2_output"          # Output directory for VirSorter2 results