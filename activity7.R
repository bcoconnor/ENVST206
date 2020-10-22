#package for vector data
library(sp)
#package for reading in spatial data
library(rgdal)
#data manangement package
library(dplyr)

geothermal <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Geothermal/Geothermal.shp")
caldera <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Caldera/calderas.shp")
volcanic <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Bedrock/Volcanic_point_features.shp")
faults <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Bedrock/Fault.shp")
glacier <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Surficial/Glacial_area_feat_boundaries.shp")
volcanic2 <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao7/Surficial/Volcanic_point_feats.shp")

head(geothermal@data)
head(caldera@data)
head(volcanic@data)
head(faults@data)
head(glacier@data)
head(volcanic2@data)

plot(caldera, col = "lightblue2", border="grey50")
plot(geothermal, col = "lightblue2", border="grey50")

plot(glacier, col="black")
plot(volcanic22, col="pink")
plot(geothermal, col="green", add=TRUE)
plot(volcanic, col="purple", add=TRUE)
plot(caldera, col="tomato3", add=TRUE)
plot(faults, col="skyblue", add=TRUE)

#faults and caldera have relationship
#volcanic and faults?
#geothermal and volcanic
#volcanic points vs volcanic 


