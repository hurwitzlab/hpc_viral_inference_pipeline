#!/bin/bash
# ==================================================
# metaSPAdes Job Script for SLURM HPC clusters
# ==================================================
# This script runs metaSPAdes for metagenomic assembly of reads into contigs
# using an Apptainer Container

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
if [ ! -f "${METASPADES_SIF}" ]; then
    echo "ERROR: Container not found at ${METASPADES_SIF}"
    exit 1
fi

# Check if input directory exists
if [ ! -d "${IN_DIR}" ]; then
    echo "ERROR: Input directory not found at ${IN_DIR}"
    exit 1
fi

# --------------------------------------------------
# Execute metaSPAdes
# --------------------------------------------------

echo "Running metaSPAdes on sample: ${SAMPLE}"

# -t (threads) should match the --cpus-per-task value requested above
# -m (memory, GB) should match the --mem value requested above
apptainer exec $BIND ${METASPADES_SIF} metaspades.py \
    --meta \
    -1 ${IN_DIR}/${SAMPLE}_R1.fastq.gz \
    -2 ${IN_DIR}/${SAMPLE}_R2.fastq.gz \
    -o ${OUT_DIR}/${SAMPLE}_metaspades_output \
    -t $CPUS \
    -m $MEM \
    --min-contig-length $MIN_CONTIG_LEN \
    -k $K_VALUES

# Check if metaSPAdes completed successfully
if [ $? -eq 0 ]; then
    echo "metaSPAdes completed successfully"
else
    echo "ERROR: metaSPAdes failed with exit code $?"
    exit 1
fi

# --------------------------------------------------
# Job completion
# --------------------------------------------------

echo "=================================================="
echo "Job completed: $(date)"
echo "Results saved to: ${OUT_DIR}"
echo "=================================================="
