#vector of tree heights in meters
heights <- c(30,41,20,22)
#convert to cm
heights_cm <- heights*100
heights_cm

#look at the first tree height
heights[1]

#look at the 2nd and 3rd tree heights
heights[2:3]

#get more info on the matrix function
help(matrix)

#set up a matrix with 2 columns and fill in by rows
#first argument is the vector of numbers to fill in the matrix
Mat<-matrix(c(1,2,3,4,5,6), ncol=2, byrow=TRUE)
Mat

#set up a matrix that fills in by columns
#first argument is the vector of numbers to fill in the matrix
Mat.bycol<-matrix(c(1,2,3,4,5,6), ncol=2, byrow=FALSE)
Mat.bycol

#subset the matrix to look at row 1, column2
Mat.bycol[1,2]

#look at all values in row 1
Mat.bycol[1,]

#look at all values in column 2
Mat.bycol[,2]

#question 2
#vector of characters
chars <- c(a, b, c, x, y, z)
chars

#question 2
#vector of numerics
numerics <- c (2.0, 10.9, 100.33, .05, 99.99)
numerics

#question 2
#vector of integers
ints <- c(9, -1, 1000, 34, 687)
ints

#question 2
#vector of factors
factors <- c("tree", "ocean", "mountain", "lake", "flower")
factors <- as.factor(factors)
factors

#histogram help - question 3
help(hist)

#read in weather station file from the data folder
datW <- read.csv("/Users/brynnoconnor/Documents/ENVSTDATA/ao2/noaa2011124.csv")

#get more info about the data frame
str(datW)

#assign #'s to sites to create factors
datW$NAME <- as.factor(datW$NAME)

#find out all unique site names
levels(datW$NAME)

#look at the mean maximum temperature for Aberdeen
mean(datW$TMAX[datW$NAME == "ABERDEEN, WA US"])

#look at the mean maximum temperature for Aberdeen
#with na.rm argument set to true to ingnore NA
mean(datW$TMAX[datW$NAME == "ABERDEEN, WA US"], na.rm=TRUE)

#standard deviation
sd(datW$TMAX[datW$NAME == "ABERDEEN, WA US"], na.rm=TRUE)

#calculate the average daily temperature
#This temperature will be halfway between the minimum and maximum temperature
datW$TAVE <- datW$TMIN + ((datW$TMAX-datW$TMIN)/2)

#get the mean across all sites
#the by function is a list of one or more variables to index over.
#FUN indicates the function we want to use
#if you want to specify any function specific arguments use a comma and add them after the function
#here we want to use the na.rm arguments specific to 
averageTemp <- aggregate(datW$TAVE, by=list(datW$NAME), FUN="mean",na.rm=TRUE)
averageTemp

#change the automatic output of column names to be more meaningful
#note that MAAT is a common abbreviation for Mean Annual Air Temperature
colnames(averageTemp) <- c("NAME","MAAT")
averageTemp

#convert level to number for factor data type
#you will have to reference the level output or look at the row of data to see the character designation.
datW$siteN <- as.numeric(datW$NAME)

#make a histogram for the first site in our levels
#main= is the title name argument.
#Here you want to paste the actual name of the factor not the numeric index
#since that will be more meaningful. 
hist(datW$TAVE[datW$siteN == 1],
     freq=FALSE, 
     main = paste(levels(datW$NAME)[1]),
     xlab = "Average daily temperature (degrees C)", 
     ylab="Relative frequency",
     col="grey75",
     border="white")



#question 4
#standard deviation for site
sd(datW$TMAX[datW$NAME == "MORMON FLAT, AZ US"], na.rm=TRUE)

#mean avg for site
mean(datW$TMAX[datW$NAME == "MORMON FLAT, AZ US"], na.rm=TRUE)

hist(datW$TAVE[datW$siteN == 4],
     freq=FALSE, 
     main = paste(levels(datW$NAME)[4]),
     xlab = "Average daily temperature (degrees C)", 
     ylab="Relative frequency",
     col="grey75",
     border="white")



help(dnorm)

#pnorm(value to evaluate at (note this will evaluate for all values and below),mean, standard deviation)
pnorm(0,
      mean(datW$TAVE[datW$siteN == 1],na.rm=TRUE),
      sd(datW$TAVE[datW$siteN == 1],na.rm=TRUE))

#pnrom with 5 gives me all probability (area of the curve) below 5 
pnorm(5,
      mean(datW$TAVE[datW$siteN == 1],na.rm=TRUE),
      sd(datW$TAVE[datW$siteN == 1],na.rm=TRUE))

#pnrom with 5 gives me all probability (area of the curve) below 5 
pnorm(5,
      mean(datW$TAVE[datW$siteN == 1],na.rm=TRUE),
      sd(datW$TAVE[datW$siteN == 1],na.rm=TRUE)) - pnorm(0,
        mean(datW$TAVE[datW$siteN == 1],na.rm=TRUE),
        sd(datW$TAVE[datW$siteN == 1],na.rm=TRUE))

#pnrom of 20 gives me all probability (area of the curve) below 20 
#subtracting from one leaves me with the area above 20
1 - pnorm(20,
          mean(datW$TAVE[datW$siteN == 1],na.rm=TRUE),
          sd(datW$TAVE[datW$siteN == 1],na.rm=TRUE))

#qnorm gives me the value at which all values and below equal the probability in my argument
#Here I'm calculating the value of the 95th quantile or a probability of 0.95
qnorm(0.95,
      mean(datW$TAVE[datW$siteN == 1],na.rm=TRUE),
      sd(datW$TAVE[datW$siteN == 1],na.rm=TRUE))


#question5
#finding high temp threshold using qnorm
hightemp_threshold <- qnorm(0.95,
      mean(datW$TAVE[datW$siteN == 1],na.rm=TRUE),
      sd(datW$TAVE[datW$siteN == 1],na.rm=TRUE))
hightemp_threshold

#probability of temps above high temp threshold with new mean
1 - pnorm(hightemp_threshold,
          mean(datW$TAVE[datW$siteN == 1] + 4,na.rm=TRUE),
          sd(datW$TAVE[datW$siteN == 1],na.rm=TRUE))



#question 7
#find total annual precip by site and year
totalPRCP <- aggregate(datW$PRCP, by=list(datW$NAME, datW$year), FUN="sum",na.rm=TRUE)
colnames(totalPRCP) <- c("NAME", "YEAR", "SITE")
totalPRCP

#question 6
#histogram of annual precip for Aberdeen site
# ERROR "'X' MUST BE NUMERIC"
hist(totalPRCP$PRCP[totalPRCP$NAME == 1],
     freq=FALSE, 
     main = paste(levels(datW$totalPRCP)[1]),
     xlab = "Average Precipitation (mm)", 
     ylab="Relative frequency",
     col="grey75",
     border="white")

