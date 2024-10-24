library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
surveys

###create table in new tab -----

view(surveys)

###create table with column names ----

str(surveys)
### spc_tbl_ [34,786 × 13] rows X columns

###select columns variable <- select(data frame first, columns you want)

month_day_year<- select(surveys, month, day, year)
month_day_year

###filter for certain years ----

year_1981<- filter(surveys, year == 1981)
year_1981
#why is this not a (row,column) situation? Brackets are needed for that. R recognizes
#that year (not in quotes, that would make it a chr string) is a column.

###filtering by range ---------

filter(surveys, year %in% 1981:1983)
#checks if years are in any of the rows

###filter recycle ------
the80srecycle <-filter(surveys, year == c(1981:1983))
nrow(the80srecycle)
###question: why is this bad -------

###filtering by multiple conditions----
bigfoot_with_weight <- filter(surveys, hindfoot_length > 40 & is.na(weight))
bigfoot_with_weight
?is.na

###multi-step process ---
small_animals <- filter(surveys, weight <5)
small_animals
#this is slightly dangerous, bc you have to remember to select
#from small_animals, not surveys in the next step
###question: why is this bad -------

small_animal_ids <-select(small_animals, record_id, plot_id, species_id)
small_animal_ids

#same process, using nested functions
small_animal_ids <- select(filter(surveys, weight <5), record_id, plot_id, species_id)
small_animal_ids
# R knows that record_id, plot_id, species_id are columns.
# R works from the inside out of parentheses (order of operations)

###piping
#ctrl shift M
#or |>, operates from left to right
small_animal_ids<- filter(surveys, weight >5) %>% select(record_id, plot_id, species_id)

#same as
small_animal_ids <- surveys %>% filter(weight < 5) %>% select(record_id, plot_id, species_id)
small_animal_ids
###question: what ------

### you can break up these long lines ----
surveys %>% 
  filter(month ==1)

###one last review
mini<-surveys[190:209,]
table(mini$species_id)
nrow(mini)

#how many rows have a species ID that's either DM or NL?
test <- mini %>% filter(species_id %in% c("DM","NL"))
test
--------------------------------------------------------------------------------

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
surveys

###mutate, when you want to create a new column of data
###create new column with weight in kg
surveys <- surveys %>% 
  mutate(weight_kg = weight/1000)
str(surveys) #remember: str shows the structure of df
#you should be able to see weight_kg at the bottoms of str(surveys)


# Data Manipulation Part 1b ----
# Goals: learn about mutate, group_by, and summarize
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)


# Adding a new column
# mutate: adds a new column
###mutate, when you want to create a new column of data
###create new column with weight in kg

surveys <- surveys %>% 
  mutate(weight_kg = weight/1000)
str(surveys) 

#remember: str shows the structure of df
#you should be able to see weight_kg at the bottom of str(surveys)

# Add other columns
surveys <- surveys %>% 
  mutate(weight_kg = weight/1000,
         weight_kg2 = weight*2)
str(surveys)
#you should be able to see weight_kg and weight_kg2 at the bottom of str(surveys)


# Filter out the NA's (in weight, located in surveys)
#create average weight called mean_weight
ave_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(mean_weight = mean(weight))
str(ave_weight)
ave_weight
#mean_weight is the average of all weights, so it will be the same number recycled


# Group_by and summarize ----
# A lot of data manipulation requires us to split the data into groups, 
#apply some analysis to each group, and then combine the results
# group_by and summarize functions are often used together to do this
# group_by works for columns with categorical variables 
# we can calculate mean by certain groups
surveys %>%
  group_by(sex) %>%
  mutate(mean_weight = mean(weight, na.rm = TRUE)) 

table(df$mean_weight)


surveys %>%
  group_by(sex) %>%
  summarise(mean_weight = mean(weight, na.rm = TRUE)) 

# multiple groups
df <- surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))
view(df)

# remove na's


# sort/arrange order a certain way
df <- surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  arrange(-mean_weight)
df

### Challenge ----
#What was the weight of the heaviest animal measured in each year? 
#Return a table with three columns: year, weight of the heaviest animal in grams, 
#and weight in kilograms, arranged (arrange()) in descending order, 
#from heaviest to lightest. (This table should have 26 rows, one for each year)

heaviest_animal <- select(surveys, year, weight) %>% 
  filter(!is.na(weight))
heaviest_animal
str(heaviest_animal)
heaviest_animal 

heaviest_animal <- heaviest_animal %>%
  mutate(weight_kg = weight/1000)
str(heaviest_animal)

heaviest_animal <- heaviest_animal %>%
  group_by(year, weight) %>% 
  summarize(heaviest_per_year = (year, weight)) %>% 
  arrange(-weight,year)

heaviest_animal

surveys %>% filter(!is.na(weight)) %>%
  group_by(year) %>%
  summarize(max_weight_g = max(weight)) %>% 
  mutate(max_weight_kg = max_weight_g/1000) %>% 
  arrange(max_weight_g)

#####ask about filter vs surveys 

#Try out a new function, count(). 
#Group the data by sex and pipe the grouped data into the count() function. 
#How could you get the same result using group_by() and summarize()? Hint: see ?n.
