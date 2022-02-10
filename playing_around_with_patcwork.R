library(tidyverse)

ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_jitter(aes(colour = factor(cyl)), size = 3, alpha = 0.6, width = 0.2) + 
  ggpubr::stat_compare_means(
    size = 3,
    comparisons = list(c("4", "6"), 
                       c("4", "8")), 
  ) + 
  theme_classic(base_size = 15) + 
  coord_cartesian(clip = "off") +
  labs(
    x = "Car Cylinders", 
    y = "Miles Per Gallon"
  ) -> mpg_plot


ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) + 
  geom_point(size = 3, alpha = 0.6) + 
  theme_classic(base_size = 15) + 
  labs(x = "Weight", 
       y = "Miles Per Gallon") -> weight_plot

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


patchwork::wrap_plots(weight_plot, mpg_plot, mpg_plot, base_plot, weight_plot + geom_line()) + 
  plot_layout(guides = "collect") + 
  plot_annotation(
    tag_levels = "a", 
    tag_suffix = ")", 
    tag_prefix = "("
  ) + 
  plot_layout(
    design = "
    AB#
    AB#
    CDD
    #DD
    EEE"
  ) -> assembled_plot


ggsave("patchwork_example.pdf", assembled_plot, width = 8, height = 12)
