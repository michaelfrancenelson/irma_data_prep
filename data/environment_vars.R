require(here)
dat_path = here("data")
dat_path_tiger = here("data", "TIGER")
dat_path_spatial = here("data", "hurricane")

dat_paths = 
  list(
    dat_path = dat_path,
    dat_path_spatial = dat_path_spatial,
    dat_path_tiger = dat_path_spatial,
    trees = paste0(dat_path_spatial, "/Hurricane_damage_tree_risk_Tampa_CLCE_2"),
    wind = paste0(dat_path_spatial, "/AppliedResearchAssociates_WindFieldData-selected"),
    tampa_gis = paste0(dat_path_spatial, "/TampaGIS-selected"),
    file_trees = paste0(dat_path_spatial, "/Hurricane_damage_tree_risk_Tampa_CLCE_2.xlsx"),
    tracts_tampa = paste0(dat_path_tiger, "/FL/tl_2017_12_tract"),
    counties_fl = here("data", "tl_2016_12_cousub")
  )


projections = list(
  
  # The tree data in the Excel sheet seems to be in lon/lat
  lon_lat = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs",
  
  # An Albers equal area for Florida looks much nicer
  aea = "+proj=aea +lat_1=24 +lat_2=31.5 +lat_0=24 +lon_0=-84 +x_0=400000 +y_0=0 +ellps=GRS80 +units=m +no_defs"
)

# Create a rectangular bounding that covers a buffered area of the input simple feature.
sf_buffered_bbox = function(sf_1, buf_width)
{
  mat = as.matrix(extent(sf_1))
  b_mat = mat + buf_width * c(-1, -1, 1, 1)
  
  out = st_as_sfc(st_bbox(extent(b_mat)), crs = st_crs(sf_1))
  st_crs(out) = st_crs(sf_1)
  
  return(out)  
}





rm(dat_path, dat_path_spatial, dat_path_tiger)