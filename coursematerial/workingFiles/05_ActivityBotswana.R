#data
df <- read.csv("https://epicpd.jshiny.com/jdata/epicpd/botswanaVS/coursematerial/tabular/wahid_botswana_outbreaklevel.csv")
#packages
require(dplyr); require(terra)
#Extract FMD
View(df)
df = subset(df, subset = diseases == "Foot and mouth disease virus (Inf. with) ")
df$diseases = factor(df$diseases)
levels(df$diseases) <-  "FMD"
#rename the lat and lon columns as required by terra
str(df)
colnames(df)[12] <- "lat"
colnames(df)[13] <- "lon"
df = terra::vect(df,  crs="+proj=longlat +datum=WGS84")
plot(df)
#check the Botswana shapefile
baseURL = "https://epicpd.jshiny.com/jdata/epicpd/botswanaVS/coursematerial"
source(paste0(baseURL,"/functions/01_functions.R"))
botswana = importShapefilesOnline(filePlusExt = "botswanaFMDControl.zip")

#Get Botswana Cattle
cattleDensAfrica = terra::rast(paste0(baseURL,"/gis/rasters/densCattleAfrica.tif"))
cattleDensBotswana = crop(cattleDensAfrica, ext(botswana))

folderExport = "C:/Users/User/Desktop/plotqGIS"
writeVector(df, filename = paste0(folderExport, "/botswanaFMD.shp"), overwrite=TRUE)
writeVector(botswana, filename = paste0(folderExport, "/botswanaFMDcontrol.shp"), overwrite=TRUE)
writeRaster(cattleDensBotswana, filename = paste0(folderExport, "/cattleDensBotswana.tif"), overwrite=TRUE)

