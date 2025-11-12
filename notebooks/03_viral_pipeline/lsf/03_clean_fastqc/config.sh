export ID=MY_ID
export IN_LIST="/path/to/my_accessions"
export IN_DIR="/path/to/clean_reads"  # Directory containing clean reads
export FASTQC_SIF="/rs1/shares/brc/admin/containers/images/quay.io_biocontainers_fastqc:0.12.1--hdfd78af_0.sif"     # Path to the FastQC container

# Create output directory if it doesn't exist
# (let me know if you find a better way to do this that works)
mkdir -p /path/to/working/dir/03_clean_fastqc_results
OUT_DIR="/path/to/working/dir/03_clean_fastqc_results"