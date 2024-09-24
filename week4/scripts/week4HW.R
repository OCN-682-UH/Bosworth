## Week4 dplyr package HW
## created by: Kyle Bosworth
## 09/24/24
## here() starts at C:/Users/boz/Desktop/Repositories/Bosworth
## load libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggplot2)

# analysis (looking at the data)
view(penguins)
head(penguins)
tail(penguins)
glimpse(penguins)

penguins_clean <- penguins %>%
  drop_na(species, island, sex)
# summary of the cleaned dataset
summary(penguins_clean)
# view cleaned dataset w/out NAs
head(penguins_clean)
# calculate mean and variance of BODYmass by island, species, and sex
body_mass_stats <- penguins_clean %>%
  group_by(island, species, sex) %>%
  summarize(
    mean_BODYmass = mean(body_mass_g),
    var_BODYmass = var(body_mass_g),
    .groups = "drop")
# view stats table results
print(body_mass_stats)

# filter male penguinz and calculate stats with log body mass and selected columns
penguins_clean_female <- penguins %>%
  drop_na(species, island, sex, body_mass_g) %>%
  filter(sex == "female") %>%
  mutate(log_body_mass = log(body_mass_g)) %>%
  select(species, island, sex, log_body_mass)
# create the plot!
penguinplot1<-ggplot(data=penguins_clean_female,
                     mapping = aes(x = species, 
                                   y = log_body_mass, 
                                   color = island)) +
                     geom_point(position = position_jitter(width = 0.2), size = 2, alpha = 0.7) +  # Jittered points for individual data
  geom_point()+
  geom_smooth(method = "lm") +
    labs(title = "Log Body Mass of Female Penguins",
         subtitle = "By Species and Island",
         x = "Species",
         y = "Log Body Mass",
         color = "Island") +
    scale_color_brewer(palette = "Set2") +  # Color palette for islands
    theme_minimal() + theme(
      axis.text.x = element_text(angle = 45, 
                                 hjust = 1),  # Rotate x-axis labels for better readability
      legend.position = "bottom",  # Position the legend at the bottom
      plot.title = element_text(hjust = 0.5),  # Center the title
      plot.subtitle = element_text(hjust = 0.5))  # Center the subtitle
#save to outputs folder!

ggsave(filename = here("outputs","female_penguins.png"), 
       plot = point_plot, 
       width = 10, height = 6)

