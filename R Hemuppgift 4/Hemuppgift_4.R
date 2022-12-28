rm(list=ls())
library("tidyverse")
library("tidytext")
setwd("C:/Users/IvanS/Desktop/R/R Hemuppgift 4")
min_katalog <- "C:/Users/IvanS/Desktop/R/R Hemuppgift 4"
setwd(min_katalog)

### Uppgift 1. Importera datatabellen "regfor_all.rds" till R.
regfor_all <- readRDS("regfor_all.rds")
##### Klart





### Uppgift 2. Beräkna hur lång (antal ord) varje regeringsförklaring är. Visualisera resultatet i ett diagram. Tips: börja med att tokensiera texten.
regfor_all_token <- regfor_all %>% unnest_tokens(output = "word", input = "text", token = "words") # Tokaniserar texten.
regfor_all_token # Kontrollerar

regfor_all_wordfreq <- regfor_all_token %>% count(year, word, sort = TRUE) # Räknar ordfrekvensen i regeringsförklaringarna
regfor_all_wordfreq # Kontrollerar
regfor_all_words <- regfor_all_wordfreq %>% group_by(year) %>% mutate(n_total = sum(n)) # Räknar totala ord för varje regeringförklaring.
regfor_all_words # Kontrollerar
regfor_all_words %>% distinct(year, n_total) # Här är resultatet. Regeringsförklaringen från år 1980 hade 1444 ord, RF från år 1985 hade 1952, RF 1990 hade 2072, RF 1995 hade 3120, RF 2000 hade 2544, RF 2005 hade 3304, och RF 2010 hade 3880.

regfor_all_words_distinct <- regfor_all_words %>% distinct(year, n_total)
regfor_all_words_distinct # Kontrollerar
regfor_all_words_diagram <- regfor_all_words_distinct %>%
  ggplot(aes(x = year, y = n_total)) + 
  geom_col() + 
  labs(x = "Regeringsförklaring", 
       y = "Antal ord", 
       title = "Regeringsförklaringarnas längd över tid", 
       subtitle = "Diagram över hur antalet ord skiljer sig åt i regeringsförklaringarna mellan åren 1980-2015")
regfor_all_words_diagram # Här är diagrammet.
##### Klart





### Uppgift 3. Gör en TF-IDF-analys för att se vilka ord som var viktigast för respektive år. Visualisera resultatet i ett diagram.
regfor_all_idf <- regfor_all_words %>% bind_tf_idf(word, year, n)
regfor_all_idf # Kontrollerar
regfor_all_idf <- regfor_all_idf %>% arrange(desc(tf_idf)) # Sorterar
regfor_all_idf # Kontrollerar
regfor_all_idf %>% filter(year == 1980) %>% head(1) # Det viktigaste ordet i RF år 1980 är "nuvarande".
regfor_all_idf %>% filter(year == 1985) %>% head(1) # Det viktigaste ordet i RF år 1985 är "skall".
regfor_all_idf %>% filter(year == 1990) %>% head(1) # Det viktigaste ordet i RF år 1990 är "skall".
regfor_all_idf %>% filter(year == 1995) %>% head(1) # Det viktigaste ordet i RF år 1995 är "skall".
regfor_all_idf %>% filter(year == 2000) %>% head(1) # Det viktigaste ordet i RF år 2000 är "ska".
regfor_all_idf %>% filter(year == 2005) %>% head(1) # Det viktigaste ordet i RF år 2005 är "ska".
regfor_all_idf %>% filter(year == 2010) %>% head(1) # Det viktigaste ordet i RF år 2010 är "ska".

regfor_all_idf %>% # Här är diagrammet.
  group_by(year) %>% 
  slice_max(tf_idf, n = 3) %>% 
  ungroup() %>% 
  ggplot(aes(reorder_within(x = word, by = tf_idf, within = year), y = tf_idf)) + 
  geom_col() + 
  scale_x_reordered() + 
  facet_wrap(~year, scales = "free") + 
  coord_flip() + 
  labs(title = "TF-IDF-diagram som visar de viktigaste orden för respektive år", 
       subtitle = "Regeringsförklaringarna och deras år", 
       x = "Ord", 
       y = "TF-IDF", 
       caption = "Den som är högst uppe är det viktigaste ordet.")
##### Klart





### Uppgift 4. Ett antal stoppord ("ska" och "skall") kommer att få stor vikt i TF-IDF-analysen. Ta bort dem och gör sedan om fråga tre. Det är okej att ta bort ännu fler stoppord om du vill, men ta som minst bort de två ovannämnda.
extra_words <- c("ska", "skall")

regfor_all_idf <- regfor_all_words %>% bind_tf_idf(word, year, n) %>% filter(!word %in% extra_words)
regfor_all_idf # Kontrollerar
regfor_all_idf <- regfor_all_idf %>% arrange(desc(tf_idf)) # Sorterar
regfor_all_idf # Kontrollerar
regfor_all_idf %>% filter(year == 1980) %>% head(1) # Det viktigaste ordet i RF år 1980 är "nuvarande".
regfor_all_idf %>% filter(year == 1985) %>% head(2) # De viktigaste orden i RF år 1985 är "Sydafrika" och "ökning". De har exakt lika hög term frequency (tf) och har ett högre tf än alla andra ord.
regfor_all_idf %>% filter(year == 1990) %>% head(1) # Det viktigaste ordet i RF år 1990 är "föreläggs".
regfor_all_idf %>% filter(year == 1995) %>% head(1) # Det viktigaste ordet i RF år 1995 är "informationsteknik".
regfor_all_idf %>% filter(year == 2000) %>% head(1) # Det viktigaste ordet i RF år 2000 är "stockholms".
regfor_all_idf %>% filter(year == 2005) %>% head(1) # Det viktigaste ordet i RF år 2005 är "stärks".
regfor_all_idf %>% filter(year == 2010) %>% head(1) # Det viktigaste ordet i RF år 2010 är "vi".

regfor_all_idf %>% 
  group_by(year) %>% 
  slice_max(tf_idf, n = 3) %>% 
  ungroup() %>% 
  ggplot(aes(reorder_within(x = word, by = tf_idf, within = year), y = tf_idf)) + 
  geom_col() + 
  scale_x_reordered() + 
  facet_wrap(~year, scales = "free") + 
  coord_flip() + 
  labs(title = "TF-IDF-diagram som visar de viktigaste orden för respektive år", 
       subtitle = "Regeringsförklaringarna och deras år", 
       x = "Ord", 
       Y = "TF-IDF", 
       caption = "Den som är högst uppe är det viktigaste ordet.")
##### Klart





### Uppgift 5. Importera ett sentimentlexikon och tillskriv varje ord sentimentpoäng enligt detta. Ge alla NA-observationer värdet 0. Gör sedan ett diagram över hur användandet av positiva och negativa ord skiljer sig åt mellan åren 1980-2015.
swedishsentiments <- readRDS("swedish_sentiments.rds") %>% rename(word = text) # Laddar ner sentimentlexikon
swedishsentiments # Kontrollerar
swedishsentiments <- swedishsentiments %>% arrange(word) %>% mutate(is_duplicate = if_else(word == lag(word, 1), TRUE, FALSE)) %>% filter(is_duplicate == FALSE) %>% select(-is_duplicate) # Tar bort dubletter
swedishsentiments # Kontrollerar

regfor_all_sentiments <- left_join(regfor_all_token, swedishsentiments, by = "word") # Sätter ihop sentimentlexikonet med regeringsförklaringarna.

regfor_all_sentiments <- regfor_all_sentiments %>% mutate(score = replace_na(score, 0)) # Ge alla NA-observationer värdet 0
regfor_all_sentiments # Kontrollerar

regfor_all_sentiments %>% # Diagrammet som visar hur användandet av positiva och negativa ord skiljer sig åt mellan åren 1980-2015
  filter(!score == 0) %>%
  ggplot(aes(x = score)) + 
  geom_bar() + 
  labs(x = "Sentimentpoäng", 
       y = "Antal", 
       title = "Regeringsförklaringarnas attityder över tid", 
       subtitle = "Diagram över hur användandet av positiva och negativa ord skiljer sig åt mellan åren 1980-2015",
       caption = "Negativa poäng = negativa ord, positiva poäng = positiva ord. Neutrala ord (med värdet 0) räknas inte med.") + 
  scale_x_continuous(breaks = seq(- 5, 5, 1)) +
  facet_wrap(~year, scales = "free")
##### Klart





### Uppgift 6. Vilket parti var mest negativt respektive positivt sett till ordval om vi inte tar hänsyn till årtal? Ta hänsyn till att vissa partier använde sig av färre ord. Det innebär att sentimentspoängen måste divideras med antal ord per parti.
regfor_socialdemokraterna <- regfor_all_sentiments %>% filter(!speaker == "Reinfeldt") %>% filter(!speaker == "Fälldin") # Socialdemokraternas regeringsförklaringar
regfor_moderaterna <- regfor_all_sentiments %>% filter(speaker == "Reinfeldt") # Moderaternas regeringsförklaringar
regfor_centern <- regfor_all_sentiments %>% filter(speaker == "Fälldin") # Centerpartiets regeringsförklaringar

# Socialdemokraterna
regfor_socialdemokraterna
regfor_socialdemokraterna_totalscore <- regfor_socialdemokraterna %>% mutate(total_score = sum(score))
regfor_socialdemokraterna_totalscore # Kontrollerar
regfor_socialdemokraterna_averagescore <- regfor_socialdemokraterna_totalscore$total_score/16782 # Observera att 16782 är hur många ord som finns i alla av Socialdemokraternas regeringsförklaringar sammanlagt.
regfor_socialdemokraterna_averagescore # Socialdemokraternas genomsnittliga sentimentpoäng är 0,07251817.

# Moderaterna
regfor_moderaterna
regfor_moderaterna_totalscore <- regfor_moderaterna %>% mutate(total_score = sum(score))
regfor_moderaterna_totalscore # Kontrollerar
regfor_moderaterna_averagescore <- regfor_moderaterna_totalscore$total_score/3880 # Observera att 3880 är hur många ord som finns i alla av Moderaternas regeringsförklaringar sammanlagt.
regfor_moderaterna_averagescore # Moderaternas genomsnittliga sentimentpoäng är 0,1036082.

# Centerpartiet
regfor_centern
regfor_centern_totalscore <- regfor_centern %>% mutate(total_score = sum(score))
regfor_centern_totalscore # Kontrollerar
regfor_centern_averagescore <- regfor_centern_totalscore$total_score/1444 # Observera att 1444 är hur många negativa/positiva ord som finns i alla av Centerpartiets regeringsförklaringar sammanlagt.
regfor_centern_averagescore # Centerpartiets genomsnittliga sentimentpoäng är 0,03601108.

# Toplistan
highscorelist <- data.frame(
  Party = c("Socialdemokraterna", "Moderaterna", "Centerpartiet"),
  Score = c(0.07251817, 0.1036082, 0.03601108))

highscorelist[order(highscorelist$Score, decreasing = TRUE),] # Toplistan över det mest positiva partierna. Moderaterna har det mest positiva ordvalet.
highscorelist[order(highscorelist$Score),] # Toplistan över det mest negativa partierna. Centerpartiet har det mest negativa ordvalet.
##### Klart

