#read in weather station file from the data folder
datW <- read.csv("/Users/brynnoconnor/Documents/ENVSTDATA/ao2/noaa2011124.csv")
#specify that the name column should be a factor
datW$NAME<- as.factor(datW$NAME)
#set up a vector of all names for each level
nameS <- levels(datW$NAME)
nameS[2]

#make a dataframe with just precipitation, year, and site name
#remove NA using na.omit
datP <- na.omit(data.frame(NAME=datW$NAME,
                           year=datW$year,
                           PRCP=datW$PRCP))
#total annual precipitation (mm)
precip <- aggregate(datW$PRCP, by=list(datW$NAME,datW$year), FUN="sum", na.rm=TRUE)
#use aggregate to get total annual precipitation
precip <- aggregate(datP$PRCP, by=list(datP$NAME,datP$year), FUN="sum", na.rm=TRUE)
#rename columns
colnames(precip) <- c("NAME","year","totalP")
#add the x column from aggregate looking at the length of observations in each year
precip$ncount <- aggregate(datP$PRCP, by=list(datP$NAME,datP$year), FUN="length")$x
