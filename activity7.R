#package for vector data
library(sp)
#package for reading in spatial data
library(rgdal)
#data manangement package
library(dplyr)
#install.packages("rgeos")
library(raster)
library(rgeos)

geothermal <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Geothermal/Geothermal.shp")
caldera <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Caldera/calderas.shp")
volcanic <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Bedrock/Volcanic_point_features.shp")
faults <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Bedrock/Fault.shp")
glacier <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Surficial/Glacial_area_feat_boundaries.shp")
volcanic2 <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Surficial/Volcanic_point_feats.shp")
streams <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Hydrography/Streams.shp")
lakes <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Hydrography/Lakes.shp")

head(geothermal@data)
head(caldera@data)
head(volcanic@data)
head(faults@data)
head(glacier@data)
head(volcanic2@data)
head(streams@data)
head(lakes@data)

#look at just areas of different geothermal areas
geothermal_area <- data.frame( thermal_area = geothermal$THERM_AREA, 
                               geo_area = geothermal@data$LOCATION,
                                area = geothermal@data$AREA)

#average of all geothermal areas
mean(geothermal_area$area)

plot(caldera, col = "lightblue2", border="grey50")
plot(geothermal, col = "lightblue2", border="grey50")

plot(glacier, col="green", add=TRUE)
plot(streams, col="black")
plot(lakes, col="black")
plot(volcanic2, col="pink")
plot(geothermal, col="green", add=TRUE)
plot(volcanic, col="purple")
plot(caldera, col="tomato3", add=TRUE)
plot(faults, col="skyblue", add=TRUE)


#faults and caldera have relationship
#volcanic and faults?
#geothermal and volcanic
#volcanic points vs volcanic 
help(crop)

plot(volcanic2,
     main = "Shapefile imported into R - crop extent",
     axes = TRUE,
     border = "blue")

# crop the lidar raster using the vector extent
geothermal_crop <- crop(geothermal, volcanic2)
plot(geothermal_crop, main = "Cropped geothermal areas")

# add shapefile on top of the existing raster
plot(volcanic2, add = TRUE)


#how to convret spatial data to a dataframe
chisq.test(geothermal_area)
help("chisq.test")



plot(faults,
     main = "Shapefile imported into R - crop extent",
     axes = TRUE,
     border = "blue")

# crop the lidar raster using the vector extent
geothermal_crop_faults <- crop(geothermal, faults)
plot(geothermal_crop_faults, main = "Cropped geothermal areas")

# add shapefile on top of the existing raster
plot(faults, add = TRUE)







