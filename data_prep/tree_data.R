require(here)
require(rgdal)
require(xlsx)
require(data.table)

# require(sf)
# require(ggplot2)


# common variables
{
  in_dir = here("data", "original")
  out_dir = here("data", "formatted", "tree_data")
  proj_lon_lat = "+proj=longlat +datum=NAD83 +no_defs"
}



# convert tree XLSX to spatial data ----
if (FALSE)
{
  # https://r-spatial.github.io/sf/reference/st_read.html ----
  
  # read.xlsx is slow, so use read.xlsx2
  tree_dat = data.table(read.xlsx2(
    file.path(
      in_dir, 
      "Hurricane_damage_tree_risk_Tampa_CLCE_2.xlsx"), 
    sheetIndex = 1))
  
  # GPS coords ----
  
  # GPS Coords are strings within a single column in the spreadsheet
  # data.table parses the degree symbols correctly
  head(tree_dat$GPSCoords, 1)
  tail(tree_dat$GPSCoords, 4)
  
  # Need to unfactor the coordinates
  tree_dat[, coord_string := as.character(GPSCoords)]
  tree_dat[, head(coord_string)]
  tree_dat[, tail(coord_string)]
  
  # some entries are missing coordinates
  dat_trimmed = tree_dat[-tree_dat[, which(nchar(coord_string) == 0)], ]
  dim(dat_trimmed)
  dim(tree_dat)
  
  
  # Can split on the space after the 'N' and between the first number
  # this regex works:
  regex = "(?<=[A-Z]\\s)"
  
  
  # There may be an elegant way to do the following with 
  # a single line in data table.
  # For now, use intermediate vars.
  coords = data.table(t(dat_trimmed[, strsplit(coord_string, regex, perl = T)]))
  
  # add titles
  names(coords) = c("lat_dms", "lon_dms")
  
  # Degree symbol in unicode
  chd = "\u00B0"
  
  # DMS objects can coerce to decimal degrees with as.numeric()
  coords[, lon := as.numeric(char2dms(lon_dms, chd))]
  coords[, lat := as.numeric(char2dms(lat_dms, chd))]
  
  dat_trimmed[, long := coords$lon]
  dat_trimmed[, lat := coords$lat]
  
  names(dat_trimmed)
  dat_trimmed = dat_trimmed[, -c("coord_string", "GPSCoords")]
  
  coordinates(dat_trimmed) <- ~ long + lat
  proj4string(dat_trimmed) = proj_lon_lat
  
  writeOGR(
    dat_trimmed, 
    dsn = file.path(out_dir, "tree_data.GPKG"),
    layer = "Hurricane_damage_tree_risk_Tampa_CLCE_2",
    driver = "GPKG", 
    overwrite_layer = TRUE)
}
