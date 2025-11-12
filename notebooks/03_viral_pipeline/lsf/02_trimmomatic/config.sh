export ID=MY_ID
export IN_LIST="/path/to/my_accessions"
export IN_DIR="/path/to/raw_reads"  # Directory containing raw reads
export FASTQC_SIF="/rs1/shares/brc/admin/containers/images/"     # Path to the Trimmomatic container

# Create output directory if it doesn't exist
# (let me know if you find a better way to do this that works)
mkdir -p /path/to/working/dir/02_trimmomatic_results/clean_reads        # This will be the directory for the clean reads
OUT_DIR="/path/to/working/dir/02_trimmomatic_results/clean_reads"

mkdir -p /path/to/working/dir/02_trimmomatic_results/unpaired_reads
UNPAIR_DIR="/path/to/working/dir/02_trimmomatic_results/unpaired_reads"