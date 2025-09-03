# North-Sea Oyster Connectivity

Track simulated larvae of oysters and virusses in the North Sea.

## Workflows

### Clone the repository

```shell
$ git clone https://github.com/geomar-od-lagrange/2022_north-sea_oysters.git
$ cd 2022_north-sea_oysters/
```

### Run experiments / develop code

The environment is specified in <https://github.com/geomar-od-lagrange/parcels-container>.

More on Containers: https://github.com/ExaESM-WP4/Containers-for-Scientific-Computing

#### Locally (e.g on you laptop)

With [Docker installed](https://docs.docker.com/get-docker/), you can run the latest stable version with:
```shell
$ docker pull quay.io/willirath/parcels-container:2021.09.29-09ab0ce
$ docker run -p 8888:8888 --rm -it -v $PWD:/work -w /work quay.io/willirath/parcels-container:2021.09.29-09ab0ce jupyter lab --ip=0.0.0.0
```

Once the container is up and running, connect to the link starting with `http://127.0.0.1...` that is displayed in the terminal.
You should see a JuptyerLab with the contents of this repository displayed in the left panel.

#### On NESH

##### Non-interactive

We can use the singularity container runtime. But we mostly run it headless / non-interactive.

See [this job-script](https://github.com/geomar-od-lagrange/2022_north-sea_oysters/blob/main/job_scripts/run_station_plot.sh) for an example of how we use [Papermill](https://papermill.readthedocs.io/) to execute this [example notebook](https://github.com/geomar-od-lagrange/2022_north-sea_oysters/blob/main/notebooks/exploratory/2022-07-12_add-and-check-station-data.ipynb).

##### Interactive

First, see [this guide](https://git.geomar.de/python/jupyter_on_HPC_setup_guide#wrapped-in-a-script) for learning how to connect to a Jupyter session that is running remotely.

To start up a Jupyterlab in a Container on Nesh, run
```shell
$ module load singularity/3.5.2
$ singularity pull --disable-cache --dir "${PWD}" docker://quay.io/willirath/parcels-container:2022.07.14-801fbe4
$ singularity run -B /sfs -B /gxfs_work1 -B $PWD:/work --pwd /work parcels-container_2022.07.14-801fbe4.sif bash -c ". /opt/conda/etc/profile.d/conda.sh && conda activate base && jupyter-lab --ip=0.0.0.0"
```
and wait for two URLs to appear. Copy the URL that does _not_ start with `localhost` or `127.0.0.1` and use it in [this step](https://git.geomar.de/python/jupyter_on_HPC_setup_guide#wrapped-in-a-script).

## Download data

Download high resolution data from Copernicus:
```shell
$ wget --user=username --password=******* -r -np -nH -l 4 --cut-dirs=2 "ftp://username@nrt.cmems-du.eu/Core/NORTHWESTSHELF_ANALYSIS_FORECAST_PHY_004_013/MetO-NWS-PHY-hi-CUR"
```
