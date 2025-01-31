

###Create a tibble named surveys from the portal_data_joined.csv file.
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
surveys

### Subset surveys using Tidyverse methods to keep rows with weight between 30 and 60, 
###and print out the first 6 rows.

surveys_2 <- surveys %>% filter(weight <60 & weight >30)
head(surveys)
rm(surveys)

### Create a new tibble showing the maximum weight for each species + sex combination 
###and name it biggest_critters. Sort the tibble to take a look at the biggest 
###and smallest species + sex combinations. 
###HINT: it’s easier to calculate max if there are no NAs in the dataframe…

biggest_critters <- select(surveys, species_id, sex, weight) %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex,species_id) %>% 
  summarise(max_weight_g = max(weight)) %>%
  arrange(-max_weight_g)
biggest_critters

### Try to figure out where the NA weights are concentrated in the data- 
###is there a particular species, taxa, plot, or whatever, 
###where there are lots of NA values? 
###There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways 
###to explore this. Maybe use tally and arrange here

summary(surveys)

###Take surveys, remove the rows where weight is NA and 
###add a column that contains the average weight of each species+sex combination 
###to the full surveys dataframe. 
###Then get rid of all the columns except for species, sex, weight, and your new average weight column. 
###Save this tibble as surveys_avg_weight.

surveys_avg_weight <- surveys %>% 
  select(species_id, sex,weight) %>%
  filter(!is.na(weight)) %>% 
  mutate(average_weight = mean(weight))
surveys_avg_weight

###Take surveys_avg_weight and add a new column called above_average that contains 
###logical values stating whether or not a row’s weight is above average for its species+sex combination 
###(recall the new column we made for this tibble).

summary(surveys_avg_weight)
surveys_avg_weight <- surveys_avg_weight %>% 
  select(weight,species_id,sex) %>% 
  filter(weight > 42.67) %>% 
  mutate(above_average = weight > average_weight)

surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight > avg_weight)

surveys_avg_weight
         