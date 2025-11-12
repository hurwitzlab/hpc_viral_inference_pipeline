# 00: Data Download
=================
This directory contains the LSF script to download SRA data using `prefetch` from the SRA Toolkit within an Apptainer container. 

Some HPCs lack internet connection in their compute nodes. When compute nodes lack internet access, these tasks must be performed on the login node. However, remember that we CANNOT run computationally intensive tasks on the login node. Some of these processes, like downloading large databases, can be resource-intensive and could violate cluster policies if executed directly on the login node without proper resource management. 

To address this challenge, the script utilizes GNU Parallel to perform multiple downloads concurrently in the login node, optimizing the use of available CPU resources and avoiding conflict with other users.


## What is GNU Parallel?

GNU Parallel is a **command-line tool that allows you to execute multiple jobs simultaneously while controlling resource usage**. Think of it as a way to run several commands at once, but with intelligent management of how many processes run at any given time. Instead of running tasks sequentially (one after another) or launching them all at once (which could overwhelm the system), GNU Parallel lets you specify how many jobs should run in parallel. For example, if you need to download 100 datasets, you could tell GNU Parallel to download 4 at a time—as soon as one download finishes, it automatically starts the next one until all are complete.

This controlled parallelization is particularly valuable on login nodes, where we need to be mindful of resource consumption while still completing tasks efficiently. By limiting the number of concurrent processes, GNU Parallel allows us to perform necessary downloads and installations **without monopolizing** the login node's resources or violating cluster policies. 

It also provides useful features like progress monitoring, automatic retry of failed jobs, and the ability to resume interrupted work—making it an essential tool for managing data-intensive tasks in restricted HPC environments.


## Downloading data from SRA
First, create a text file listing the SRA accession numbers you want to download with one accession number per line (see file: `hpc_viral_inference_pipeline/data/sra_accessions.txt`). 

Then, modify the script `00_data_download.sh` to set the paths to your work directory, GNU Parallel binary, and SRA Toolkit Apptainer container. Finally, run the script on the login node to start downloading the data using GNU Parallel.    

