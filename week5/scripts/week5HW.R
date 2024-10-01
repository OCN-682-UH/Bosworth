## week 5 HW: conductivity and depth data
## created by: Kyle Bosworth
## update on 9-30-2024

## load libaries
library(tidyverse)
library(here)
library(lubridate)

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

# average out the combined data set
averaged_data<-CondDepthData_inner %>%
  mutate(minute = floor_date(date, "minute")) %>%
  group_by(minute) %>%
  summarise(
    Depth = mean(Depth, na.rm = TRUE),
    Temperature = mean(Temperature, na.rm = TRUE),
    Salinity = mean(Salinity, na.rm = TRUE))
# view data again
head(CondDepthData_inner)

# make a plot


