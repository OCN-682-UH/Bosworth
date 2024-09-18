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



