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