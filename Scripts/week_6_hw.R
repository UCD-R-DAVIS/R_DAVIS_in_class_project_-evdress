library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")
gapminder


###mine---- 1.First calculate mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent.
gapminder %>% 
  mutate(avg_life_expect = (mean(lifeExp))) %>% 
  ggplot(data = gapminder, mapping = aes(x=year, y=avg_life_expect)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
  
####answer-----------WHY SUMMARIZE AND NOT MUTATE???
gapminder %>%
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% #calculating the mean life expectancy for each continent and year 
  ggplot()+
  geom_point(aes(x = year, y = mean_lifeExp, color = continent))+ #scatter plot
  geom_line(aes(x = year, y = mean_lifeExp, color = continent)) #line plot

###Look at the following code and answer the following questions. What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code? ----------

####Challenge! Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot? --------

#challenge answer
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

###Create a boxplot that shows the life expectancy for Brazil, China, El Salvador, Niger, and the United States, with the data ###points in the background using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot ###“Life Expectancy of Five Countries”. --------

###create vector for list of countries - why not select???
countries <- c("Brazil", "China", "El Salvador", "Niger", "United States")

gapminder %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(x = country, y = lifeExp)) +
  geom_boxplot() +
  geom_jitter(alpha =0.3, color = "blue")+
  theme_minimal() +
  ggtitle("Life Expectancy of Five Countries") + #Fig title
  theme(plot.title = element_text(hjust = 0.5)) + #centered the plot title
  xlab("Country") + ylab("Life Expectancy") #how to change axis names
