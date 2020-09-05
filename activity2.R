

#vector of characters
chars <- c(a, b, c, x, y, z)
chars

#vector of numerics
numerics <- c (2.0, 10.9, 100.33, .05, 99.99)
numerics

#vector of integers
ints <- c(9, -1, 1000, 34, 687)
ints

#vector of factors
factors <- c("tree", "ocean", "mountain", "lake", "flower")
factors <- as.factor(factors)
factors


help(hist)


datW <- read.csv("/Users/brynnoconnor/Documents/ENVSTDATA/ao2/noaa2011124.csv")
str(datW)
datW$NAME <- as.factor(datW$NAME)
datW$siteN <- as.numeric(datW$NAME)

#max temp
mean(datW$TMAX[datW$NAME == "ABERDEEN, WA US"], na.rm=TRUE)

#standard deviation
sd(datW$TMAX[datW$NAME == "ABERDEEN, WA US"], na.rm=TRUE)

#avg daily temp
datW$TAVE <- datW$TMIN + ((datW$TMAX-datW$TMIN)/2)

#mean across all sites
averageTemp <- aggregate(datW$TAVE, by=list(datW$NAME), FUN="mean",na.rm=TRUE)
averageTemp

#change col names
colnames(averageTemp) <- c("NAME","MAAT")
averageTemp

#convert level to factor number data type
datW$siteN <- as.numeric(datW$NAME)

hist(datW$TAVE[datW$siteN == 1],
     freq=FALSE, 
     main = paste(levels(datW$NAME)[4]),
     xlab = "Average daily temperature (degrees C)", 
     ylab="Relative frequency",
     col="grey75",
     border="white")




