#! /bin/bash
# create some variables for a more clean script
CPUS=3
PARALLEL=/path/to/gnu/parallel                                                                  # your path to GNU parallel
JOBLOG=/your_workdir/path/download_log.txt                                                      # your path to joblog file       
SRA_CONTAINER=/path/to/container/image                                                          # your path to sra-tools apptainer container
SRA_ACCESSIONS=/your/path/to/repo/hpc_viral_inference_pipeline/data/sra_accessions.txt          # your path to sra accessions file

# run gnu parallel downloads with joblog
cat $SRA_ACCESSIONS | $PARALLEL -j $CPUS --progress --joblog $JOBLOG "apptainer exec $SRA_CONTAINER prefetch {}"

