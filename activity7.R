#install.packages(c("sp","rgdal","dplyr"))
#install.packages(c("rgdal"))
#package for vector data
library(sp)
#package for reading in spatial data
library(rgdal)
#data manangement package
library(dplyr)

#read in shapefiles
#readOGR in rgdal does this
#glaciers in 1966
geothermal <- readOGR("/Users/brynnoconnor/Downloads/Geothermal/Geothermal.shp")


plot(geothermal, col = "lightblue2", border="grey50")

head(geothermal@data)
