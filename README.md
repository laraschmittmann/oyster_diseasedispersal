# Oyster Disease Dispersal

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17061788.svg)](https://doi.org/10.5281/zenodo.17061788)

This repository contains the necessary notebooks and bash scripts to reproduce the Lagrangian dispersal simulations and connectivity analysis from the manuscript *Far from infection? Simulating disease dispersal risk for European flat oyster restoration*

Schmittmann L.<sup>1</sup>, Rath W.<sup>1</sup>, Bean T. P., Busch K., Gottschalk J., Mock, L.-C., Nascimento Schulze J. C., Sas H., and Biastoch A.

<sup>1</sup>contributed equally

## Structure of repository

### data/config

- ```Bonamia_diseaserecords.csv``` locations of diseased sites

- ```Ostreaedulis_aquaculture_EMODnet.csv``` locations of aquaculture sites

- ```hex_to_restoration_site.csv``` hex IDs mapped to restoration sites

- ```historical_sites.csv``` locations of historical sites

- ```restoration_sites_update.csv``` locations of restoration sites

### notebooks/manuscript

- ```currents.ipynb``` notebook to create Figure 3

- ```depths_regression.ipnb``` notebook to create Figure S3

- ```dispersalkernels.ipynb``` notebook to create Figure 4

**/05m/**

- ```010_lagrangian_experiment_05m.ipynb``` notebook to run particle dispersal simulations with Oceanparcels at 5 m depth

- ```010_lagrangian_experiment_05m.sh``` bash script to execute ```010_lagrangian_experiment_05m.ipynb```

- ```011_save_trajectories_to_zarr_05m.ipynb``` notebook to save particle trajectories to .zarr format

- ```020_connectivity_matrix_05m.ipynb``` notebook to construct connectivity matrix for 5 m

- ```030_aggregate_biodata_05m.ipynb``` notebook to aggregate biodata to connectivity matrix (locations of diseased, restoration, aquaculture, historic sites)

- ```035_aggregate_physical_gridded_data_05m.ipynb``` notebook to aggregate physical data to connectivity matrix (depth, water fraction)

- ```040_connectivity_analysis_file_preparation_05m.ipynb``` notebook to create subsets for 0-7, 7-14 and 7-28 days. These files are deposited in an open repository (link see below)

- ```040.1_connectivity_analysis_relative_concentrations_05m.ipynb``` notebook to create Figure 5 and S2

- ```040.1_connectivity_analysis_risk_relative_concentrations_05m.ipynb``` notebook to create Figure 9

- ```041_rest-sites_risk-analsysis_05m.ipynb``` notebook to create Figure 8

- ```042.1_risk-analsysis_highlyconnected_05m.ipynb``` notebook to create Figure 6 and 7

**/10m/**

- ```010_lagrangian_experiment_10m.ipynb``` notebook to run particle dispersal simulations with Oceanparcels at 10 m depth

- ```010_lagrangian_experiment_10m.sh``` bash script to execute ```010_lagrangian_experiment_10m.ipynb```

- ```011_save_trajectories_to_zarr_10m.ipynb``` notebook to save particle trajectories to .zarr format

- ```020_connectivity_matrix_10m.ipynb``` notebook to construct connectivity matrix for 10 m

- ```030_aggregate_biodata_10m.ipynb``` notebook to aggregate biodata to connectivity matrix (locations of diseased, restoration, aquaculture, historic sites)

- ```035_aggregate_physical_gridded_data_10m.ipynb``` notebook to aggregate physical data to connectivity matrix (depth, water fraction)

- ```040_connectivity_analysis_file_preparation_10m.ipynb``` notebook to create subsets for 0-7, 7-14 and 7-28 days. These files are deposited in an open repository (link see below)

- ```040.1_connectivity_analysis_relative_concentrations_10m.ipynb``` notebook to create Figure S1a

**/15m/**

- ```010_lagrangian_experiment_15m.ipynb``` notebook to run particle dispersal simulations with Oceanparcels at 15 m depth

- ```010_lagrangian_experiment_15m.sh``` bash script to execute ```010_lagrangian_experiment_15m.ipynb```

- ```011_save_trajectories_to_zarr_15m.ipynb``` notebook to save particle trajectories to .zarr format

- ```020_connectivity_matrix_15m.ipynb``` notebook to construct connectivity matrix for 15 m

- ```030_aggregate_biodata_15m.ipynb``` notebook to aggregate biodata to connectivity matrix (locations of diseased, restoration, aquaculture, historic sites)

- ```035_aggregate_physical_gridded_data_15m.ipynb``` notebook to aggregate physical data to connectivity matrix (depth, water fraction)

- ```040_connectivity_analysis_file_preparation_15m.ipynb``` notebook to create subsets for 0-7, 7-14 and 7-28 days. These files are deposited in an open repository (link see below)

- ```040.1_connectivity_analysis_relative_concentrations_15m.ipynb``` notebook to create Figure S1b


## Data deposition

Aggregated connectivity matrices are deposited here here: 

https://hdl.handle.net/20.500.12085//11cc2d8f-4039-49d3-aaab-04ce0fb23190
