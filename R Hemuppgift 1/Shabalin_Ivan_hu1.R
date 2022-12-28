#rm(list=ls())
library("tidyverse")
setwd("C:/Users/IvanS/Desktop/R/R Hemuppgift 1")
min_katalog <- "C:/Users/IvanS/Desktop/R/R Hemuppgift 1"
setwd(min_katalog)
load("hu1_continents.RData")
load("hu1_lifeexp.RData")

# Uppgift 1. Beräkna medelvärde och median av livslängd, för hela samlingen av länder i tabellen
hu1_lifeexp
life <- hu1_lifeexp$life_expectancy
life %>% mean() # `Medelvärdet är 72,29418 år.
life %>%  median() # Median är 74,24029 år.

# Uppgift 2. I vilka tre länder var livslängden högst respektive lägst?
hu1_lifeexp %>% top_n(3) # Top tre högsta: Japan (83,3 år), Island (83,1 år) & Schweiz (82,7 år).
hu1_lifeexp %>% top_n(-3) # Top tre lägsta: Botswana (47,4 år), Elfenbenskusten (50,8 år) & Chad (51,2 år).

# Uppgift 3. Gör ett stapeldiagram som visar medellivslängden i de fem länder som hade högst respektive lägst medellivslängd. 
hu1_lifeexp %>% top_n(5) # Top fem högsta
hu1_lifeexp %>% top_n(-5) # Top fem lägsta

df <- data.frame(
  land=c("Japan","Iceland","Switzerland","Spain","Italy", "Botswana", "Cote d'Ivoire", "Chad", "Nigeria", "Cameroon"),lifeexpe=c(83.3,83.1,82.7,82.4,82.3, 47.4, 50.8, 51.2, 52.5, 55.0))
top_n(df, n=10, lifeexpe) %>%
  ggplot(., aes(x=land, y=lifeexpe))+
  geom_bar(stat="identity")

# Uppgift 4. Sammanför datatabellen som innehåller medellivslängd med den som innehåller information om vilken världsdel som länderna tillhör. Tips: använd funktionen inner_join(). 
names(hu1_continets)[names(hu1_continets) == "land"] <- "country"
colnames(hu1_continets)

world_stats <- inner_join(hu1_continets , 
                          hu1_lifeexp,
                          by="country")
world_stats # Klart! :-)

# Uppgift 5. Jämför medellivslängden i världsdelarna. Tips: använd funktionen group_by(). 
life_by_continents <- world_stats %>% group_by(continent) %>% 
  mutate(life_mean_continent= mean(life_expectancy) ,
         n_per_continent= n() )

life_by_continents %>% select(-country) %>% distinct(continent, .keep_all = TRUE) # Europa: 78,1 år. Afrika: 60,9 år. Asien: 72,9 år. Oceanien: 71,5 år. Amerika: 75,5 år.

# Uppgift 6. Gör ett valfritt diagram för att illustrera skillnaden i medellivslängd mellan världsdelarna.
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