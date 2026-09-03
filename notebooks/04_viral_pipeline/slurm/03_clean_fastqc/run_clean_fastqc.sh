#! /bin/bash
# This script submits a job array on a SLURM scheduler to run FastQC on clean reads
# Each job array will process multiple samples in parallel
# The number of samples is determined by the number of lines in the input list file
# --------------------------------------------------


# load job configuration
source ./config.sh


# make sure sample file is in the right place
if [[ ! -f "$IN_LIST" ]]; then
    echo "$IN_LIST does not exist. Please provide the path for a list of datasets to process. Job terminated."
    exit 1
fi

export JOB1="03_clean_fastqc"  # this is not necessary but will be useful for consistency in larger pipelines

# get number of samples to process
# the number of samples will be used to set the range of the job array
export NUM_JOB=$(wc -l < "$IN_LIST")

# submit job arrays for each step
echo "launching ${JOB1}.slurm as a job."
JOB_ID=$(sbatch --job-name=$JOB1 \
    --array=1-$NUM_JOB \
    --ntasks=1 \
    --cpus-per-task=$CPUS \
    --nodes=$NODES \
    --partition=$PARTITION \
    --account=$ACCOUNT \
    --mem=$MEM \
    --time=$TIME \
    --output=$STD_OUT \
    --error=$STD_ERR \
    ./${JOB1}.slurm | awk '{print $4}')
echo "Submitted job array with ID $JOB_ID"
