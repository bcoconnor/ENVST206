library(ggplot2)

#read in weather station file from the data folder
datW <- read.csv("/Users/brynnoconnor/Documents/ENVSTDATA/ao2/noaa2011124.csv")
#specify that the name column should be a factor
datW$NAME<- as.factor(datW$NAME)
#set up a vector of all names for each level
nameS <- levels(datW$NAME)
nameS

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

#make a new dataframe, remove years with too many missing precip data
pr <- precip[precip$ncount >=364, ]

#install.packages("ggplot2") INSATLLED ALREADY

#base r plot
plot(pr$year, pr$totalP)

ggplot(data = pr, aes(x = year, y=totalP, color=NAME ) )+ #data for plot
  geom_point()+ #make points at data point
  geom_path()+ #use lines to connect data points
  labs(x="year", y="Annual Precipitation") #make axis labels

#look at only livermore california and morrisville new york preciptiation
ca <- pr[pr$NAME == nameS[2], ]
ny <- pr[pr$NAME == nameS[5], ]

#make a plot of california precip
plot(ca$year, ca$totalP)

#make a plot of california precip
plot(ca$year, ca$totalP,
     type = "b",
     pch = 19,
     ylab = "Annual precipitation (mm)",
     xlab = "Year")

#make a plot of california precip
plot(ca$year, ca$totalP,
     type = "b",
     pch = 19,
     ylab = "Annual precipitation (mm)",
     xlab = "Year", 
     yaxt = "n")

#add y axis
#arguments are axis number (1 bottom, 2 left, 3 top, 4 right)
#las = 2 changes the labels to be read in horizontal direction
axis(2, seq(200,800, by=200), las=2 )

#adding New York for reference
plot(ca$year, ca$totalP,
     type = "b",
     pch = 19,
     ylab = "Annual precipitation (mm)",
     xlab = "Year", 
     yaxt = "n")
#add y axis
axis(2, seq(200,800, by=200), las=2 )
#add arizona
points(ny$year, ny$totalP,
       type = "b",
       pch = 19,
       col="tomato3")

#changing axes range to include all data points
plot(ca$year, ca$totalP,
     type = "b",
     pch = 19,
     ylab = "Annual precipitation (mm)",
     xlab = "Year", 
     yaxt = "n",
     ylim =c(0, 1600))
#add y axis
axis(2, seq(0,1600, by=400), las=2 )
#add new york
points(ny$year, ny$totalP,
       type = "b",
       pch = 19,
       col="tomato3")

#full plot ca and ny
plot(ca$year, ca$totalP,
     type = "b",
     pch = 19,
     ylab = "Annual precipitation (mm)",
     xlab = "Year", 
     yaxt = "n",
     ylim =c(0, 1600))
#add y axis
axis(2, seq(0,1600, by=400), las=2 )
#add arizona
points(ny$year, ny$totalP,
       type = "b",
       pch = 19,
       col="tomato3")

#add legend
legend("topleft", #position
       c("California", "New York"), #labels
       col= c("black", "tomato3"), #colors
       pch=19, #point shape
       lwd=1, #line thickness 1, anytime both point & line arguments are given both will be drawn
       bty="n") #always use this argument otherwise an ugly box is drawn


#question 3 - plot ny and nd
#make a dataframe with just temperature, year, and site name
#remove NA using na.omit
datT <- na.omit(data.frame(NAME=datW$NAME,
                           year=datW$year,
                           TMAX=datW$TMAX))

#total mean temperature
TMAX <- aggregate(datW$TMAX, by=list(datW$NAME,datW$year), FUN="mean", na.rm=TRUE)
#use aggregate to get mean temperatures
TMAX <- aggregate(datT$TMAX, by=list(datT$NAME,datT$year), FUN="mean", na.rm=TRUE)
#rename columns
colnames(TMAX) <- c("NAME","year","TMAX")
#add the x column from aggregate looking at the length of observations in each year
TMAX$ncount <- aggregate(datT$TMAX, by=list(datT$NAME,datT$year), FUN="length")$x

#make a new dataframe, remove years with too many missing temp data
temp <- TMAX[TMAX$ncount >=364, ]

ggplot(data = TMAX, aes(x = year, y=TMAX, color=NAME ) )+ #data for plot
  geom_point()+ #make points at data point
  geom_path()+ #use lines to connect data points
  labs(x="year", y="Max Temp") #make axis labels

nd <- temp[temp$NAME == nameS[3], ]
ny <- temp[temp$NAME == nameS[5], ]

#add north dakota
plot(nd$year, nd$TMAX,
     type = "b",
     pch = 19,
     main = "Annual Mean Maximum Temperature vs. Year",
     ylab = "Annual Mean Maximum Temperature (C)",
     xlab = "Year", 
     yaxt = "n",
     ylim =c(7, 17))
#add y axis
axis(2, seq(7,17, by=1), las=2 )
#add new york
points(ny$year, ny$TMAX,
       type = "b",
       pch = 19,
       col="tomato3")
#add legend
legend("topleft", #position
       c("North Dakota", "New York"), #labels
       col= c("black", "tomato3"), #colors
       pch=19, #point shape
       lwd=1, #line thickness 1, anytime both point & line arguments are given both will be drawn
       bty="n") #always use this argument otherwise an ugly box is drawn

#ggplot2 plotting
ggplot(data = pr, aes(x = year, y=totalP, color=NAME ) )+ #data for plot
  geom_point()+ #make points at data point
  geom_path()+ #use lines to connect data points
  labs(x="year", y="Annual Precipitation") #make axis labels

#get rid of grey gridlines
ggplot(data = pr, aes(x = year, y=totalP, color=NAME ) )+ #data for plot
  geom_point()+ #make points at data point
  geom_path()+ #use lines to connect data points
  labs(x="year", y="Annual Precipitation")+ #make axis labels
  theme_classic() #change plot theme

#make semi-transparent points
ggplot(data = pr, aes(x = year, y=totalP, color=NAME ) )+
  geom_point(alpha=0.5)+
  geom_path(alpha=0.5)+
  labs(x="year", y="Annual Precipitation")+
  theme_classic()+
  scale_color_manual(values = c("#7FB3D5","#34495E", "#E7B800", "#FC4E07","#26A69A"))

#question 5
#change color of points
ggplot(data = pr, aes(x = year, y=totalP, color=NAME ) )+
  geom_point(alpha=0.5)+
  geom_path(alpha=0.5)+
  labs(x="year", y="Annual Precipitation")+
  theme_classic()+
  scale_color_manual(values = c("#FF33CC","#FF9900", "#6633FF", "#66CC33","#3498DB"))

library(ggplot2)
#ggplot violin plot 
ggplot(data = datW, aes(x=NAME, y=TMIN))+ #look at daily tmin
  geom_violin(fill=rgb(0.933,0.953,0.98))+ #add a violin plot with blue color
  geom_boxplot(width=0.2,size=0.25, fill="grey90")+ #add grey boxplots and make them about 20% smaller than normal with 25% thinner lines than normal
  theme_classic() #git rid of ugly gridlines

sub <- datW[datW$NAME == nameS[4] & datW$ year == 1974,]

#specify date format
#%Y means a four number year 
#- indicates that the date uses dashes to seperate
#%m means month
#%d means day
sub$DATE <- as.Date(sub$DATE,"%Y-%m-%d")

#question 7
ggplot(data=sub, aes(x=DATE, y=TMAX))+
  geom_point()+
  geom_path()+
  theme_classic()+
  labs(x="year", y="Maximimum temperature (C)")
#bar plot
ggplot(data=sub, aes(x=DATE, y=PRCP))+
  geom_col(fill="royalblue3")+
  theme_classic()+
  labs(x="year", y="Daily precipitation (mm)")

#question 8
#california data
sub2 <- datW[datW$NAME == nameS[2] & datW$year == 1974,]
sub2$DATE <- as.Date(sub2$DATE,"%Y-%m-%d")

#temperature plot
ggplot(data=sub2, aes(x=DATE, y=TMAX))+
  geom_point()+
  geom_path()+
  theme_classic()+
  labs(x="year", y="Maximimum temperature (C)")
#bar plot
ggplot(data=sub2, aes(x=DATE, y=PRCP))+
  geom_col(fill="royalblue3")+
  theme_classic()+
  labs(x="year", y="Daily precipitation (mm)")


#question 9
#daily min temperatures over last 20 years (2000-2020)
datTMIN <- na.omit(data.frame(NAME=datW$NAME,
                           year=datW$year,
                           TMIN=datW$TMIN))

subTMIN <- datTMIN[datTMIN$NAME == nameS[2] & datTMIN$year >= 2000,]
subTMIN$year<- as.factor(subTMIN$year)
subTMIN$DATE <- as.Date(subTMIN$DATE,"%Y-%m-%d")

ggplot(data = subTMIN, aes(x=year, y=TMIN))+ #look at daily tmin
  geom_violin(fill=rgb(0.933,0.953,0.98))+ #add a violin plot with blue color
  geom_boxplot(width=0.2,size=0.25, fill="grey90")+ #add grey boxplots and make them about 20% smaller than normal with 25% thinner lines than normal
  theme_classic() #git rid of ugly gridlines
