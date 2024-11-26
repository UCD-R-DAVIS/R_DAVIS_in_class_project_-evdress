library(tidyverse)
library(ggplot2)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")
gapminder

###1.To get the population difference between 2002 and 2007 for each country, it would probably be ###easiest to have a country in each row and a column for 2002 population and a column for 2007 ###population ------------

#Things (columns) we need to manipulate (select) for this first question to find the pop diff btwn 2002 and 2007: population, continent, year, and country

pg <- gapminder %>% select(pop,continent,year,country) %>% #cols selected
  filter(year > 2000) %>% #data from rows selected
  pivot_wider(names_from = year, values_from = pop) %>%  #??????
  mutate(pop_change_0207 = `2007` - `2002`) #creating pop diff column
pg

###2. Notice the order of countries within each facet. You’ll have to look up how to order them in this way.------
?reorder

###3.Also look at how the axes are different for each facet. Try looking through ?facet_wrap to see if you can figure this one out -------
?facet_wrap

unique(gapminder$continent)
###My try:
pg %>% filter(continent != "Oceania") %>% #removing rows where the continent is Oceania
 ggplot(aes(x=reorder(country, pop_change_0207), y=pop_change_0207))+ #reorders
  geom_boxplot() + theme_classic() + 
  xlab("Country") + ylab("Population Change from 2002 to 2007")
?geom_col

pg %>% filter(continent != "Oceania") %>% #removing rows where the continent is Oceania
  ggplot(aes(x=reorder(country, pop_change_0207), y=pop_change_0207))+ #reorders
  geom_col() + theme_bw() +
  facet_wrap(~continent, scales = "free")+
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") +
  xlab("Country") + ylab("Population Change from 2002 to 2007")

?axis.text.x
