#!/bin/bash
# ==================================================
# CHECKV2 Job Script for SLURM HPC clusters
# ==================================================
# This script runs CheckV for viral inference quality control.
# using an Apptainer Container
#
# Resource requests are not embedded here — they are passed by run_checkv.sh
# via sbatch flags sourced from config.sh, same as the other steps in this
# pipeline.

# --------------------------------------------------
# Load modules here
# --------------------------------------------------

module load apptainer

# --------------------------------------------------
# Execute commands here
# --------------------------------------------------

# Print job start information
echo "=================================================="
echo "Job started: $(date)"
echo "Job ID: $SLURM_JOB_ID"
echo "Running on host: $(hostname)"
echo "Working directory: $(pwd)"
echo "=================================================="

# Source config file and get sample name from input list based on job array index
source ./config.sh
export SAMPLE=`head -n +${SLURM_ARRAY_TASK_ID} $IN_LIST | tail -n 1`


# --------------------------------------------------
# Validate inputs
# --------------------------------------------------

# Check if container exists
if [ ! -f "${CHECKV_SIF}" ]; then
    echo "ERROR: Container not found at ${CHECKV_SIF}"
    exit 1
fi

# Check if input directory exists
if [ ! -d "${IN_DIR}" ]; then
    echo "ERROR: Input directory not found at ${IN_DIR}"
    exit 1
fi

# --------------------------------------------------
# Execute CheckV
# --------------------------------------------------

echo "Running CheckV on sample: ${SAMPLE}"

# -t (threads) should match the --cpus-per-task value requested above
apptainer exec $BIND ${CHECKV_SIF} checkv end_to_end \
    "${IN_DIR}/${SAMPLE}_virsorter2_output/${SAMPLE}_virsorter2_cat-1-2.fasta" \
    "${OUT_DIR}/${SAMPLE}_checkv_output" \
    -t $CPUS \
    -d $CHECKV_DB

# Check if CheckV completed successfully
if [ $? -eq 0 ]; then
    echo "CheckV completed successfully"
else
    echo "ERROR: CheckV failed with exit code $?"
    exit 1
fi

# --------------------------------------------------
# Job completion
# --------------------------------------------------

echo "=================================================="
echo "Job completed: $(date)"
echo "Results saved to: ${OUT_DIR}"
echo "=================================================="
