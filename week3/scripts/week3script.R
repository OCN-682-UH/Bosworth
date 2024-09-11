# My first plot 
# 2024-09-10

# load libraries
library(tidyverse)
library(palmerpenguins)

# lok at the data 
view(penguins)
head(penguins)
tail(penguins)
glimpse(penguins)

# make a plot
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, ## "," are used to add on layers
                     y = bill_length_mm,
                     geom_point(size = 2, alpha = 0.5), # manipulating the size of points 2 and 0.5
                     color = species,
                     shape = species, # shape is discrete
                     size = body_mass_g, # size is continuous 
                     alpha = flipper_length_mm)) + ## "+" is used to connect functions 
  geom_point() + 
 # X as a function of Y = (x~y)
  # facet_grid(sex~species) +  #row as a function of columns, a 2D grid 
  facet_wrap(sex ~ species, ncol = 2) + #ncol = make it 2 colomns
  guides(color = FALSE) + # you have more control using facet_wrap
  labs(title = "Bill length and depth",
       subtitle = "My fancy subtitle",
       x = "Bill Depth (mm)",
       y = "Bill Length (mm)",
       color = "Species!",
       shape = "Species!",
       caption = "source: Palmer Penguins package/palmer LTER") +
  scale_color_viridis_d()

