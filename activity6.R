install.packages(c("sp","rgdal","dplyr"))
install.packages(c("rgdal"))
#package for vector data
library(sp)
#package for reading in spatial data
library(rgdal)
#data manangement package
library(dplyr)

#read in shapefiles
#readOGR in rgdal does this
#glaciers in 1966
g1966 <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao6/GNPglaciers/GNPglaciers_1966.shp")

#glaciers in 2015
g2015 <- readOGR("/Users/brynnoconnor/Documents/ENVSTDATA/ao6/GNPglaciers/GNPglaciers_2015.shp")

str(g2015)

#map the glaciers filling in the polygons with light blue and making the borders grey
plot(g1966, col = "lightblue2", border="grey50")

#data stores all accompanying info/measurements for each spatial object
head(g2015@data)

g1966@proj4string

#check glacier name
g1966@data$GLACNAME
g2015@data$GLACNAME

#fix glacier name so that it is consistent with the entire time period
g2015@data$GLACNAME <- ifelse(g2015@data$GLACNAME == "North Swiftcurrent Glacier",
                              "N. Swiftcurrent Glacier",
                              ifelse(   g2015@data$GLACNAME ==  "Miche Wabun", 
                                        "Miche Wabun Glacier",
                                        as.character(g2015@data$GLACNAME)))

g1966@data$Area1966
g2015@data$Area2015

plot(g1966, col="skyblue")
plot(g2015, col="tomato3", add=TRUE)

#example datasets with numbers
exp1 <- data.frame(NAME = as.factor(c("a", "b", "c")),
                   per.change = c(50,40,65))

exp2 <- dta.frame(NAME = as.factor(c("a", "b", "c", "d")), 
                  mass.gt = c(70,8,10,30))

glac <- full_join(exp1, exp2, by="NAME")

#question 5
#lets combine area, first work with a smaller data frame
gdf66 <- data.frame(GLACNAME = g1966@data$GLACNAME,
                    area66 = g1966@data$Area1966)

gdf15 <- data.frame(GLACNAME = g2015@data$GLACNAME,
                    area15 = g2015@data$Area2015)

#join all data tables by glacier name
gAll <- full_join(gdf66,gdf15, by="GLACNAME")



