rm(list=ls())
library("tidyverse")
library("dplyr")
setwd("C:/Users/IvanS/Desktop/R/R Hemuppgift 3")
min_katalog <- "C:/Users/IvanS/Desktop/R/R Hemuppgift 3"
setwd(min_katalog)

### Uppgift 1. Importera f�ljande fyra b�cker i R:
#- Smith, An Inquiry into the Nature and Causes of the Wealth of Nations
#- Malthus, An Essay on the Principles of Population
#- Ricardo, On the Principles of Political Economy, and Taxation
#- Marx, A Contribution to The Critique of the Political Economy
install.packages("gutenbergr") # Om inte redan gjort
library("gutenbergr")
fourbooks <- gutenberg_download(c( 3300, 46423, 33310, 4239 ), meta_field = "title")
fourbooks %>% count(title) # Kontrollerar att det �r alla
##### Klart :-)





### Uppgift 2. Tokenisera texten. Varje analysenhet ska vara ett ord och endast sm� bokst�ver.
install.packages("tidytext") # Om inte redan gjort
library("tidytext")
fourbooksnotitle <- gutenberg_download(c( 3300, 46423, 33310, 4239 ))
?unnest_tokens
fourbooks_token_words <- 
  fourbooksnotitle %>% 
  unnest_tokens(input = "text", 
                output = "fourbooks_token_words", 
                token = "words", 
                to_lower = TRUE)
fourbooks_token_words # Tokaniserad text
fourbooks_token_words %>% list(fourbooks_token_words$fourbooks_token_words) # Expanderad lista med endast orden (ingen ID).
##### Klart :-)





### Uppgift 3. Importera lista med stoppord. En lista med engelska stoppord finns uppladdad p� Athena. Samma lista kan n�s direkt i R med koden stopwords <- tidytext::stop_words.
stopwords <- tidytext::stop_words
stopwords # Listan �r importerad.
##### Klart :-)





### Uppgift 4. Rensa all data fr�n stoppord.
stopwords = NULL # Rensar all data fr�n stoppord.
rm(stopwords) # Alternativt: Tar bort stoppord.
##### Klart :-) 





### Uppgift 5. Ta fram en lista p� de 20 vanligaste orden i respektive bok.
#- Smith, An Inquiry into the Nature and Causes of the Wealth of Nations
Smith <- gutenberg_download(c(3300)) # Smiths bok
Smith_token_words <- 
  Smith %>% 
  unnest_tokens(input = "text", 
                output = "Smith_token_words", 
                token = "words", 
                to_lower = TRUE)
Smithtopwordfreq <- Smith_token_words %>% count(Smith_token_words, sort = TRUE)
Smithtopwordfreq %>% head(20) # H�r �r listan �ver de 20 vanligaste orden i Smiths bok.

#- Malthus, An Essay on the Principles of Population
Malthus <- gutenberg_download(c(4239)) # Malthus bok
Malthus_token_words <- 
  Malthus %>% 
  unnest_tokens(input = "text", 
                output = "Malthus_token_words", 
                token = "words", 
                to_lower = TRUE)
Malthustopwordfreq <- Malthus_token_words %>% count(Malthus_token_words, sort = TRUE)
Malthustopwordfreq %>% head(20) # H�r �r listan �ver de 20 vanligaste orden i Malthus bok.

#- Ricardo, On the Principles of Political Economy, and Taxation
Ricardo <- gutenberg_download(c(33310)) # Ricardos bok
Ricardo_token_words <- 
  Ricardo %>% 
  unnest_tokens(input = "text", 
                output = "Ricardo_token_words", 
                token = "words", 
                to_lower = TRUE)
Ricardotopwordfreq <- Ricardo_token_words %>% count(Ricardo_token_words, sort = TRUE)
Ricardotopwordfreq %>% head(20) # H�r �r listan �ver de 20 vanligaste orden i Ricardos bok.

#- Marx, A Contribution to The Critique of the Political Economy
Marx <- gutenberg_download(c(46423)) # Marx bok
Marx_token_words <- 
  Marx %>% 
  unnest_tokens(input = "text", 
                output = "Marx_token_words", 
                token = "words", 
                to_lower = TRUE)
Marxtopwordfreq <- Marx_token_words %>% count(Marx_token_words, sort = TRUE)
Marxtopwordfreq %>% head(20) # H�r �r listan �ver de 20 vanligaste orden i Marx bok.

# Alla fyra b�cker samtidigt (Bonus)
fourbookstopwordfreq <- fourbooks_token_words %>% count(fourbooks_token_words, sort = TRUE)
fourbookstopwordfreq %>% head(20) # H�r �r listan �ver de 20 vanligaste orden i alla de fyra b�ckerna.
##### Klart :-) 




### Uppgift 6. Illustrera resultatet fr�n fr�ga 5 med hj�lp av ett eller flera diagram.
library(ggplot2)
# Diagram �ver de 20 vanligaste orden i Smiths bok.
Smithtop20wordfreq <- Smithtopwordfreq %>% head(20)
Smithtop20wordfreq
names(Smithtop20wordfreq)[names(Smithtop20wordfreq) == "Smith_token_words"] <- "Ord"
names(Smithtop20wordfreq)[names(Smithtop20wordfreq) == "n"] <- "Frekvens"
SmithTop20Diagram <- ggplot(Smithtop20wordfreq, 
       aes(Ord, Frekvens)) + geom_bar(stat = "identity") + ggtitle("Diagram �ver de 20 vanligaste orden i Smiths bok")
SmithTop20Diagram # Smiths diagram

# Diagram �ver de 20 vanligaste orden i Malthus bok.
Malthustop20wordfreq <- Malthustopwordfreq %>% head(20)
Malthustop20wordfreq
names(Malthustop20wordfreq)[names(Malthustop20wordfreq) == "Malthus_token_words"] <- "Ord"
names(Malthustop20wordfreq)[names(Malthustop20wordfreq) == "n"] <- "Frekvens"
MalthusTop20Diagram <- ggplot(Malthustop20wordfreq, 
                            aes(Ord, Frekvens)) + geom_bar(stat = "identity") + ggtitle("Diagram �ver de 20 vanligaste orden i Malthus bok")
MalthusTop20Diagram # Malthus diagram

# Diagram �ver de 20 vanligaste orden i Ricardos bok.
Ricardotop20wordfreq <- Ricardotopwordfreq %>% head(20)
Ricardotop20wordfreq
names(Ricardotop20wordfreq)[names(Ricardotop20wordfreq) == "Ricardo_token_words"] <- "Ord"
names(Ricardotop20wordfreq)[names(Ricardotop20wordfreq) == "n"] <- "Frekvens"
RicardoTop20Diagram <- ggplot(Ricardotop20wordfreq, 
                              aes(Ord, Frekvens)) + geom_bar(stat = "identity") + ggtitle("Diagram �ver de 20 vanligaste orden i Ricardos bok")
RicardoTop20Diagram # Ricardos diagram

# Diagram �ver de 20 vanligaste orden i Marx bok.
Marxtop20wordfreq <- Marxtopwordfreq %>% head(20)
Marxtop20wordfreq
names(Marxtop20wordfreq)[names(Marxtop20wordfreq) == "Marx_token_words"] <- "Ord"
names(Marxtop20wordfreq)[names(Marxtop20wordfreq) == "n"] <- "Frekvens"
MarxTop20Diagram <- ggplot(Marxtop20wordfreq, 
                              aes(Ord, Frekvens)) + geom_bar(stat = "identity") + ggtitle("Diagram �ver de 20 vanligaste orden i Marx bok")
MarxTop20Diagram # Marx diagram

# (Bonus) Diagram �ver de 20 vanligaste orden i alla de fyra b�ckerna.
fourbookstop20wordfreq <- fourbookstopwordfreq %>% head(20)
fourbookstop20wordfreq
names(fourbookstop20wordfreq)[names(fourbookstop20wordfreq) == "fourbooks_token_words"] <- "Ord"
names(fourbookstop20wordfreq)[names(fourbookstop20wordfreq) == "n"] <- "Frekvens"
FourBooksTop20Diagram <- ggplot(fourbookstop20wordfreq, 
                           aes(Ord, Frekvens)) + geom_bar(stat = "identity") + ggtitle("Diagram �ver de 20 vanligaste orden i alla de fyra b�ckerna")
FourBooksTop20Diagram # Alla b�ckers diagram
##### Klart :-) Det var alla!

