#activity 2

heights <- c(3,2,3)


#name data frame
datW <- read.csv("/Users/brynnoconnor/Documents/ENVSTDATA/activity2/noaa2011124.csv")

datW$PRCP_cm <- datW$PRCP/10

mean(datW$PRCP_cm, na.rm=TRUE)
