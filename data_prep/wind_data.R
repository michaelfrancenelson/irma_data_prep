require(here)
require(sf)


# common variables
{
  in_dir = here("data", "original")
  out_dir = here("data", "formatted", "wind_data")
  # proj_lon_lat = "+proj=longlat +datum=NAD83 +no_defs"
}

if (FALSE)
{
  wind_dat = read_sf(file.path(
    in_dir,
    "AppliedResearchAssociates_WindFieldData-selected", 
    "ARA_IrmaWindspeed.shp"))
  print(st_crs(wind_dat))
  write_sf(wind_dat, file.path(out_dir, "wind_data.GPKG"))
}
