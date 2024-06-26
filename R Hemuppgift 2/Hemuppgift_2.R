rm(list=ls())
library("tidyverse")
setwd("C:/Users/IvanS/Desktop/R/R Hemuppgift 2")
min_katalog <- "C:/Users/IvanS/Desktop/R/R Hemuppgift 2"
setwd(min_katalog)
load("hu2_lifeexp.RData")

### Uppgift 1. Ta fram median och medelv�rde f�r alla variabler som inneh�ller siffror.
# child_mort = barnad�dlighet, promille av barn <5 �r.
hu2_lifeexp
kiddydeath <- hu2_lifeexp$child_mort
kiddydeath %>% mean() # Medelv�rdet �r 26,98165.
kiddydeath %>% median() # Median �r 14,9.

# econ_freedom = ett index �ver ekonomisk frihet.
hu2_lifeexp
moneyfreedom <- hu2_lifeexp$econ_freedom
moneyfreedom %>% mean() # Medelv�rdet �r 6,912411.
moneyfreedom %>% median() # Median �r 7,050268.

# gdp = bruttonationalprodukt (BNP p� svenska).
hu2_lifeexp
bnp <- hu2_lifeexp$gdp
bnp %>% mean() # Medelv�rdet �r $17922,81.
bnp %>% median() # Median �r $13300,68.

# gini = ginikoefficienten f�r individers inkomst, hur stor andel av detta lands inkomster som m�ste omf�rdelas f�r att alla individer ska ha samma inkomst.
hu2_lifeexp
ginistat <- hu2_lifeexp$gini
ginistat %>% mean() # Medelv�rdet �r 37,59908.
ginistat %>% median() # Median �r 35,8.

# hdi = Human Development Index, fr�n FN.
hu2_lifeexp
humandev <- hu2_lifeexp$hdi
humandev %>% mean() # Medelv�rdet �r 0,7187339.
humandev %>% median() # Median �r 0,744.

# health_exp = andel av detta lands utgifter f�r h�lso- och sjukv�rd som finansieras via skatter.
hu2_lifeexp
hp <- hu2_lifeexp$health_exp
hp %>% mean() # Medelv�rdet �r 57,9303.
hp %>% median() # Median �r 59,03067.

# life_expectancy = f�rv�ntad medellivsl�ngd.
hu2_lifeexp
life <- hu2_lifeexp$life_expectancy
life %>% mean() # Medelv�rdet �r 72,29418 �r.
life %>% median() # Median �r 74,24029 �r.

# women_econ_op = index �ver kvinnors ekonomiska m�jligheter.
hu2_lifeexp
girlfreedom <- hu2_lifeexp$women_econ_op
girlfreedom %>% mean() # Medelv�rdet �r 57,03743.
girlfreedom %>% median() # Median �r 54,4631.
##### Klart :-)





### Uppgift 2. Skapa ett histogram var f�r de variabler som inneh�ller siffror, totalt 8 stycken. Tips: Om du inte vill skriva ett separat kommando per diagram (du f�r g�ra s� om du vill), kan du titta n�rmare p� n�got av f�ljande kommandon: pivot_longer(), facet_wrap(), map(), for().
# Barnad�dlighet, promille av barn <5 �r.
hist(kiddydeath, probability = TRUE, main = "Barnad�dlighet", xlab = "Barnad�dlighet (promille av barn <5 �r)", ylab = "Sannolikhet")

# Index �ver ekonomisk frihet.
hist(moneyfreedom, freq=TRUE, main = "Index �ver ekonomisk frihet", xlab = "Index �ver ekonomisk frihet", ylab = "Andelen l�nder")

# Bruttonationalprodukt (BNP p� svenska).
hist(bnp, freq=TRUE, main = "BNP", xlab = "BNP", ylab = "Andelen l�nder")

# Ginikoefficienten f�r individers inkomst.
hist(ginistat, freq=TRUE, main = "Ginikoefficienten f�r individers inkomst", xlab = "Gini (inkomst)", ylab = "Andelen l�nder")

# Human Development Index, fr�n FN.
hist(humandev, freq=TRUE, main = "Human Development Index, fr�n FN", xlab = "HDI", ylab = "Andelen l�nder", ylim=c(0,25), breaks=12)

# Andel av lands utgifter f�r h�lso- och sjukv�rd som finansieras via skatter.
hist(hp, freq=TRUE, main = "Andel av lands utgifter f�r h�lso- och sjukv�rd som finansieras via skatter", xlab = "Andelen skatteutgifter f�r sjukv�rd", ylab = "Andelen l�nder", ylim=c(0,18), breaks=12)

# F�rv�ntad medellivsl�ngd.
hist(life, freq=TRUE, main = "F�rv�ntad medellivsl�ngd", xlab = "F�rv�ntad medellivsl�ngd (�r)", ylab = "Andelen l�nder", ylim=c(0,40))

# Index �ver kvinnors ekonomiska m�jligheter.
hist(girlfreedom, freq=TRUE, main = "Index �ver kvinnors ekonomiska m�jligheter", xlab = "Index �ver kvinnors ekonomiska m�jligheter", ylab = "Andelen l�nder", ylim=c(0,30))
##### Klart :-)





### Uppgift 3. Skapa punktdiagram f�r f�ljande variabler (v�lj x och y sj�lv):
# a. life_expectancy och gdp
plot(life, bnp, main="Punktdiagram mellan BNP och Livsl�ngd", xlab="Livsl�ngd (�r)", ylab="BNP (USD)", pch=15, col="blue")


# b. life_expectancy och gini
plot(life, ginistat, main="Punktdiagram mellan Livsl�ngd och Ginikoefficienten", xlab="Livsl�ngd (�r)", ylab="Ginikoefficienten", pch=15, col="orange")

# c. gdp och gini
plot(bnp, ginistat, main="Punktdiagram mellan BNP och Ginikoefficienten", xlab="BNP (USD)", ylab="Ginikoefficienten", pch=15, col="green")
##### Klart :-)





### Uppgift 4. G�r samma sak som i fr�ga 3 men l�gg till den r�ta linjen, ber�knad med hj�lp av minsta kvadratmetoden f�r diagrammen (v�lj x och y sj�lv). Tips: geom_smooth(). 
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





### Uppgift 5. Ta de tre kombinationerna i fr�ga tre och ber�kna linj�ra regressionsmodeller f�r dem, i stil med y = a + b*x , d�r x och y �r variabler som vi har data p� och a och b �r parametrar som ska ber�knas. Du f�r sj�lv v�lja vilken variabel du s�tter som x och y.
# a. Notera: I R skrivs modeller av denna typ som y ~ x. De ber�knas med lm()-kommandot. Du beh�ver inte presentera dina resultat p� n�got s�rskilt s�tt. 

# Medellivsl�ngd och BNP.
modell1 <- life ~ bnp
lm(modell1 , data = hu2_lifeexp)
resultat1 <- lm(modell1 , data = hu2_lifeexp)
resultat1 %>% summary()

# Medellivsl�ngd och Gini.
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





### Uppgift 6. Nu ska du ber�kna en samling regressioner. life_expectancy �r den beroende variabeln (allts� y) i alla regressioner.
# a. Ber�kna en modell f�r varje annan variabel i tabellen som inneh�ller siffror. Tips: map().
omnilifemodell <- life ~ kiddydeath + moneyfreedom + bnp + ginistat + humandev + hp + girlfreedom
lm(omnilifemodell , data = hu2_lifeexp)
omniliferesultat <- lm(omnilifemodell , data = hu2_lifeexp)
omniliferesultat %>% summary()

# b. Redovisa resultaten fr�n 6a i en stor tabell. Till exempel med hj�lp av kommandot stargazer().
install.packages("stargazer") # Om du inte redan har gjort innan
library("stargazer")
stargazer(omniliferesultat, type = "text")
##### Klart :-)
