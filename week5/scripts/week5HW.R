## week 5 HW: conductivity and depth data
## created by: Kyle Bosworth
## update on 9-30-2024

## load libaries
library(tidyverse)
library(here)
library(lubridate)
library(dplyr)
library(ggplot2)

## load data
CondData<-read_csv(here("week5","data","CondData.csv"))
DepthData<-read_csv(here("week5","data","DepthData.csv"))

#view data
View(CondData)
View(DepthData)

# convert date columns to datetimes and round to nearest 10 sec for both data sets
CondData<-CondData %>%
  mutate(date = mdy_hms(date), 
         date = round_date(date, "10 sec"))
DepthData<-DepthData %>%
  mutate(date = ymd_hms(date),
         date = round_date(date, "10 sec"))

# join data sets together
CondDepthData_inner<-inner_join(CondData, DepthData, by = "date") # using inner_join to keep only the matching data

# viewnewdata
view(CondDepthData_inner)

# convert to ymd_hms format 
CondDepthData_inner<-CondDepthData_inner %>%
  mutate(date = ymd_hms(date),
         minute = floor_date(date, "minute"))

# average out the combined data set, grouped by minute
averaged_data<-CondDepthData_inner %>%
  mutate(minute = floor_date(date, "minute")) %>% 
  group_by(minute) %>%
  summarise(
    Depth = mean(Depth, na.rm = TRUE),
    Temperature = mean(Temperature, na.rm = TRUE),
    Salinity = mean(Salinity, na.rm = TRUE))

# view data again
view(averaged_data)

# make a plot: 
ggplot(averaged_data, aes(x = minute)) +
  geom_line(aes(y = Temperature, color = "Temperature")) +
  geom_line(aes(y = Salinity, color = "Salinity")) +
  geom_line(aes(y = Depth * 10, color = "Depth")) + #had to multiply teh depth to make it visible, x10
  scale_y_continuous(
    name = "Temperature(°C) / Salinity(PSU)",
    sec.axis = sec_axis(~./10, name = "Depth(m)")) +
  scale_color_manual(values = c("Temperature" = "red",
                                "Salinity" = "blue",
                                "Depth" = "green")) +
                                labs(title = "Temperature, Salnity, and Depth Over Time",
                                x = "time",
                                color = "Measurement") +
  theme_minimal() +
  theme(legend.position = "bottom")
