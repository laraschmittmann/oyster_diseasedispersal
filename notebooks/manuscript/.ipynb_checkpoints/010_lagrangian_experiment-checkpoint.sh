#!/bin/bash
#SBATCH --job-name=north-sea_oysters_lagrangian_experiment_manuscript
#SBATCH --ntasks=100
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=24:00:00
#SBATCH --partition=base

# make sure we have Singularity
module load gcc12-env
module load singularity/3.11.5 

# to get the image (need to be on a partition which has internet access --> data), run
# $ singularity pull --disable-cache --dir "${PWD}" docker://quay.io/willirath/parcels-container:2022.07.14-801fbe4

# make sure the output exists
mkdir -p notebooks_executed/manuscript

runtime_days=28
start_depth_meters=4
number_particles=100_000
RNG_seed=$(od -vAn -N4 -tu4 < /dev/random | tr -d [:blank:])
for year in 2019 2020 2021 2022; do
    sleep 1.5
    start_date_reference="${year}-05-15T00:00:00"
    for start_date_offset_days in {0..121}; do #mid May till mid September
        # run for single notebook and put into background
        srun --ntasks=1 --exclusive singularity run -B /sfs -B /gxfs_work -B $PWD:/work --pwd /work parcels-container_2022.07.14-801fbe4.sif bash -c \
        ". /opt/conda/etc/profile.d/conda.sh && conda activate base \
        && papermill --cwd notebooks/manuscript \
            notebooks/manuscript/010_lagrangian_experiment.ipynb \
            notebooks_executed/manuscript/010_lagrangian_experiment_RNG-seed-${RNG_seed}_start-date-reference-${start_date_reference}_start-date-offset-days-${start_date_offset_days}_start-depth-meters-${start_depth_meters}.ipynb \
            -p RNG_seed ${RNG_seed} \
            -p start_date_reference ${start_date_reference} \
            -p start_date_offset_days ${start_date_offset_days} \
            -p runtime_days ${runtime_days} \
            -p start_depth_meters ${start_depth_meters} \
            -p number_particles ${number_particles} \
            -k python" &
    done
done

# wait till background task is done
wait

# print resource infos
jobinfo
