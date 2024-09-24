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

# remove all of NAs
chem_data_clean <- chem_data %>% drop_na()

# separate the Tide_time column
chem_data_clean <- chem_data_clean %>%
  separate(Tide_time, into = c("Tide", "Time"), sep = " ")

# convert Time to hms
chem_data_clean <- chem_data_clean %>%
  mutate(Time = hms(Time))

# filter a subset of data, subset=wailupe
chem_data_filtered <- chem_data_clean %>%
  filter(Site == "Wailupe")

# pivot is wider to create separate columns for each nutrients
chem_data_wide <- chem_data_filtered %>%
  pivot_wider(names_from = Nutrient, values_from = Value)

# calculate my summary statistics!
summary_stats <- chem_data_wide %>%
  group_by(Site, Season) %>%
  summarise(across(c(NH4, NO3.NO2, PO4, SiO4), 
                   list(mean = mean, sd = sd), 
                   .names = "{.col}_{.fn}"))

# export summary statistics into CSV
write_csv(summary_stats, here("output", "chemistry_summary_stats.csv"))

# create a plot! =scatterplot of NO3.NO2 vs PO4, colored by seasons
nutrient_plot <- ggplot(chem_data_wide, aes(x = NO3.NO2, y = PO4, color = Season)) +
  geom_point() +
  labs(title = "NO3.NO2 vs PO4 in Wailupe",
       x = "NO3.NO2 (µmol/L)",
       y = "PO4 (µmol/L)") +
  theme_minimal()

# Display the plot
nutrient_plot

# save
ggsave(here("week4", "output", "nutrient_scatter_plot.png"), plot = nutrient_plot, width = 8, height = 6)
