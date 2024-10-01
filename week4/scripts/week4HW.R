## Week4 dplyr package
## curated by: Kyle Bosworth
## currated on 9/17/24

## load libraries
library(palmerpenguins)
library(tidyverse)
library(here)

# analysis (looking at the data)
view(penguins)
head(penguins)
tail(penguins)
glimpse(penguins)


week4HW<- mutate(.data = penguins)
penguins %>%
  group_by(species, island, sex)
  summarise(mean_bodymass = mean(body_mass_g, na.rm=TRUE),
            var_species = var(body_mass_g, na.rm=TRUE))
  penguins %>%
    drop_na(species, island, sex)
view(week4HW)

