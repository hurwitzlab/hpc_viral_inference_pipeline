# --------------------------------------------------
# Array job elements
# --------------------------------------------------
export ID=MY_ID
export IN_LIST="/your/path/to/repo/hpc_viral_inference_pipeline/data/sra_accessions.txt"    # Path to the SRA accessions file

# --------------------------------------------------
# Resource parameters
# --------------------------------------------------
export CPUS=2                                       # Number of CPUs to request (--cpus-per-task)
export PARTITION=standard                           # Partition to submit jobs to
export ACCOUNT=your_account                          # Account/group to charge the job to
export NODES=1                                       # Number of nodes to spread the jobs across
export MEM=4G                                        # Total memory for the job
export STD_OUT="./output.%A_%a.log"                  # Standard output file (%A is array job ID, %a is array task ID)
export STD_ERR="./error.%A_%a.log"                    # Standard error file
export TIME=02:00:00                                 # Maximum time for job completion (HH:MM:SS)


# --------------------------------------------------
# Input/Output directories
# --------------------------------------------------
export IN_DIR="/path/to/raw_reads"                                                          # Directory containing raw reads
export FASTQC_SIF="/path/to/container/image"                                                # Path to the Trimmomatic container

# Create output directory if it doesn't exist
mkdir -p /path/to/working/dir/02_trimmomatic_results/clean_reads            # This will be the directory for the clean reads
export OUT_DIR="/path/to/working/dir/02_trimmomatic_results/clean_reads"

mkdir -p /path/to/working/dir/02_trimmomatic_results/unpaired_reads         # This will be the directory for the unpaired reads
export UNPAIR_DIR="/path/to/working/dir/02_trimmomatic_results/unpaired_reads"


# --------------------------------------------------
# Execution parameters
# --------------------------------------------------
export BIND="--bind /rs1:/rs1"                       # Bind path for Apptainer, this is specific to your HPC environment
export ILLUMINACLIP=TruSeq3-PE-2.fa:2:30:10
export SLIDINGWINDOW=4:20
export MINLEN=100
export HEADCROP=15
