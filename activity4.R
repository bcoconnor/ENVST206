datB <- read.csv("/Users/brynnoconnor/Documents/ENVSTDATA/ao4/beaver_dam.csv")
head(datB)
View(datB)

plot(datB$dams.n, datB$area.h, 
     pch = 19, 
     col = "royalblue4",
     ylab = "Surface water area (ha)",
     xlab =  "Number of beaver dams")

#set up regression
dam.mod <- lm(datB$area.ha ~ datB$dams.n)

#get standarized residuals
dam.res <- rstandard(dam.mod)

#set up qq plot
qqnorm(dam.res)
#add qq line
qqline(dam.res)

#double check results of normality
shapiro.test(dam.res)

#make residual plot
plot(datB$dams.n, dam.res, 
     xlab = "beaver damns", 
     ylab = "standardized residual")
#add a horizontal line at zero
abline(h=0)

#print out results
summary(dam.mod)

#question 2
#make plot of beaver dams and surface water
plot(datB$dams.n, datB$area.h, 
     pch = 19, 
     col = "royalblue4",
     ylab = "Surface water area (ha)",
     xlab =  "Number of beaver dams")
#add regression line
#make line width thicker
abline(dam.mod, lwd=2)

#read in red maple pheno dataset
pheno <- read.csv("/Users/brynnoconnor/Documents/ENVSTDATA/ao4/red_maple_pheno.csv")
View(pheno)

#set up panel of plots with one row and two columns
par(mfrow=c(1,2))
#doy relation to max temp plot
plot(pheno$Tmax,pheno$doy, 
     pch = 19, 
     col = "royalblue4",
     ylab = "Day of leaf out",
     xlab =  "Maximum temperature (C)")
#doy relation to precipitation plot
plot(pheno$Prcp,pheno$doy, 
     pch = 19, 
     col = "royalblue4",
     ylab = "Day of leaf out",
     xlab =  "Precipitation (mm)")


#question 3
#set up panel of plots with 2 rows and 2 columns
par(mfrow=c(1,2))
#doy to latitude plot
plot(pheno$Lat,pheno$doy, 
     pch = 19, 
     col = "royalblue4",
     ylab = "Day of leaf out",
     xlab =  "Latitude")
#doy to elevation plot
plot(pheno$elev,pheno$doy, 
     pch = 19, 
     col = "royalblue4",
     ylab = "Day of leaf out",
     xlab =  "Elevation (m)")
#doy to max temperature plot
plot(pheno$Tmax,pheno$doy, 
     pch = 19, 
     col = "royalblue4",
     ylab = "Day of leaf out",
     xlab =  "Maximum temperature (C)")
#doy to site description box plot
boxplot(pheno$doy ~ pheno$siteDesc, xlab ="Site Description (Rural/Urban)", 
     ylab="Day of leaf out")

#clear plot panel
dev.off()

#question 4
#check for multi-collinearity
plot( ~  pheno$Lat + pheno$Tmax+ pheno$Tmin +pheno$Prcp + pheno$elev + pheno$siteDesc)

#question 5
#build and run multiple regression
pheno$urID <- ifelse(pheno$siteDesc == "Urban",1,0)

#question 6
#set up multiple regression
mlr <- lm(pheno$doy ~  pheno$Tmax  + pheno$Prcp + pheno$elev + pheno$urID)
#calculate fitted values from regression line for each observation
mlFitted <- fitted(mlr)
#set up qq plot to check assumptions
qqnorm(mlFitted)
#add qq line to check assumptions
qqline(mlFitted)
#make residual plot to check assumptions
plot(pheno$doy, pheno$urID, 
     xlab = "day of leaf out", 
     ylab = "standardized residual")
#add a horizontal line at zero
abline(h=0)

#question 7/8
summary(mlr)



