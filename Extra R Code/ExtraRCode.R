rm(list=ls())
install.packages("tidyverse")
install.packages("wooldridge")
install.packages("tidytext")
library("tidyverse")
library("tidytext")
library("wooldridge")
setwd("C:/Users/IvanS/Desktop/R/ExtraRCode")
my_catalog <- "C:/Users/IvanS/Desktop/R/ExtraRCode"
setwd(my_catalog)

###1. Use some data that allows you to estimate a wage equation. Estimate a wage equation including a dummy variable for female (FEMALE). Interpret the estimated coefficient for the variable Female.
load("wage.rda")
lnu
# Wage equation: wage = ??0 + ??1female + ??2school + ??3expr
lnu_no_public <- subset(lnu, select = -public)
femalewagemodel <- lm(wage ~ female + school + expr, data = lnu_no_public)
summary(femalewagemodel)$coef #Here is the coefficient for the female variable. Since this variable is negative, this suggests that woman earn less on average than men.


###2. Estimate the same model adding a dummy variable for public sector (PUBLIC). Interpret the estimated coefficient for the variable PUBLIC. Compare the estimate for FEMALE in this model and the model above where the variable PUBLIC was not included.
load("wage.rda")
lnu
# Wage equation: wage = ??0 + ??1female + ??2school + ??3expr + ??4public
publicfemalewagemodel <- lm(wage ~ female + school + expr + public, data = lnu)
summary(publicfemalewagemodel)$coef #Here is the coefficient for the public sector and the female variable with the public variable included.

#Interpretation: 
#Public sector workers earn less on average than private sector workers.
#Female workers in both sectors earn less on average than male workers in both sectors.
#But female public sector workers earn more on average than female private sector workers (having a coefficient of approximately -11 instead of -14).



###3. Estimate the wage equations above separately for Men and Women. Comment on the results you obtain here with the results you obtained when estimating the wage equation using the pooled data for men and women.
install.packages("car")
library(car)

lnu_genderswap <- lnu
lnu_genderswap$female <- recode(lnu_genderswap$female, "1L = 0L ; 0L = 1L")
lnu_genderswap$female <- as.integer(lnu_genderswap$female)
names(lnu_genderswap)[names(lnu_genderswap) == "female"] <- "male"

# Male wage equation: wage = ??0 + ??1male + ??2school + ??3expr + ??4public
publicmalewagemodel <- lm(wage ~ male + school + expr + public, data = lnu_genderswap)
summary(publicmalewagemodel)$coef #Here is the coefficient for the male variable with the public variable included.

# Female wage equation: wage = ??0 + ??1female + ??2school + ??3expr + ??4public
summary(publicfemalewagemodel)$coef #Here is the coefficient for the female variable with the public variable included.



# Male wage equation without the public variable: wage = ??0 + ??1male + ??2school + ??3expr
lnu_genderswap_no_public <- subset(lnu_genderswap, select = -public)
malewagemodel <- lm(wage ~ male + school + expr, data = lnu_genderswap_no_public)
summary(malewagemodel)$coef #Here is the coefficient for the male variable without the public variable.

# Female wage equation without the public variable: wage = ??0 + ??1female + ??2school + ??3expr
summary(femalewagemodel)$coef #Here is the coefficient for the female variable without the public variable.



###4. Using the years of schooling variable you can define category variables as follows. PRIMARY for those who have less than 12 years of schooling. GYMNASIUM for those who have between 12 and 14 years of school in grand UNIVERSITY for those who have 15 years or more years of schooling.
CatSchool <- cut(lnu$school, breaks=c(0, 12, 14, Inf), labels = c("primary", "gymnasium", "university")) #Categorical schooling: primary = <12, gymnasium = 12-14, university = >14.

