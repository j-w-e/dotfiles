library(tidyverse)
data("midwest", package = "ggplot2")

midwest$per

# \rf               " Connect to R console.
# \rq               " Quit R console.
# \ro               " Open object bowser.
# \d \ss \aa        " Execution modes.
# ?help
# ,nn               " NERDTree.
# ,nt, tp, tn       " Tab navigation.

theme_set(theme_bw())

gg  <- ggplot(midwest, aes(x=area, y = poptotal)) +
        geom_point(aes(col = state, size = popdensity)) +
        geom_smooth(method = "loess", se = F) +
        xlim(c(0, 0.1)) +
        ylim(c(0, 500000)) +
        labs(subtitle = "Area Vs Population",
             y = "Population",
             x = "Area",
             title = "Scatterplot",
             caption = "Source: midwest")

plot(gg) # Opens an external window with the plot.

midwest$county # To show synchronous auto completion.

View(midwest) # Opens an external window to display a portion of the tibble.
