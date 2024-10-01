## week 5 classwork: Practice date and times with lubridata package
## created by: Kyle Bosworth

## load libraries
library(tidyverse)
library(here)
library(lubridate) #package that deals with date and time

# Even though this may seem silly if you have a clock, it is very helpful if you want to time stamp something in your code.
#what time is it now?
now() #timestamp [1] "2024-09-30 17:14:56 HST"

# you can also ask for time in other time zones
now(tzone = "EST") #eastcoasttime
now(tzone = "GMT")

# if you just want date and not the time, [1] "2024-09-30"
today()
today(tzone = "GMT")

# can ask for morening or night, reg or leap year, true or false
am(now())
pm(now())
leap_year(now())

# Date specifications for libridate
## lubridate does a good job of guessing the format of your date if ou give just a little hint.
## First, ,your date MUST BE A CHARACTER
## common mistake is that you get an error trying to convert a date when it is a factor. Always check to make sure it is a character 9i.e. put quuotes around it).
ymd("2021-02-24")
mdy("02/24/2021")
mdy("February 24 2021")
dmy("24/02/2021")

ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")

# extracting specifit date or time elements from datetimes, Lets make a vector of dates
# make a character string

datetimes<-c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")
# now convert to datetimes
datetimes<-mdy_hms(datetimes)
month(datetimes, label = TRUE, abbr = FALSE) # months and just a number, then to abbr, then spell it out
day(datetimes) #extract day
wday(datetimes, label = TRUE, abbr = FALSE) #extract day of the week

# adding date and times, letʻs add 4 hrs to all datetimes
datetimes + hours(4) #add 4 hrs, [1] "2021-02-25 02:22:20 UTC" "2021-02-25 15:21:10 UTC" "2021-02-26 12:01:52 UTC"
datetimes + days(2) #add 2 days, [1] "2021-02-26 22:22:20 UTC" "2021-02-27 11:21:10 UTC" "2021-02-28 08:01:52 UTC"
round_date(datetimes, "minute") #rounds to nearest min
round_date(datetimes, "5 min") #rounds to nearest 5 min mark



## Challenge CondData.csv and convert the date column to a datetime, use the %>% to keep everything clean.
#This is temperature and salinity data taken at a site with groundwater while being dragged behind a float. Data were collected every 10 seconds. You will also notice depth data. That dataset will be used later during homework. Those data are taken from a pressure sensor, also collected data every 10 seconds.
#Hint: Always look at your data in R after you read it in. Don't trust what the excel format looks like... There may be some seconds hiding, but excel only wants to show you the minutes. Also sometimes excel gets it right and says it's a date and other times it doesn't. Check to see if it's reading in as a character or date already or something totally different (in which case you need to make it a character in R)

#load data
CondData<-read_csv(here("week5","data","CondData.csv"))


# mutate column to datetime format
CondData <- CondData %>%
  mutate(date = mdy_hms(date))

# Round the conductivity data to the nearest 10 seconds so that it matches with the depth data




dictionary<-read_csv(here("week5","data","data_dictionary.csv"))
DepthData<-read_csv(here("week5","data","DepthData.csv"))
ToptData<-read_csv(here("week5","data","Topt_data.csv"))

library(dplyr)
library(lubridate)

## totally awsome R package
library(devtools)
install_github("Gibbsdavidl/CatterPlots") # install the data
library(CatterPlots)
x <-c(1:10)# make up some data
y<-c(1:10)
catplot(xs=x, ys=y, cat=3, catcolor='blue')



