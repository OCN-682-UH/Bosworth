# My first plot
# Created by Kyle Bosworth
# 2024-09-10
#Week3
## here() starts at C:/Users/boz/Desktop/Repositories/Bosworth
# load libraries
library(tidyverse)
library(palmerpenguins)
library(here)

# looking at the data 
view(penguins)
head(penguins)
tail(penguins)
glimpse(penguins)

# make a plot
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, ## aes = aesthetics, ## "," are used to add on layers
                     y = bill_length_mm,
                     color = island,
                     shape = island)) + # shape is discrete, # size is continuous ## "+" is used to connect functions 
  geom_point(size = 1, alpha = 0.5) + # geom_xx = geometry, # manipulating the size of point
  geom_violin() + 
  facet_wrap(island ~ species, ncol = 2) +  
# X as a function of Y = (x~y)
# facet_grid(x ~ y) +  #row as a function of columns, a 2D grid 
# ncol = make it "n" columns 
# you have more control using facet_wrap
  labs(title = "Bill Length vs Bill Depth by Island and Species",
       subtitle = "Palmer Penguins Dataset",
       x = "Bill Depth (mm)",
       y = "Bill Length (mm)",
       color = "Island",
       shape = "Island",
       caption = "Source: Palmer Penguins package/Palmer LTER") +
  scale_color_viridis_d() +
  theme(legend.position = "bottom",  # legend. position to move legend to bottom
        plot.title = element_text(hjust = 0.5),  # plot title center
        plot.subtitle = element_text(hjust = 0.5))  # plot subtitle center
ggsave(here("week3","outputs", "week3plot.png"))
