```{r, echo=FALSE}
library(flipbookr)
```

```{r test-plot, fig.height=5, include=FALSE}
library(patchwork)
library(ggplot2)

ggplot(mtcars, aes(mpg, wt, colour = factor(cyl))) + 
  geom_point() + 
  theme_classic() + 
  labs(title = "Some title goes here") + 
  labs(
    x = "Miles per Gallon", 
    y = "Weight (kg)"
  ) -> p1

ggplot(mtcars, aes(cyl, fill = factor(cyl))) + 
  geom_bar() + 
  theme_classic() + 
  labs(title = "A title here as well") + 
  labs(x = "Engine Cylinders") -> p2

wrap_plots(p1, p2) + 
  plot_layout(guides = "collect") + 
  plot_annotation(
    tag_levels = "A", 
    tag_suffix = ")"
  )

```

---
  
  `r chunk_reveal(chunk_name = "test-plot", title = "### First flipbook!")`

```{r patchwork2, include=FALSE, fig.height=5}
wrap_plots(p1, p2) + 
  plot_layout(guides = "collect") + 
  plot_layout(ncol = 3) +
  plot_layout(ncol = 1)
```

---
  
  `r chunk_reveal(chunk_name = "patchwork2", title = "### First flipbook!")`