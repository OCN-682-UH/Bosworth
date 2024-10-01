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

# separate tide_time column
chem_data_clean <- chem_data %>%
  drop_na() %>%
  separate(col = Tide_time, 
           into = c("Tide","Time"), 
           sep = "_",
           remove = FALSE)

# filter a subset of data, subset=wailupe
chem_data_filtered <- chem_data_clean %>%
  filter(Site == "W")

view(chem_data_filtered)

#pivot longer
chem_data_long <- chem_data_filtered %>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values") %>%
group_by(Zone, Variables, Values) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Zone,
              values_from = mean_vals) %>%
# save as csv
write_csv(here("outputs","HWbsummary.csv"))  # export as a csv to the right folder
view(chem_data_filtered)
#make a plot!
salNNplot <- ggplot(chem_data_filtered, 
                  aes(x = NO3.NO2, 
                      y = Salinity, 
                      color = Season)) +
  geom_point() +
  labs(title = "NO3.NO2 vs Salinity in Wailupe",
       x = "NO3.NO2 (µmol/L)",
       y = "Salinity (PSU)") +
  theme_minimal()
# save
ggsave(here("outputs", "SALNN_plot.png"), plot = salNNplot, width = 8, height = 6)
