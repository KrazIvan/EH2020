# EH2020

## Hemuppgift 1
This lab is based on two data tables:

    hu1_lifeexp.RData – table with the average life expectancy per country.
    hu1_continents.RData – table of which continent each country belongs to.

Solves the following tasks/answers the following questions:
1. Calculates the mean and median life expectancy for the entire collection of countries in the tablen.
2. In which three countries was life expectancy highest and lowest respectively?
3. Makes a bar graph showing the average life expectancy in the five countries that had the highest and lowest average life expectancy.
4. Combines the data tables that contain the average life expectancy with the one that contains information about which continent the countries belong to (with *inner_join()*).
5. Compares the average life expectancy in the world's continents (with *group_by()*).
6. Make a chart to illustrate the difference in life expectancy between the continents.

**Facts about the variables**\
The tables used contain information on 109 countries spread over the world. All data is taken from Our World in Data and is available on their website https://ourworldindata.org/. Data are collected for the latest available year (The code was written in 2020).

    country: land.
    continent: världsdel.
    life_expectancy: förväntad medellivslängd

## Hemuppgift 2
The file contains data per country for the following variables:
1. *country* = The country.
2. *contintent* = The continent to which this country belongs.
3. *child_mort* = Child mortality, per thousand of children < 5 years old.
4. *econ_freedom* = An index of economic freedom.
5. *gdp* = Gross domestic product.
6. *gini* = The gini coefficient of individuals' income, what percentage of this country's income which would have to be redistributed in order for all individuals to have the same income.
7. *hdi* = Human Development Index, from the UN.
8. *health_exp* = Share of this country's healthcare spending that is financed through taxes.
9. *life_expectancy* = Average life expectancy.
10. *women_econ_op* = Index of women's economic opportunities.
\
\
**Sources**: *Ourworlindata.org*, *Världsbanken*, *Fraser Institute*, *GapMinder*.
\
\
**Solves the following**:
1. Retrieves the median and mean for all variables that contain numbers.
2. Creates a histogram for each of the variables that contain numbers, a total of 8.
3. Creates scatter plots for the following variables:

    a. life_expectancy and gdp
    b. life_expectancy and gini
    c. gdp and gini

4. Does the same as in **3**, but adds a straight line, calculated using the least squares method for the charts.
5. Takes the three combinations in **3** and calculate linear regression models for them, along the lines of **y = a + b · x** , where *x* and *y* are variables on which we have data for and *a* and * b* are parameters to be calculated. 
6. Computes a collection of regressions. *life_expectancy* is the dependent variable (*y*) in all regressions.\
    6a. Computes a model for every other variable in the table that contains numbers.

    6b. Presents the results from 6a in a large table.

## Hemuppgift 3
1. Imports the following four books into R:
- Adam Smith, An Inquiry into the Nature and Causes of the Wealth of Nations 
- Thomas Robert Malthus, An Essay on the Principles of Population
- David Ricardo, On the Principles of Political Economy, and Taxation
- Karl Marx, A Contribution to The Critique of the Political Economy

2. Tokenizes the text. Each analysis unit must be one word and only have lowercase letters.
3. Imports a list of stopwords.
4. Clears all data from stop words.
5. Produces a list of the 20 most common words in each book.
6. Illustrates the result from **5** using diagrams.

## Hemuppgift 4

1.	Imports the data table "*regfor_all.rds*" into R.
\
\
*The file contains Sweden's government declarations for every five years between 1980 and 2015. To facilitate the analysis, all numbers from the material have been removed in advance.* 

2.	Calculates how long (number of words) each government statement is. Visualizes the result in a chart.

3.	Does a TF-IDF analysis to see which words were most important for each year. Visualizes the result in a chart.

4.	A number of stop words ("ska" and "skall") have great weight in the TF-IDF analysis. These are removed and then **3** is redone.

5.	Imports a sentiment dictionary and assigns a sentiment score to each word accordingly. Gives all NA observations the value 0. Then creates a graph of how the use of positive and negative words differs between the years 1980-2015.

6.	Which party was the most negative or positive in terms of word choice, if we don't take the year into account? Takes into account that some parties used fewer words in general. This means that the sentiment score must be divided by the number of words per party. Three parties are observed: The Center Party (Fälldin), the Social Democrats (Palme, Carlsson, Persson and Löfven) and the Moderates (Reinfeldt).

