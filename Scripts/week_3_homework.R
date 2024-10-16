library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
surveys

### Create a new data frame called surveys_base with only the species_id, the weight
###and the plot_type columns
#

surveys_base <- surveys[,c("species_id","weight","plot_type")]
surveys_base
str(surveys_base)

### Have this data frame only be the first 5,000 rows ----
surveys_base <- surveys_base[c(1:5000),]

### Convert both species_id and plot_type to factors

?factor
surveys_base$species_id <- factor(surveys_base$species_id)
head(surveys_base$species_id)                         

surveys_base$plot_type <- factor(surveys_base$plot_type)
head(surveys_base$plot_type)
#here we need to take the cols species id and plot type out of surveys_base ($)
#we also need to factor the two columns

###Remove all rows where there is an NA in the weight column.---- 
#Explore these variables and try to explain why a factor is different from a character.

surveys_base$weight
?complete.cases
surveys_base <- surveys_base[complete.cases(surveys_base),]
surveys_base
#complete.cases = no na's
#remember: brackets tell R where to find data. So in surveys_base,
#we are looking for complete cases (which is a function, so it's in parentheses)

###CHALLENGE: Create a second data frame called challenge_base 
#that only consists of individuals from your surveys_base data frame with 
#weights greater than 150g.

str(surveys_base)
surveys_base$weight
head(surveys_base$weight)
challenge_base <- surveys_base[surveys_base[, 2]>150,]
challenge_base
#remember [rows, columns]
#so within surveys_base we know that weight is column 2, so within surveys_base
#we select col 2 within the row: [, 2] 
#AND we select within col 2 is where the row value is greater than 150: >150,]