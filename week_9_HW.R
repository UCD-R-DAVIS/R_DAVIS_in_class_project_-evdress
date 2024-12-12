#week 9 homework
library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")

str(surveys)
#Using a for loop, print to the console the longest species name of each taxon. Hint: the function nchar() gets you the number of characters in a string.

for (i in seq_along(surveys$species)) {
  results[i] <- surveys$species[i](nchar(surveys$species))
}
results #not correct

for(i in unique(surveys$taxa)){
  mytaxon <- surveys[surveys$taxa == i,]
  longestnames <- mytaxon[nchar(mytaxon$species) == max(nchar(mytaxon$species)),] %>% select(species)
  print(paste0("The longest species name(s) among ", i, "s is/are: "))
  print(unique(longestnames$species))
}

mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

#Use the map function from purrr to print the max of each of the following columns: “windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,“temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”.

glimpse(mloa)
mloa
mloa <- map(max(“windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,“temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”)) #not correct, select columns first

mycols <- mloa %>% select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr")
mycols %>% map(max, na.rm = T) #don't forget to remove NAs

#Make a function called C_to_F that converts Celsius to Fahrenheit. Hint: first you need to multiply the Celsius temperature by 1.8, then add 32. Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”. Bonus: can you do this by using map_df? Don’t forget to name your new columns “temp_F…” and not “temp_C…”!

C_to_F <- function(tempC){
  tempF <- (tempC * 1.8 + 32)
  return(tempF)
}
#temp_C_2m = 66.02
C_to_F(tempC=18.9)
#temp_C_10m = 62.42
C_to_F(tempC=16.9)
#temp_C_towertop = 61.16
C_to_F(tempC=16.2)

mycols2 <- mycols %>% 
  mutate(temp_F_2m = C_to_F(tempC=18.9), 
         temp_F_10m = C_to_F(tempC=16.9),
         temp_F_towertop = C_to_F(tempC=16.2))
glimpse(mycols2)

#is my code different? YES
C_to_F <- function(x){
  x * 1.8 + 32
}
#correct code. in order to apply the function to the entire row, you need to do df$column.
#in my code, you only did it to the max values
mloa$temp_F_2m <- C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m <- C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop <- C_to_F(mloa$temp_C_towertop)
glimpse(mloa)