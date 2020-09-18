ch4 <- read.csv("/Users/brynnoconnor/Documents/ENVSTDATA/ao3/lemming_herbivory.csv")

#treat herbivory column as factor
ch4$herbivory <- as.factor(ch4$herbivory)

#boxplot
plot(ch4$CH4_Flux ~ ch4$herbivory, xlab ="Treatment", 
     ylab="CH4 fluxes (mgC m –2 day–1) ")

#use the shapiro wilks test to look for normality in each treatment
#shapiro-wilk test on grazing plots
shapiro.test(ch4$CH4_Flux[ch4$herbivory == "Ctl"])

#shapiro-wilk test on grazing exclusion plots
shapiro.test(ch4$CH4_Flux[ch4$herbivory == "Ex"])

#use bartlett test since testing for equal variance
bartlett.test(ch4$CH4_Flux ~ ch4$herbivory)

#2 sample t-test
t.test(ch4$CH4_Flux ~ ch4$herbivory)

#read in insect data
datI <- read.csv("/Users/brynnoconnor/Documents/ENVSTDATA/ao3/insect_richness.csv")
datI

#column names to factor
datI$urbanName <- as.factor(datI$urbanName)


#question 4
#shapiro-wilk test on suburban
shapiro.test(datI$Richness[datI$urbanName == "Suburban"])

#shapiro-wilk test on developed
shapiro.test(datI$Richness[datI$urbanName == "Developed"])

#shapiro-wilk test on dense
shapiro.test(datI$Richness[datI$urbanName == "Dense"])

#shapiro-wilk test on natural
shapiro.test(datI$Richness[datI$urbanName == "Natural"])

#use bartlett test since testing for equal variance
bartlett.test(datI$Richness ~ datI$urbanName)


#specify model for species richness and urban type
in.mod <- lm(datI$Richness ~ datI$urbanName)
#run the ANOVA
in.aov <- aov(in.mod)
#print out ANOVA table
summary(in.aov)

#run Tukey HSD
tukeyT <- TukeyHSD(in.aov)
#view results
tukeyT

#make a plot
#make axes labels smaller than usual to fit on plot using cex.axis 
plot(tukeyT, cex.axis=0.75)

#calculating means across factor data simultaneously in R
tapply(datI$Richness, datI$urbanName, "mean")

#set up contingency table
species <- matrix(c(18,8,15,32), ncol=2, byrow = TRUE) 
colnames(species) <- c("Not protected", "Protected")
rownames(species) <- c("Declining", "Stable/Increase")
species

#make a mosaic plot with an informative title and axes labels
mosaicplot(species, xlab="population status", ylab="legal protection",
           main="Legal protection impacts on populations")

#Conduct a chi-squared test
chisq.test(species)

