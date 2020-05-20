require(here)
require(sf)
require(ggplot2)


# common variables
{
  in_dir = here("data", "original")
  out_dir = here("data", "formatted", "borders")
}

save_gpkg_sf = function(source, dest_dir, dest_file)
{
  dat = read_sf(source)
  
  if (!dir.exists(dest_dir))
    dir.create(dest_dir)
  
  write_sf(dat, paste0(file.path(dest_dir, dest_file)))
  return(dat)
}


# ---- us_states_5m ----
{
  fn = "cb_2018_us_state_5m"
  fn2 = "us_states"
  out_fn  = paste0(fn2, ".GPKG")
  dat = save_gpkg_sf(
    source = file.path(in_dir, fn),
    dest_dir = out_dir,
    dest_file = out_fn)
  dat = read_sf(file.path(out_dir, out_fn))
  names(dat)
  ggplot(dat) + geom_sf()
  st_crs(dat)
}

# ---- florida_census_tracts ----
{
  
  fn = "tl_2017_12_tract"
  fn2 = "fl_census_tracts"
  out_fn  = paste0(fn2, ".GPKG")
  dat = save_gpkg_sf(
    source = file.path(in_dir, fn),
    dest_dir = out_dir,
    dest_file = out_fn)
  dat = read_sf(file.path(out_dir, out_fn))
  names(dat)
  ggplot(dat) + geom_sf()
  st_crs(dat)
}


# ---- florida_counties ----
{
  
  fn = "County_Florida-shp"
  fn2 = "fl_counties"
  out_fn  = paste0(fn2, ".GPKG")
  dat = save_gpkg_sf(
    source = file.path(in_dir, fn),
    dest_dir = out_dir,
    dest_file = out_fn)
  dat = read_sf(file.path(out_dir, out_fn))
  names(dat)
  ggplot(dat) + geom_sf()
  st_crs(dat)
}


# ---- Tampa_zoning_districts ----
{
  fn = "Tampa_Zoning_District"
  fn2 = "Tampa_zoning_districts"
  out_fn  = paste0(fn2, ".GPKG")
  dat = save_gpkg_sf(
    source = file.path(in_dir, fn),
    dest_dir = out_dir,
    dest_file = out_fn)
  dat = read_sf(file.path(out_dir, out_fn))
  names(dat)
  ggplot(dat) + geom_sf()
}


# ---- Tampa_neighborhoods ----
{
  fn = "Tampa_neighborhoods"
  out_fn  = paste0(fn, ".GPKG")
  dat = save_gpkg_sf(
    source = file.path(in_dir, fn),
    dest_dir = out_dir,
    dest_file = paste0(fn, ".GPKG"))
  dat = read_sf(file.path(out_dir, out_fn))
  names(dat)
  ggplot(dat) + geom_sf()
}



