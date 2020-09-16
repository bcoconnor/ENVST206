#read in data and name data frame
ch4 <- read.csv("/Users/brynnoconnor/Documents/ENVSTDATA/ao3/lemming_herbivory.csv")

#treat herbivory column as factor
ch4$herbivory <- as.factor(ch4$herbivory)

#first variable is dependent, depends on second independent variable
#methane depends on if there is herbivory
plot(ch4$CH4_Flux ~ ch4$herbivory)

#shapiro wilks test
#experiment treatment
shapiro.test(ch4$CH4_Flux[ch4$herbivory == "Ex"])
#control group
shapiro.test(ch4$CH4_Flux[ch4$herbivory == "Ctl"])

#bartlett test
bartlett.test(ch4$CH4_Flux ~ ch4$herbivory)

#2 sample t test
t.test(ch4$CH4_Flux ~ ch4$herbivory)
