## Week4 dplyr package
## curated by: Kyle Bosworth

## load libraries
library(palmerpenguins)
library(tidyverse)
library(here)

# analysis (looking at the data)
view(penguins)
head(penguins)
tail(penguins)
glimpse(penguins)

filter(.data = penguins,
       
       ## = is asking a question, == is a assign what is in the "ONLY these variables"

       year == "2008 & 2009")
filter(.data = penguins, 
       island != "Dream")
filter(.data = penguins,
       species %in% c("Adelie", "Gentoo"))

## mutate

data2<-mutate(.data = penguins,
              body_mass_kg = body_mass_g/1000,
              bill_length_depth = bill_length_mm/bill_depth_mm)
view(data)

##mutate multiple columns at once: mutate_if(), mutate_at(), mutate_all()

##mutate w/ ifelse, casewhen is for 3 or more

data2<- mutate(.data = penguins,
               after_2008 = ifelse(year>2008, "After 2008", "Before 2008"))
view(data)

data2<- mutate(.data = penguins,
               flipper_length_mass = flipper_length_mm + body_mass_g)
data2<- mutate(.data = penguins,
               greater_4000 = ifelse(body_mass_g>4000, "big boi", "smol boi"))
view(penguins)
view(data)               

penguins %>% # use penguin dataframe
  filter(sex == "female") %>% #select females
  mutate(log_mass = log(body_mass_g)) %>% #calculate log biomass
  select(Species = species, island, sex, log_mass) #You can also use select() to rename columns
penguins %>% #
  group_by(island, sex) %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),
            min_flipper = min(flipper_length_mm, na.rm=TRUE))

## summarise() has grouped output by 'island'. You can override using the
## .groups argument.

penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +
  geom_boxplot()


## Week4b tidyr package HW
## created by: Kyle Bosworth
## 09/24/24
## here() starts at C:/Users/boz/Desktop/Repositories/Bosworth
## load libraries
library(tidyverse)
library(here)
library(ggplot2)

# load in data
chem_data <- read_csv(here("data", "chemicaldata_maunalua.csv"))
data_dict <- read_csv(here("data", "chem_data_dictionary.csv"))

# analysis (looking at the data)
view(chem_data)
head(chem_data)
tail(chem_data)
glimpse(chem_data)

view(data_dict)
head(data_dict)
tail(data_dict)
glimpse(data_dict)

# remove all of NAs
chem_data_clean<-chem_data %>%
  filter(complete.cases(.)) #filters out everything that is not a complete row
View(chem_data_clean)

# separate the Tide_time column
chem_data_clean <- chem_data %>%
  drop_na() %>%
  separate(col = Tide_time, 
           into = c("Tide","Time"), 
           sep = "_",
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values")
group_by(Variables, Site, Time) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE))
pivot_wider(names_from = Variables, 
            values_from = mean_vals) %>% # notice it is now mean_vals as the col name
  write_csv(here("Week_04","output","summary.csv"))  # export as a csv to the right folder
head(chem_data_clean)

chem_data_long <- chem_data_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values")

view(chem_data_long)
chem_data_long %>%
  group_by(Variables, Site) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE)) # get variance
## summarise() has grouped output by 'Variables'. You can override using the
## .groups argument.


### convert data that is in long format to wide format
chem_data_wide<-chem_data_long %>%
  pivot_wider(names_from = Variables,
              values_from = Values)
view(chem_data_wide)




