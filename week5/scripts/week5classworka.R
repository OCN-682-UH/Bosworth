## week 5 classwork: Practice joins with data from Becker and Silbiger (2020) ##
## created by: Kyle Bosworth

## load libraries
library(tidyverse)
library(here) 

## load data
# Environemnetal data from each site
EnviroData<-read_csv(here("week5","data", "site.characteristics.data.csv"))
#Thermal performance data
TCPData<-read_csv(here("week5","data","Topt_data.csv"))

glimpse(EnviroData)
glimpse(TCPData)

EnviroData_wide<-EnviroData %>%
  pivot_wider(names_from = parameter.measured, # used to pivot the data wider
              values_from = values)
view(EnviroData_wide) # arranged the data frame now by site

# left_join(x,y) is used to merge two data frames into one
# you need a key that is identical in both data frames for it to work ( spelling, capitalization, everything)
## we will use site.letter 
#### there is no missing data in this ex. but if there was an extra site in one data frame, it would be excluded from the new data frame

FullData_left<-left_join(TCPData, EnviroData_wide)

## Joining with by = join_by(site.letter)
head(FullData_left)

### What is a tibble? 
#### A data frame but simpler. It is what the tidyverse uses as a data frame.
## use tibble() to create one
#Make 1 tible

T1<-tibble(site.ID = c("A","B","C","D"),
          Temperature = c(14.1, 16.7, 15.3, 12.8))
T2<-tibble(site.ID = c("A","B","D","E"),
           pH = c(7.3, 7.8, 8.1, 7.9))


## left vs right _joins
### the only difference, is which dataframe is being used as the base

left_join(T1, T2)
right_join(T1, T2)

### inner_join vs full_join
##Inner join only keeps the data that is complete in both data sets
##Full join keeps everything

inner_join(T1, T2)
full_join(T1, T2)

### semi_join vs anti_join
##Semi join keeps all rows from the first data set where there are matching values in the second data set, keeping just columns from the first data set
##Anti join saves all the rows in the first data set that do not match anything in the second data set. This can help you fid possibe missing data across large data sets.

semi_join(T1, T2)
anti_join(T1, T2)

### Install package: "cowsay"
install.packages("cowsay")
library(cowsay)
say("hello", by = "shark")
say("i want pets", by = "cat")


