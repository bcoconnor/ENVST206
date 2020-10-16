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

#question 7
#calculate the % change in area from 1966 to 2015
gAll$gdiff <- ((gAll$area66-gAll$area15)/gAll$area66)*100

plot(gAll$area66, gAll$gdiff, 
     pch = 19, 
     col = "royalblue4",
     ylab = "Percent Change in Area",
     xlab =  "Glacier Area in 1966 (km)",
     main = "Percent Change in Area vs. Glacier Area in 1966")


#join data with the spatial data table and overwrite into spatial data table 
g1966@data <- left_join(g1966@data, gAll, by="GLACNAME")
#use spplot to shade polygons based on the % change of labels
#first argument is the spatial object
#second is the column in of data to display with the different colors
#add a title using main
#col changes the color of the borders. This argument sets them to transparent
spplot(g1966, "gdiff", main="% change in area", col="transparent")

#look at the Vulture glacier in 1966
vulture66 <- g1966[g1966@data$GLACNAME == "Vulture Glacier",]
plot(vulture66, main = "Vulture Glacier in 1966", col="slategray")

#question 8
#mean and standard deviation
mean(gAll$gdiff)
sd(gAll$gdiff)

#question 9
#largest % loss
boulder66 <- g1966[g1966@data$GLACNAME == "Boulder Glacier",]
boulder15 <- g2015[g2015@data$GLACNAME == "Boulder Glacier",]
plot(boulder66, main = "Boulder Glacier Area 1966 and 2015", col="slategray")
plot(boulder15, add=TRUE, col="orange")
legend("bottomleft", c("Boulder Glacier 1966", "Boulder Glacier 2015"), fill=c("slategray", "orange"), bty="n")

#smallest % loss
pumpelly66 <- g1966[g1966@data$GLACNAME == "Pumpelly Glacier",]
pumpelly15 <- g2015[g2015@data$GLACNAME == "Pumpelly Glacier",]
plot(pumpelly66, main = "Pumpelly Glacier Area 1966 and 2015", col="slategray")
plot(pumpelly15, add=TRUE, col="orange")
legend("bottomright", c("Pumpelly Glacier 1966", "Pumpelly Glacier 2015"), fill=c("slategray", "orange"), bty="n")


