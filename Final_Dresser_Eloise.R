tyler_activity_laps <- read_csv("https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv")

only_running <- filter(tyler_activity_laps, sport == "running", minutes_per_mile < 10 & minutes_per_mile > 5)
only_running

#create 3 new columns showing pre-2024, January to June 2024, and then July to December

summary(only_running$timestamp)

grouped_obs <- only_running %>%
  mutate(Jan_to_June = case_when(year == 2024 & month %in% 1:6 ~ "Jan_to_June"), 
        Jul_to_Dec = case_when(year == 2024 & month %in% 7:12 ~ "Jul_to_Dec",
                         TRUE ~ "Pre_2024"))
#not right

mycols <- only_running %>% 
  mutate(Jan_to_June = select(year=2024 & month %in% 1:6),
         Jul_to_Dec = select(year=2024 & month %in% 7:12),
         Pre_2024 = select(year <= 2023))
mycols  
# not right

only_running <- only_running %>% 
  mutate(
    Running_Category = case_when(
    year == 2024 & month %in% 1:6 ~ "Jan_to_June",
    year == 2024 & month %in% 7:12 ~ "July_to_Dec",
    year < 2024 ~ "Pre_2024",
    TRUE ~ "Uncategorized"
  ))
str(only_running)

only_running <- only_running %>% 
  mutate(speed_by_lap = total_distance_m/minutes_per_mile)
only_running$speed_by_lap

only_running %>% ggplot(aes(x=speed_by_lap, y=minutes_per_mile, color = Running_Category)) + 
  xlab("Speed by Lap") +
  ylab("Minutes per Mile")+
  geom_smooth()+
  theme_bw()