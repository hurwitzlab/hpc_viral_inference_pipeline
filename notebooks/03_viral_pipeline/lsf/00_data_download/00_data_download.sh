#! /bin/bash
# create some variables for a more clean script
CPUS=3
PARALLEL=/rs1/shares/brc/admin/tools/parallel-20250922/bin/parallel                                                         # your path to GNU parallel
JOBLOG=/your_workdir/path/download_log.txt                                                                                  # your path to joblog file       
SRA_CONTAINER=/rs1/shares/brc/admin/containers/images/quay.io_biocontainers_sra-tools:3.2.1--h4304569_1.sif                 # your path to sra-tools apptainer container

# run gnu parallel downloads with joblog
cat sra_accessions.txt | $PARALLEL -j $CPUS --progress --joblog $JOBLOG "apptainer exec $SRA_CONTAINER prefetch {}"