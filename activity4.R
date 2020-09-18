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



