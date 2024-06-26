rm(list=ls())
library("tidyverse")
library("tidytext")
setwd("C:/Users/IvanS/Desktop/R/R Hemuppgift 4")
min_katalog <- "C:/Users/IvanS/Desktop/R/R Hemuppgift 4"
setwd(min_katalog)

### Uppgift 1. Importera datatabellen "regfor_all.rds" till R.
regfor_all <- readRDS("regfor_all.rds")
##### Klart





### Uppgift 2. Ber�kna hur l�ng (antal ord) varje regeringsf�rklaring �r. Visualisera resultatet i ett diagram. Tips: b�rja med att tokensiera texten.
regfor_all_token <- regfor_all %>% unnest_tokens(output = "word", input = "text", token = "words") # Tokaniserar texten.
regfor_all_token # Kontrollerar

regfor_all_wordfreq <- regfor_all_token %>% count(year, word, sort = TRUE) # R�knar ordfrekvensen i regeringsf�rklaringarna
regfor_all_wordfreq # Kontrollerar
regfor_all_words <- regfor_all_wordfreq %>% group_by(year) %>% mutate(n_total = sum(n)) # R�knar totala ord f�r varje regeringf�rklaring.
regfor_all_words # Kontrollerar
regfor_all_words %>% distinct(year, n_total) # H�r �r resultatet. Regeringsf�rklaringen fr�n �r 1980 hade 1444 ord, RF fr�n �r 1985 hade 1952, RF 1990 hade 2072, RF 1995 hade 3120, RF 2000 hade 2544, RF 2005 hade 3304, och RF 2010 hade 3880.

regfor_all_words_distinct <- regfor_all_words %>% distinct(year, n_total)
regfor_all_words_distinct # Kontrollerar
regfor_all_words_diagram <- regfor_all_words_distinct %>%
  ggplot(aes(x = year, y = n_total)) + 
  geom_col() + 
  labs(x = "Regeringsf�rklaring", 
       y = "Antal ord", 
       title = "Regeringsf�rklaringarnas l�ngd �ver tid", 
       subtitle = "Diagram �ver hur antalet ord skiljer sig �t i regeringsf�rklaringarna mellan �ren 1980-2015")
regfor_all_words_diagram # H�r �r diagrammet.
##### Klart





### Uppgift 3. G�r en TF-IDF-analys f�r att se vilka ord som var viktigast f�r respektive �r. Visualisera resultatet i ett diagram.
regfor_all_idf <- regfor_all_words %>% bind_tf_idf(word, year, n)
regfor_all_idf # Kontrollerar
regfor_all_idf <- regfor_all_idf %>% arrange(desc(tf_idf)) # Sorterar
regfor_all_idf # Kontrollerar
regfor_all_idf %>% filter(year == 1980) %>% head(1) # Det viktigaste ordet i RF �r 1980 �r "nuvarande".
regfor_all_idf %>% filter(year == 1985) %>% head(1) # Det viktigaste ordet i RF �r 1985 �r "skall".
regfor_all_idf %>% filter(year == 1990) %>% head(1) # Det viktigaste ordet i RF �r 1990 �r "skall".
regfor_all_idf %>% filter(year == 1995) %>% head(1) # Det viktigaste ordet i RF �r 1995 �r "skall".
regfor_all_idf %>% filter(year == 2000) %>% head(1) # Det viktigaste ordet i RF �r 2000 �r "ska".
regfor_all_idf %>% filter(year == 2005) %>% head(1) # Det viktigaste ordet i RF �r 2005 �r "ska".
regfor_all_idf %>% filter(year == 2010) %>% head(1) # Det viktigaste ordet i RF �r 2010 �r "ska".

regfor_all_idf %>% # H�r �r diagrammet.
  group_by(year) %>% 
  slice_max(tf_idf, n = 3) %>% 
  ungroup() %>% 
  ggplot(aes(reorder_within(x = word, by = tf_idf, within = year), y = tf_idf)) + 
  geom_col() + 
  scale_x_reordered() + 
  facet_wrap(~year, scales = "free") + 
  coord_flip() + 
  labs(title = "TF-IDF-diagram som visar de viktigaste orden f�r respektive �r", 
       subtitle = "Regeringsf�rklaringarna och deras �r", 
       x = "Ord", 
       y = "TF-IDF", 
       caption = "Den som �r h�gst uppe �r det viktigaste ordet.")
##### Klart





### Uppgift 4. Ett antal stoppord ("ska" och "skall") kommer att f� stor vikt i TF-IDF-analysen. Ta bort dem och g�r sedan om fr�ga tre. Det �r okej att ta bort �nnu fler stoppord om du vill, men ta som minst bort de tv� ovann�mnda.
extra_words <- c("ska", "skall")

regfor_all_idf <- regfor_all_words %>% bind_tf_idf(word, year, n) %>% filter(!word %in% extra_words)
regfor_all_idf # Kontrollerar
regfor_all_idf <- regfor_all_idf %>% arrange(desc(tf_idf)) # Sorterar
regfor_all_idf # Kontrollerar
regfor_all_idf %>% filter(year == 1980) %>% head(1) # Det viktigaste ordet i RF �r 1980 �r "nuvarande".
regfor_all_idf %>% filter(year == 1985) %>% head(2) # De viktigaste orden i RF �r 1985 �r "Sydafrika" och "�kning". De har exakt lika h�g term frequency (tf) och har ett h�gre tf �n alla andra ord.
regfor_all_idf %>% filter(year == 1990) %>% head(1) # Det viktigaste ordet i RF �r 1990 �r "f�rel�ggs".
regfor_all_idf %>% filter(year == 1995) %>% head(1) # Det viktigaste ordet i RF �r 1995 �r "informationsteknik".
regfor_all_idf %>% filter(year == 2000) %>% head(1) # Det viktigaste ordet i RF �r 2000 �r "stockholms".
regfor_all_idf %>% filter(year == 2005) %>% head(1) # Det viktigaste ordet i RF �r 2005 �r "st�rks".
regfor_all_idf %>% filter(year == 2010) %>% head(1) # Det viktigaste ordet i RF �r 2010 �r "vi".

regfor_all_idf %>% 
  group_by(year) %>% 
  slice_max(tf_idf, n = 3) %>% 
  ungroup() %>% 
  ggplot(aes(reorder_within(x = word, by = tf_idf, within = year), y = tf_idf)) + 
  geom_col() + 
  scale_x_reordered() + 
  facet_wrap(~year, scales = "free") + 
  coord_flip() + 
  labs(title = "TF-IDF-diagram som visar de viktigaste orden f�r respektive �r", 
       subtitle = "Regeringsf�rklaringarna och deras �r", 
       x = "Ord", 
       Y = "TF-IDF", 
       caption = "Den som �r h�gst uppe �r det viktigaste ordet.")
##### Klart





### Uppgift 5. Importera ett sentimentlexikon och tillskriv varje ord sentimentpo�ng enligt detta. Ge alla NA-observationer v�rdet 0. G�r sedan ett diagram �ver hur anv�ndandet av positiva och negativa ord skiljer sig �t mellan �ren 1980-2015.
swedishsentiments <- readRDS("swedish_sentiments.rds") %>% rename(word = text) # Laddar ner sentimentlexikon
swedishsentiments # Kontrollerar
swedishsentiments <- swedishsentiments %>% arrange(word) %>% mutate(is_duplicate = if_else(word == lag(word, 1), TRUE, FALSE)) %>% filter(is_duplicate == FALSE) %>% select(-is_duplicate) # Tar bort dubletter
swedishsentiments # Kontrollerar

regfor_all_sentiments <- left_join(regfor_all_token, swedishsentiments, by = "word") # S�tter ihop sentimentlexikonet med regeringsf�rklaringarna.

regfor_all_sentiments <- regfor_all_sentiments %>% mutate(score = replace_na(score, 0)) # Ge alla NA-observationer v�rdet 0
regfor_all_sentiments # Kontrollerar

regfor_all_sentiments %>% # Diagrammet som visar hur anv�ndandet av positiva och negativa ord skiljer sig �t mellan �ren 1980-2015
  filter(!score == 0) %>%
  ggplot(aes(x = score)) + 
  geom_bar() + 
  labs(x = "Sentimentpo�ng", 
       y = "Antal", 
       title = "Regeringsf�rklaringarnas attityder �ver tid", 
       subtitle = "Diagram �ver hur anv�ndandet av positiva och negativa ord skiljer sig �t mellan �ren 1980-2015",
       caption = "Negativa po�ng = negativa ord, positiva po�ng = positiva ord. Neutrala ord (med v�rdet 0) r�knas inte med.") + 
  scale_x_continuous(breaks = seq(- 5, 5, 1)) +
  facet_wrap(~year, scales = "free")
##### Klart





### Uppgift 6. Vilket parti var mest negativt respektive positivt sett till ordval om vi inte tar h�nsyn till �rtal? Ta h�nsyn till att vissa partier anv�nde sig av f�rre ord. Det inneb�r att sentimentspo�ngen m�ste divideras med antal ord per parti.
regfor_socialdemokraterna <- regfor_all_sentiments %>% filter(!speaker == "Reinfeldt") %>% filter(!speaker == "F�lldin") # Socialdemokraternas regeringsf�rklaringar
regfor_moderaterna <- regfor_all_sentiments %>% filter(speaker == "Reinfeldt") # Moderaternas regeringsf�rklaringar
regfor_centern <- regfor_all_sentiments %>% filter(speaker == "F�lldin") # Centerpartiets regeringsf�rklaringar

# Socialdemokraterna
regfor_socialdemokraterna
regfor_socialdemokraterna_totalscore <- regfor_socialdemokraterna %>% mutate(total_score = sum(score))
regfor_socialdemokraterna_totalscore # Kontrollerar
regfor_socialdemokraterna_averagescore <- regfor_socialdemokraterna_totalscore$total_score/16782 # Observera att 16782 �r hur m�nga ord som finns i alla av Socialdemokraternas regeringsf�rklaringar sammanlagt.
regfor_socialdemokraterna_averagescore # Socialdemokraternas genomsnittliga sentimentpo�ng �r 0,07251817.

# Moderaterna
regfor_moderaterna
regfor_moderaterna_totalscore <- regfor_moderaterna %>% mutate(total_score = sum(score))
regfor_moderaterna_totalscore # Kontrollerar
regfor_moderaterna_averagescore <- regfor_moderaterna_totalscore$total_score/3880 # Observera att 3880 �r hur m�nga ord som finns i alla av Moderaternas regeringsf�rklaringar sammanlagt.
regfor_moderaterna_averagescore # Moderaternas genomsnittliga sentimentpo�ng �r 0,1036082.

# Centerpartiet
regfor_centern
regfor_centern_totalscore <- regfor_centern %>% mutate(total_score = sum(score))
regfor_centern_totalscore # Kontrollerar
regfor_centern_averagescore <- regfor_centern_totalscore$total_score/1444 # Observera att 1444 �r hur m�nga negativa/positiva ord som finns i alla av Centerpartiets regeringsf�rklaringar sammanlagt.
regfor_centern_averagescore # Centerpartiets genomsnittliga sentimentpo�ng �r 0,03601108.

# Toplistan
highscorelist <- data.frame(
  Party = c("Socialdemokraterna", "Moderaterna", "Centerpartiet"),
  Score = c(0.07251817, 0.1036082, 0.03601108))

highscorelist[order(highscorelist$Score, decreasing = TRUE),] # Toplistan �ver det mest positiva partierna. Moderaterna har det mest positiva ordvalet.
highscorelist[order(highscorelist$Score),] # Toplistan �ver det mest negativa partierna. Centerpartiet har det mest negativa ordvalet.
##### Klart

