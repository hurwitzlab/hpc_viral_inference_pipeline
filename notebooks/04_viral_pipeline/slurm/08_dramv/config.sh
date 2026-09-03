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
export DRAMV_SIF="/path/to/dramv_container.sif"   # Path to the DRAM-v container

export IN_DIR="/path/to/checkv_output"                                                            # Directory containing high-quality viral inferences from CheckV

# Create output directory if it doesn't exist
mkdir -p /path/to/working/dir/08_dramv_output
export OUT_DIR="/path/to/working/dir/08_dramv_output"              # Output directory for DRAM-v results


# --------------------------------------------------
# Execution parameters
# --------------------------------------------------
export BIND="--bind /rs1:/rs1"
export MIN_CONTIG_SIZE=3000                        # Minimum contig size for DRAM-v
export DRAMV_DB_DIR="/path/to/dramv_database"     # Path to the DRAM-v database
export MIN_SCORE=0.8                              # minimum score to consider a viral contig high-quality
export MIN_COMPLETENESS=50                        # minimum completeness percentage to consider a viral contig high
