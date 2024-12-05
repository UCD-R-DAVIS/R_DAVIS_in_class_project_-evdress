###Week 8 Homework ----

mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

# sample locations will be in Hawaii time zone (UTC)
#missing data is encoded as -9, -999.9, -999.90, -9
#filter out missing data first

glimpse(mloa)
mloa2 <- mloa %>% 
  filter(rel_humid != -99) %>% 
  filter(temp_C_2m != -999.9) %>% 
  filter(windSpeed_m_s != -999.9)

glimpse(mloa2)
# need to combine dates and times now
#time zone is UTC
library(tidyverse)
library(lubridate)
library(dplyr)
library(readr)
#create date time column and then convert it to local time
?with_tz # with_tz(time, tzone = "", ...)

mutate(datetime = ymd_hm(paste0(year,"-", 
                                month, "-", 
                                day," ", 
                                hour ":", 
                                min), 
                         tz = "UTC")) %>%
  mutate(datetimelocal = with_tz (datetime, tz = "Pacific/Honolulu"))
#WHY ISNT THIS WORKING
mutate(datetime = ymd_hm(paste0(year,"-", 
                                month, "-", 
                                day," ", 
                                hour24,":", 
                                min), 
                         tz = "UTC")) %>%
  # Convert to local time
  mutate(datetimeLocal = with_tz(datetime, tz = "Pacific/Honolulu"))
mloa2 = mloa %>%
  # Remove NA's
  filter(rel_humid != -99) %>%
  filter(temp_C_2m != -999.9) %>%
  filter(windSpeed_m_s != -999.9) %>%
  # Create datetime column (README indicates time is in UTC)
  mutate(datetime = ymd_hm(paste0(year,"-", 
                                  month, "-", 
                                  day," ", 
                                  hour24, ":", 
                                  min), 
                           tz = "UTC")) %>%
  # Convert to local time
  mutate(datetimeLocal = with_tz(datetime, tz = "Pacific/Honolulu"))

glimpse(mloa2) #well now its there makes no sense

?month
#calculate (create new columns) of mean hourly temperature of each month using the temp and datetimeLocal using month and hour functions
#create local month and local hour columns first

mloa2 %>% 
  mutate(localmonth = month(datetimeLocal, label= TRUE)) %>% 
  mutate(localhour = hour(datetimeLocal)) %>% 
  group_by(localmonth, localhour) %>% 
  summarize(mean_monthly_temp = mean(temp_C_2m)) %>% 
  ggplot(aes(x=localmonth, y=mean_monthly_temp, color=localhour)) + 
  xlab("Month") +
  ylab("Mean temperature (degrees C)") +
  geom_point()+
  theme_bw()