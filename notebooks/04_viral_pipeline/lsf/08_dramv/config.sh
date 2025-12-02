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
# --------------------------------------------------
export DRAMV_SIF="/path/to/dramv_container.sif"   # Path to the DRAM-v container

export IN_DIR="/path/to/checkv_output"                                                            # Directory containing assembled contigs                                                     # Path to the metaSPAdes container

# Create output directory if it doesn't exist
mkdir -p /path/to/working/dir/07_prokka_output
export OUT_DIR="/path/to/working/dir/07_prokka_output"              # Output directory for Prokka results


# --------------------------------------------------
# Execution parameters
# --------------------------------------------------
export BIND="--bind /rs1:/rs1"    
export MIN_CONTIG_SIZE=3000                        # Minimum contig size for DRAM-v
export DRAMV_DB_DIR="/path/to/dramv_database"     # Path to the DRAM-v database
export MIN_SCORE=0.8                              # minimum score to consider a viral contig high-quality    
export MIN_COMPLETENESS=50                        # minimum completeness percentage to consider a viral contig high

