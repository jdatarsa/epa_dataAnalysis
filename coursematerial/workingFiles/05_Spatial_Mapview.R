library(mapview)
library(terra)
library(raster)

baseURL = "https://epicpd.jshiny.com/jdata/epicpd/botswanaVS/coursematerial"
source(paste0(baseURL,"/functions/01_functions.R"))
df <- importTabularOnlineExcel(filePlusExt = "nthiwa_kenya_seroprev.xlsx")
colnames(df)[10] <- "lat"
colnames(df)[11] <- "lon"
samplLoc = terra::vect(df,  crs="+proj=longlat +datum=WGS84")
temp = sf::st_as_sf(samplLoc)
masaiMara = importShapefilesOnline(filePlusExt = "masaiMara.zip")
masaiMarasf = sf::st_as_sf(masaiMara)
mapView(temp) + mapView(masaiMarasf)



