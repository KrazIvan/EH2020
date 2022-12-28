rm(list=ls())
library("tidyverse")
setwd("C:/Users/IvanS/Desktop/R/R Hemuppgift 2")
min_katalog <- "C:/Users/IvanS/Desktop/R/R Hemuppgift 2"
setwd(min_katalog)
load("hu2_lifeexp.RData")

### Uppgift 1. Ta fram median och medelvärde för alla variabler som innehåller siffror.
# child_mort = barnadödlighet, promille av barn <5 år.
hu2_lifeexp
kiddydeath <- hu2_lifeexp$child_mort
kiddydeath %>% mean() # Medelvärdet är 26,98165.
kiddydeath %>% median() # Median är 14,9.

# econ_freedom = ett index över ekonomisk frihet.
hu2_lifeexp
moneyfreedom <- hu2_lifeexp$econ_freedom
moneyfreedom %>% mean() # Medelvärdet är 6,912411.
moneyfreedom %>% median() # Median är 7,050268.

# gdp = bruttonationalprodukt (BNP på svenska).
hu2_lifeexp
bnp <- hu2_lifeexp$gdp
bnp %>% mean() # Medelvärdet är $17922,81.
bnp %>% median() # Median är $13300,68.

# gini = ginikoefficienten för individers inkomst, hur stor andel av detta lands inkomster som måste omfördelas för att alla individer ska ha samma inkomst.
hu2_lifeexp
ginistat <- hu2_lifeexp$gini
ginistat %>% mean() # Medelvärdet är 37,59908.
ginistat %>% median() # Median är 35,8.

# hdi = Human Development Index, från FN.
hu2_lifeexp
humandev <- hu2_lifeexp$hdi
humandev %>% mean() # Medelvärdet är 0,7187339.
humandev %>% median() # Median är 0,744.

# health_exp = andel av detta lands utgifter för hälso- och sjukvård som finansieras via skatter.
hu2_lifeexp
hp <- hu2_lifeexp$health_exp
hp %>% mean() # Medelvärdet är 57,9303.
hp %>% median() # Median är 59,03067.

# life_expectancy = förväntad medellivslängd.
hu2_lifeexp
life <- hu2_lifeexp$life_expectancy
life %>% mean() # Medelvärdet är 72,29418 år.
life %>% median() # Median är 74,24029 år.

# women_econ_op = index över kvinnors ekonomiska möjligheter.
hu2_lifeexp
girlfreedom <- hu2_lifeexp$women_econ_op
girlfreedom %>% mean() # Medelvärdet är 57,03743.
girlfreedom %>% median() # Median är 54,4631.
##### Klart :-)





### Uppgift 2. Skapa ett histogram var för de variabler som innehåller siffror, totalt 8 stycken. Tips: Om du inte vill skriva ett separat kommando per diagram (du får göra så om du vill), kan du titta närmare på något av följande kommandon: pivot_longer(), facet_wrap(), map(), for().
# Barnadödlighet, promille av barn <5 år.
hist(kiddydeath, probability = TRUE, main = "Barnadödlighet", xlab = "Barnadödlighet (promille av barn <5 år)", ylab = "Sannolikhet")

# Index över ekonomisk frihet.
hist(moneyfreedom, freq=TRUE, main = "Index över ekonomisk frihet", xlab = "Index över ekonomisk frihet", ylab = "Andelen länder")

# Bruttonationalprodukt (BNP på svenska).
hist(bnp, freq=TRUE, main = "BNP", xlab = "BNP", ylab = "Andelen länder")

# Ginikoefficienten för individers inkomst.
hist(ginistat, freq=TRUE, main = "Ginikoefficienten för individers inkomst", xlab = "Gini (inkomst)", ylab = "Andelen länder")

# Human Development Index, från FN.
hist(humandev, freq=TRUE, main = "Human Development Index, från FN", xlab = "HDI", ylab = "Andelen länder", ylim=c(0,25), breaks=12)

# Andel av lands utgifter för hälso- och sjukvård som finansieras via skatter.
hist(hp, freq=TRUE, main = "Andel av lands utgifter för hälso- och sjukvård som finansieras via skatter", xlab = "Andelen skatteutgifter för sjukvård", ylab = "Andelen länder", ylim=c(0,18), breaks=12)

# Förväntad medellivslängd.
hist(life, freq=TRUE, main = "Förväntad medellivslängd", xlab = "Förväntad medellivslängd (år)", ylab = "Andelen länder", ylim=c(0,40))

# Index över kvinnors ekonomiska möjligheter.
hist(girlfreedom, freq=TRUE, main = "Index över kvinnors ekonomiska möjligheter", xlab = "Index över kvinnors ekonomiska möjligheter", ylab = "Andelen länder", ylim=c(0,30))
##### Klart :-)





### Uppgift 3. Skapa punktdiagram för följande variabler (välj x och y själv):
# a. life_expectancy och gdp
plot(life, bnp, main="Punktdiagram mellan BNP och Livslängd", xlab="Livslängd (år)", ylab="BNP (USD)", pch=15, col="blue")


# b. life_expectancy och gini
plot(life, ginistat, main="Punktdiagram mellan Livslängd och Ginikoefficienten", xlab="Livslängd (år)", ylab="Ginikoefficienten", pch=15, col="orange")

# c. gdp och gini
plot(bnp, ginistat, main="Punktdiagram mellan BNP och Ginikoefficienten", xlab="BNP (USD)", ylab="Ginikoefficienten", pch=15, col="green")
##### Klart :-)





### Uppgift 4. Gör samma sak som i fråga 3 men lägg till den räta linjen, beräknad med hjälp av minsta kvadratmetoden för diagrammen (välj x och y själv). Tips: geom_smooth(). 
# a. life_expectancy och gdp
life_and_bnp <- tibble (life, bnp) 
life_and_bnp %>% ggplot(aes(x=life , y=bnp)) + geom_point(color="blue") + geom_smooth(color="red", method="lm")

# b. life_expectancy och gini
life_and_gini <- tibble (life, ginistat) 
life_and_gini %>% ggplot(aes(x=life , y=ginistat)) + geom_point(color="orange") + geom_smooth(color="red", method="lm")

# c. gdp och gini
bnp_and_gini <- tibble (bnp, ginistat) 
bnp_and_gini %>% ggplot(aes(x=bnp , y=ginistat)) + geom_point(color="green") + geom_smooth(color="red", method="lm")
##### Klart :-) 





### Uppgift 5. Ta de tre kombinationerna i fråga tre och beräkna linjära regressionsmodeller för dem, i stil med y = a + b*x , där x och y är variabler som vi har data på och a och b är parametrar som ska beräknas. Du får själv välja vilken variabel du sätter som x och y.
# a. Notera: I R skrivs modeller av denna typ som y ~ x. De beräknas med lm()-kommandot. Du behöver inte presentera dina resultat på något särskilt sätt. 

# Medellivslängd och BNP.
modell1 <- life ~ bnp
lm(modell1 , data = hu2_lifeexp)
resultat1 <- lm(modell1 , data = hu2_lifeexp)
resultat1 %>% summary()

# Medellivslängd och Gini.
modell2 <- life ~ ginistat
lm(modell2 , data = hu2_lifeexp)
resultat2 <- lm(modell2 , data = hu2_lifeexp)
resultat2 %>% summary()

# Gini och BNP.
modell3 <- bnp ~ ginistat
lm(modell3 , data = hu2_lifeexp)
resultat3 <- lm(modell3 , data = hu2_lifeexp)
resultat3 %>% summary()
##### Klart :-) 





### Uppgift 6. Nu ska du beräkna en samling regressioner. life_expectancy är den beroende variabeln (alltså y) i alla regressioner.
# a. Beräkna en modell för varje annan variabel i tabellen som innehåller siffror. Tips: map().
omnilifemodell <- life ~ kiddydeath + moneyfreedom + bnp + ginistat + humandev + hp + girlfreedom
lm(omnilifemodell , data = hu2_lifeexp)
omniliferesultat <- lm(omnilifemodell , data = hu2_lifeexp)
omniliferesultat %>% summary()

# b. Redovisa resultaten från 6a i en stor tabell. Till exempel med hjälp av kommandot stargazer().
install.packages("stargazer") # Om du inte redan har gjort innan
library("stargazer")
stargazer(omniliferesultat, type = "text")
##### Klart :-)
