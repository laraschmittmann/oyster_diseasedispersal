import numpy as np
import xarray as xr
import pandas as pd
from shapely.geometry import Polygon, Point


def csv_to_polygons_lon_lat(file_name):
    """Load all release zones into a Pandas series of Polygons."""
    df = pd.read_csv(file_name)
    return (
        df
        .groupby("station")
        .apply(
            lambda _df: Polygon(list(zip(
                _df.sort_values("order")["lon"],
                _df.sort_values("order")["lat"]
            )))
        )
    )


def get_uniform_random_latlon_in(
    lat_start=-90, lat_end=90,
    lon_start=-180, lon_end=180,
    N=10,
):
    """Draw uniformly distributed random positions on the globe.
    
    Parameters
    ----------
    lat_start: float
        Start latitude. Defaults to: -90.0
    lat_end: float
        End latitude. Defaults to: 90.0
    lon_start: float
        Start longitude. Defaults to: -180.0
    lon_end: float
        End longitude. Defaults to: 180.0
    N: int
        Number of positions to be drawn. Defaults to: 10
    
    Returns
    -------
    pandas.DataFrame
        Contains columns "lat" and "lon".
    
    """
    lat = np.rad2deg(
        np.arcsin(
            np.random.uniform(
                np.sin(np.deg2rad(lat_start)),
                np.sin(np.deg2rad(lat_end)),
                size=(N, ),
            )
        )
    )
    lon = np.random.uniform(lon_start, lon_end, size=(N, ))
    return pd.DataFrame(
        {
            "lat": lat,
            "lon": lon,
        }
    )


def get_uniform_random_latlon_close_to_polygon(polygon_lon_lat, N=10):
    """Draw N random positions in the smalles lon-lat rectangle that contains the polygon."""
    lon_start, lat_start, lon_end, lat_end = polygon_lon_lat.bounds
    candidate_positions = get_uniform_random_latlon_in(
        lat_start=lat_start,
        lat_end=lat_end,
        lon_start=lon_start,
        lon_end=lon_end,
        N=N,
    )
    candidate_positions["is_in_poly"] = candidate_positions.apply(
        lambda row: polygon_lon_lat.contains(Point(row.loc["lon"], row.loc["lat"])),
        axis=1,
    )
    
    return candidate_positions
    

def get_uniform_random_latlon_within_polygon(polygon_lon_lat, N=10, max_iter=100):
    """Draw N random positions that are within the polygon."""
    candidate_positions = get_uniform_random_latlon_close_to_polygon(polygon_lon_lat, N=N)
    iteration_count = 0
    while (candidate_positions["is_in_poly"].sum() < N) and (iteration_count < max_iter):
        candidate_positions = pd.concat(
            [candidate_positions, get_uniform_random_latlon_close_to_polygon(polygon_lon_lat, N=N // 3)],
            ignore_index=True,
        )
        iteration_count += 1
    candidate_positions = candidate_positions.where(candidate_positions["is_in_poly"]).dropna().iloc[:N]
    candidate_positions = candidate_positions.set_index(pd.Series(range(N)))
    return candidate_positions