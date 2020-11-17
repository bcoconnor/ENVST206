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
streams <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Hydrography/Streams.shp")

head(geothermal@data)
head(caldera@data)
head(volcanic@data)
head(faults@data)
head(glacier@data)
head(streams@data)

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
plot(geothermal, col="green", add=TRUE)
plot(volcanic, col="purple")
plot(caldera, col="tomato3", add=TRUE)
plot(faults, col="skyblue", add=TRUE)


plot(volcanic2,
     main = "Shapefile imported into R - crop extent",
     axes = TRUE,
     border = "blue")

#create new dataframe
geo_results <- data.frame("Feature"=NA, "Inside"=NA, "Outside"=NA)
#remove empty row at top
geo_results <- na.omit(geo_results)

# crop volcanic2 raster using the vector extent
caldera_crop <- crop(geothermal, caldera)
caldera_result <- c("Caldera", NROW(caldera_crop), NROW(caldera))
geo_results <- rbind(geo_results, caldera_result)

volcanic_crop <- crop(geothermal, volcanic)
volcanic_result <- c("Volcanic Points", NROW(volcanic_crop), NROW(volcanic))
geo_results <- rbind(geo_results, volcanic_result)

faults_crop <- crop(geothermal, faults)
faults_result <- c("Faults", NROW(faults_crop), NROW(faults))
geo_results <- rbind(geo_results, faults_result)

glacier_crop <- crop(geothermal, glacier)
glacier_result <- c("Glacier", NROW(glacier_crop), NROW(glacier))
geo_results <- rbind(geo_results, glacier_result)

streams_crop <- crop(geothermal, streams)
streams_result <- c("Streams", NROW(streams_crop), NROW(streams))
geo_results <- rbind(geo_results, streams_result)





plot(geothermal_crop, main = "Cropped geothermal areas")

# add shapefile on top of the existing raster
plot(volcanic2, add = TRUE)


#how to convret spatial data to a dataframe
chisq.test(geo_results$inside, geo_results$outside)
help("chisq.test")


plot(faults,
     main = "Shapefile imported into R - faults",
     axes = TRUE,
     border = "blue")

# crop the lidar raster using the vector extent
geothermal_crop_faults <- crop(geothermal, faults)
plot(geothermal_crop_faults, main = "Cropped geothermal areas")

# add shapefile on top of the existing raster
plot(faults, add = TRUE)
