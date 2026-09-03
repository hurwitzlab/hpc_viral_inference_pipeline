#!/bin/bash
# ==================================================
# Prokka Job Script for SLURM HPC clusters
# ==================================================
# This script runs Prokka for viral protein annotation
# using an Apptainer Container
#
# Resource requests are not embedded here — they are passed by run_prokka.sh
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
if [ ! -f "${PROKKA_SIF}" ]; then
    echo "ERROR: Container not found at ${PROKKA_SIF}"
    exit 1
fi

# Check if input directory exists
if [ ! -d "${IN_DIR}" ]; then
    echo "ERROR: Input directory not found at ${IN_DIR}"
    exit 1
fi

# --------------------------------------------------
# Execute Prokka
# --------------------------------------------------

echo "Running Prokka on sample: ${SAMPLE}"

# --cpus should match the --cpus-per-task value requested above
apptainer exec $BIND ${PROKKA_SIF} prokka \
    --outdir "${OUT_DIR}/${SAMPLE}_prokka_output" \
    --prefix "${SAMPLE}_prokka" \
    --cpus $CPUS \
    --kingdom $KINGDOM \
    --addgenes \
    --force \
    "${IN_DIR}/${SAMPLE}_checkv_output/${SAMPLE}_checkv_complete.fasta"

# Check if Prokka completed successfully
if [ $? -eq 0 ]; then
    echo "Prokka completed successfully"
else
    echo "ERROR: Prokka failed with exit code $?"
    exit 1
fi

# --------------------------------------------------
# Job completion
# --------------------------------------------------

echo "=================================================="
echo "Job completed: $(date)"
echo "Results saved to: ${OUT_DIR}"
echo "=================================================="
