###MIDTERM -----
library(tidyverse)
tyler_activity_laps <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")
str(tyler_activity_laps)
head(tyler_activity_laps)
summarize(tyler_activity_laps$sport)

only_running <- filter(tyler_activity_laps, sport == "running", minutes_per_mile < 10 & minutes_per_mile > 5)
only_running

summary(only_running$minutes_per_mile)


surveys$weight_cat <- ifelse(surveys$weight_cat < 20, yes = "small", no = "big")
head(surveys$hindfoot_cat)

only_running$pace_cat <- ifelse(only_running$minutes_per_mile < 6, yes = "fast", no = "slow")
head(only_running$pace_cat)

only_running %>% mutate(pace_cat = ifelse(
  minutes_per_mile < 6.00, "fast",
  ifelse(minutes_per_mile > 6.00 & minutes_per_mile < 8.00,"medium", "slow")))
--------------------------------------------------------------------------------
only_running$form <- ifelse(only_running$year < 2024, yes = "old", no = "new")
head(only_running$form)

only_running %>% select(form, pace_cat, steps_per_minute) %>% 
  mutate(avg_steps_per_min = mean(steps_per_minute))


