###spreadsheets -----

surveys <- read.csv("data/portal_data_joined.csv")
nrow(surveys)
ncol(surveys)
dim(surveys)
str(surveys)
?str #int: integer, chr: character, str shows the data structure

summary(surveys) #summarizes everything in df

surveys[1,5] #indexing 1st row, 5th column value is 2

surveys[1:5,]
surveys[,1]
dim(surveys[1])

cols_to_grab = c('record_id','year','day')
cols_to_grab
surveys[cols_to_grab]

head(surveys[1:10])

head(surveys["genus"]) #pulling data out of data frame, you get the metadata
head(surveys[["genus"]]) #internal object within, lose metadata

head(surveys['genus',]) #give me any row called genus, but genus is a column, so NA
head(surveys[,'genus'])

surveys$genus
surveys$hindfoot_length #finds data within the column name specified

install.packages('tidyverse')
library(tidyverse)

t_surveys <- read_csv('data/portal_data_joined.csv')
t_surveys
