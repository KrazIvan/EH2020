#rm(list=ls())
library("tidyverse")
setwd("C:/Users/IvanS/Desktop/R/R Hemuppgift 1")
min_katalog <- "C:/Users/IvanS/Desktop/R/R Hemuppgift 1"
setwd(min_katalog)
load("hu1_continents.RData")
load("hu1_lifeexp.RData")

# Uppgift 1. Ber�kna medelv�rde och median av livsl�ngd, f�r hela samlingen av l�nder i tabellen
hu1_lifeexp
life <- hu1_lifeexp$life_expectancy
life %>% mean() # `Medelv�rdet �r 72,29418 �r.
life %>%  median() # Median �r 74,24029 �r.

# Uppgift 2. I vilka tre l�nder var livsl�ngden h�gst respektive l�gst?
hu1_lifeexp %>% top_n(3) # Top tre h�gsta: Japan (83,3 �r), Island (83,1 �r) & Schweiz (82,7 �r).
hu1_lifeexp %>% top_n(-3) # Top tre l�gsta: Botswana (47,4 �r), Elfenbenskusten (50,8 �r) & Chad (51,2 �r).

# Uppgift 3. G�r ett stapeldiagram som visar medellivsl�ngden i de fem l�nder som hade h�gst respektive l�gst medellivsl�ngd. 
hu1_lifeexp %>% top_n(5) # Top fem h�gsta
hu1_lifeexp %>% top_n(-5) # Top fem l�gsta

df <- data.frame(
  land=c("Japan","Iceland","Switzerland","Spain","Italy", "Botswana", "Cote d'Ivoire", "Chad", "Nigeria", "Cameroon"),lifeexpe=c(83.3,83.1,82.7,82.4,82.3, 47.4, 50.8, 51.2, 52.5, 55.0))
top_n(df, n=10, lifeexpe) %>%
  ggplot(., aes(x=land, y=lifeexpe))+
  geom_bar(stat="identity")

# Uppgift 4. Sammanf�r datatabellen som inneh�ller medellivsl�ngd med den som inneh�ller information om vilken v�rldsdel som l�nderna tillh�r. Tips: anv�nd funktionen inner_join(). 
names(hu1_continets)[names(hu1_continets) == "land"] <- "country"
colnames(hu1_continets)

world_stats <- inner_join(hu1_continets , 
                          hu1_lifeexp,
                          by="country")
world_stats # Klart! :-)

# Uppgift 5. J�mf�r medellivsl�ngden i v�rldsdelarna. Tips: anv�nd funktionen group_by(). 
life_by_continents <- world_stats %>% group_by(continent) %>% 
  mutate(life_mean_continent= mean(life_expectancy) ,
         n_per_continent= n() )

life_by_continents %>% select(-country) %>% distinct(continent, .keep_all = TRUE) # Europa: 78,1 �r. Afrika: 60,9 �r. Asien: 72,9 �r. Oceanien: 71,5 �r. Amerika: 75,5 �r.

# Uppgift 6. G�r ett valfritt diagram f�r att illustrera skillnaden i medellivsl�ngd mellan v�rldsdelarna.
df <- data.frame(
  group = c("Europe", "Africa", "Asia", "Oceania", "Americas"),
  value = c(78.1, 60.9, 72.9, 71.5, 75.5)
)
head(df)
library(ggplot2)

# Stapeldiagram 1
df <- data.frame(
  land=c("Europe", "Africa", "Asia", "Oceania", "Americas"),lifeexpe=c(78.1, 60.9, 72.9, 71.5, 75.5))
top_n(df, n=5, lifeexpe) %>%
  ggplot(., aes(x=land, y=lifeexpe))+
  geom_bar(stat="identity")

# Stapeldiagram 2
df <- data.frame(
  group = c("Europe", "Africa", "Asia", "Oceania", "Americas"),
  value = c(78.1, 60.9, 72.9, 71.5, 75.5)
)
head(df)
library(ggplot2)

bp<- ggplot(df, aes(x="Average Life Expectancy (Years)", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
bp

# Cirkeldiagram
pie <- bp + coord_polar("y", start=0)
pie
pie + scale_fill_brewer(palette="Dark2")

# Klart :-)