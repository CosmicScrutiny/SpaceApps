
####

## Some libraries used 

library(jsonlite)
library(gdalUtils)
library(imager)
library(nasadata)
library(raster)
library(rgdal)
library(ncdf4)
library(sf)


#Custom colors used in some plots: 

mycols <- 1:7
mycols[7] <- "#FF0000"
mycols[6] <- "#FF6600"
mycols[5] <- "#FFFF00"
mycols[4] <- "#00CC00"
mycols[3] <- "#009999"
mycols[2] <- "#0099FF"
mycols[1] <- "#0000FF"

#Shapefiles for different regions
worldmap <- shapefile("World_Countries.shp")
europemap <- shapefile("europemap.shp")
hubeimap <- shapefile("hubeimap.shp")
chinaindustrialmap <- shapefile("chinamap.shp")

#For JSON, example: 

hubeijsonmap <- readOGR("hubeimap.json")


tiff_files <- list.files(pattern = "*.tif") #Lists all files within directory
raster_datasets <- raster::stack(paste0(tiff_files)) #Creates a stack of
#raster layers from the list of rasters in the directory 


NAvalue(raster_datasets) #Check NA value of raster to see if it has been
#applied. If not, use documentation to assign a value. 

#For example, our ozone dataset is: 

NAvalue(ozone_datasets) <- 99999 

#Cropping datasets based on shapefile: 

cropped_dataset <- crop(raster_datasets,shapefile)

#For maps with outlines required, we used a mask. 

masked_dataset <- mask(raster_datasets, shapefile)

#For normalization: 

mean_raster_datasets <- mean(raster_datasets)
sdev_raster_datasets <- calc(raster_datasets,sd)
normalized_dataset <- (raster_datasets - mean_raster_datasets)/sdev_raster_datasets

#For plotting this, subset one layer from the list of rasters that
#corresponds to the specific month that we want to visualized.

#Example for Ozone map: 

plot(subset(europe_ozone,1), main = "Ozone Map Western Europe January 2019", xlab = "longitude", ylab = "latitude",col = mycols,breaks = c(500,450,400,350,300,250,200))








