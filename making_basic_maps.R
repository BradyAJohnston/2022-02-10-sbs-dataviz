library(tidyverse)
library(ozmaps)


oz_states <- ozmaps::ozmap_states

wa <- ozmaps::ozmap_states %>% 
  filter(NAME == "Western Australia")

ggplot(oz_states) + 
  geom_sf()

base_plot <- ggplot(wa) +
# ggplot(wa) + 
  geom_sf() +
  theme_linedraw() + 
  coord_sf(
    # xlim = c(110, 130), 
    crs = sf::st_crs(3112)
    ) + 
  labs(
    title = "Fortess WA"
  ) + 
  theme(
    panel.background = element_rect(fill = "skyblue")
  )


data <- readxl::read_xlsx("data/responses/question1/Kat.fisher.data.vis_Katrina Bornt.xlsx")

base_plot + 
  geom_point(
    data = data, 
    aes(y = xLat, 
        x = rnorm(length(xLat), mean = 112, sd = 0.5), 
        fill = Zones), 
    shape = 21, 
    alpha = 0.7, 
    size = 3
  ) + 
  labs(x = "Lattitude", 
       y = "Longitude") +
  coord_sf(
    xlim = c(110, 118), 
    ylim = c(-35, -25)
  )# -> my_map


ggplot(data, aes(y = port)) + 
  geom_bar(aes(fill = Zones)) + 
  theme_classic() + 
  guides(fill = "none") +
  labs(x = "Count", 
       y = "Port") +
  scale_x_continuous(expand = expansion(mult = c(0, 0.1))) -> barplot

patchwork::wrap_plots(barplot, my_map) + 
  plot_annotation(tag_levels = "a")


patchwork::wrap_plots(barplot, my_map, barplot + theme_linedraw()) + 
  plot_layout(
    design = "
    AAB
    CCC"
  ) + 
  plot_annotation(
    tag_levels = "A"
  )
