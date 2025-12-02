# --------------------------------------------------
# Array job elements
# --------------------------------------------------
export ID=MY_ID
export IN_LIST="/your/path/to/repo/hpc_viral_inference_pipeline/data/sra_accessions.txt"    # Path to the SRA accessions file

# --------------------------------------------------   
# Resource parameters  
# --------------------------------------------------
export CPUS=2                                       # Number of CPUs to request
export QUEUE=shared_memory                         # Queue to submit jobs to
export NUM_HOSTS="span[hosts=1]"                    # Number of hosts to spread the jobs across
export MEM=4GB                               # Total memory for the job
export STD_OUT="./output.%J_%I.log"                  # Standard output file (%J is job name)
export STD_ERR="./error.%J_%I.log"                   # Standard error file (%I is job ID)
export TIME=02:00                                # Maximum time for job completion (HH:MM)


# --------------------------------------------------
# Input/Output directories
# --------------------------------------------------export IN_DIR="/path/to/virsorter_output"                                                   # Directory containing assembled contigs
export CHECKV_SIF="/path/to/container/image"                                                # Path to the metaSPAdes container

# Create output directory if it doesn't exist
mkdir -p /path/to/working/dir/06_checkv_output
export OUT_DIR="/path/to/working/dir/06_checkv_output"              # Output directory for CheckV results


# --------------------------------------------------
# Execution parameters
# --------------------------------------------------
export BIND="--bind /rs1:/rs1"           
export CHECKV_DB="/path/to/checkv-db"                    # Path to the CheckV database