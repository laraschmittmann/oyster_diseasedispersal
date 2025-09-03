#!/bin/bash
#SBATCH --job-name=dask_job
#SBATCH -n 10
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=32G
#SBATCH --time=02:00:00
#SBATCH --partition=base

# make sure we have Singularity
module load gcc12-env/12.3.0
module load singularity/3.11.5

CONTAINER_FILE="parcels-container_2024.09.03-a28f69b.sif"

# Set up dask cluster
# srun --ntasks=1 -N1 --exclusive singularity run -B /sfs -B /gxfs_work1 -B $PWD:/work --pwd /work $CONTAINER_FILE bash -c \
#         ". /opt/conda/etc/profile.d/conda.sh && conda activate parcels \
#         && dask-scheduler --scheduler-file scheduler.json" &
sleep 15  # allow for the scheduler to come up
srun --ntasks=10 --exclusive singularity run -B ${TMPDIR} -B /gxfs_work -B $PWD:/work --pwd /work $CONTAINER_FILE bash -c \
        ". /opt/conda/etc/profile.d/conda.sh && conda activate parcels \
        && dask-worker --scheduler-file scheduler.json --nprocs=1 --nthreads=2 --memory-limit=64G --local-directory ${TMPDIR}" &

wait

# print resource infos
jobinfo

