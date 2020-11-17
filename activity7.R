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
folds <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Bedrock/Folds.shp")
flood_channel <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Surficial/Escarpments_and_flood_channels.shp")
dikes <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Bedrock/Linear_dikes.shp")
geo_features <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Bedrock/Geologic_line_features.shp")

head(geothermal@data)
head(caldera@data)
head(volcanic@data)
head(faults@data)
head(glacier@data)
head(streams@data)
head(folds$data)
head(flood_channel$data)

#look at just areas of different geothermal areas
geothermal_area <- data.frame( thermal_area = geothermal$THERM_AREA,
                               geo_area = geothermal@data$LOCATION,
                               area = geothermal@data$AREA)

#average of all geothermal areas
mean(geothermal_area$area)

plot(geothermal, col = "lightblue2", border="grey50")
plot(dikes, col = "lightblue2", border="grey50")

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
geo_results <- data.frame(Feature=NA, Inside=NA, Total=NA)

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

folds_crop <- crop(geothermal, folds)
folds_result <- c("Folds", NROW(folds_crop), NROW(folds))
geo_results <- rbind(geo_results, folds_result)

flood_channel_crop <- crop(geothermal, flood_channel)
flood_channel_result <- c("Flood Channel", NROW(flood_channel_crop), NROW(flood_channel))
geo_results <- rbind(geo_results, flood_channel_result)

dikes_crop <- crop(geothermal, dikes)
dikes_result <- c("Linear Dikes", NROW(dikes_crop), NROW(dikes))
geo_results <- rbind(geo_results, dikes_result)

geo_features_crop <- crop(geothermal, geo_features)
geo_features_result <- c("Geologic Features", NROW(geo_features_crop), NROW(geo_features))
geo_results <- rbind(geo_results, geo_features_result)

#remove empty row at top
geo_results <- na.omit(geo_results)


#chi-sq test on dataframe of results
chisq.test(x=geo_results$Inside, y=geo_results$Total)



plot(faults,
     main = "Shapefile imported into R - faults",
     axes = TRUE,
     border = "blue")

# crop the lidar raster using the vector extent
geothermal_crop_faults <- crop(geothermal, faults)
plot(geothermal_crop_faults, main = "Cropped geothermal areas")

plot(geothermal_crop, main = "Cropped geothermal areas")

# add shapefile on top of the existing raster
plot(volcanic2, add = TRUE)


# add shapefile on top of the existing raster
plot(faults, add = TRUE)




