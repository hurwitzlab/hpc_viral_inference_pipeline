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
export TIME=10:00:00                                 # Maximum time for job completion (HH:MM:SS)


# --------------------------------------------------
# Input/Output directories
# --------------------------------------------------
export IN_DIR="/path/to/virsorter_output"                                                   # Directory containing assembled contigs
export CHECKV_SIF="/path/to/container/image"                                                # Path to the CheckV container

# Create output directory if it doesn't exist
mkdir -p /path/to/working/dir/06_checkv_output
export OUT_DIR="/path/to/working/dir/06_checkv_output"              # Output directory for CheckV results


# --------------------------------------------------
# Execution parameters
# --------------------------------------------------
export BIND="--bind /rs1:/rs1"
export CHECKV_DB="/path/to/checkv-db"                    # Path to the CheckV database
