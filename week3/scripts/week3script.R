# My first plot
# Created by Kyle Bosworth
# 2024-09-10
#Week3

# load libraries
library(tidyverse)
library(palmerpenguins)

# looking at the data 
view(penguins)
head(penguins)
tail(penguins)
glimpse(penguins)

# make a plot
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, ## "," are used to add on layers
                     y = bill_depth_mm,
                     geom_point(size = 1, alpha = 0.25), # manipulating the size of point
                     color = island,
                     shape = island, # shape is discrete
                     size = body_mass_g)) +  # size is continuous ## "+" is used to connect functions 
  geom_point() + 
 # X as a function of Y = (x~y)
  # facet_grid(island ~ species) +  #row as a function of columns, a 2D grid 
  facet_wrap(island ~ species, ncol = 2) + #ncol = make it "n" columns
  guides(color = FALSE) + # you have more control using facet_wrap
  labs(title = "Bill length x Bill depth per island",
       subtitle = "Woah!",
       x = "Bill Depth (mm)",
       y = "Bill Length (mm)",
       color = "penguin tuxedo style",
       shape = "penguin tuxedo style",
       caption = "source: Palmer Penguins package/palmer LTER") +
  scale_color_viridis_d()
