library(tidyverse)
library(fishualize)


fish_selections <- fishualize::fishapes()[1:6, 2]

random_data <- function(x) {
  set.seed(x)
  data.frame(
    x = rnorm(30, 50, 3), 
    y = rnorm(30, -30, 3), 
    size = rnorm(30, 5, 1.5)
  )
}

tibble(
  fish = fish_selections, 
  num = 1:6
) %>%
  mutate(
    data = purrr::map(num, random_data), 
    plot = purrr::map2(data, num, function(data, num) {
      data %>% 
        ggplot(aes(x = x, y = y)) + 
        geom_point(size = size) + 
        theme_linedraw() + 
        fishualize::add_fishape(
          xlim = c(min(data$x), max(data$x)), 
          ylim = c(min(data$y), max(data$y)),
          family = fishualize::fishapes()[num, 1], 
          option = fishualize::fishapes()[num, 2], 
          xmin = 0.01,
          xmax = 0.3,
          ymin = 0.7, 
          ymax = 0.99,
          alpha = 0.4,
          scaled = TRUE
          ) + 
        labs(
          title = fishualize::fishapes()[num, 2]
        )
        
    })
  ) -> df


patchwork::wrap_plots(df$plot)
