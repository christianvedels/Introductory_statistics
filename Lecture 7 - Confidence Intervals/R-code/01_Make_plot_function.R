library(shiny)
library(tidyverse)

# Define density functions
d1 = function(x) { # Two normals
  mu1 = -1    # Mean of first normal distribution
  sigma1 = 2  # Standard deviation of first normal distribution
  
  mu2 = 3     # Mean of second normal distribution
  sigma2 = 1  # Standard deviation of second normal distribution
  
  res = dnorm(x, mu1, sigma1) + dnorm(x, mu2, sigma2)
  return(res / 2)
}

d2 = function(x){ # Uniform
  lower = -5
  upper = 5
  dunif(x, lower, upper)
}

d3 = function(x){ # Standard normal
  res = dnorm(x, 0, 1)
  return(res)
}

galton_d = function(x){
  res = dnorm(x, 175.8, 6.3)
}

# Define the plotting function with cumulative option, Inf snapping, and updated subtitle
make_plot = function(a = -1, b = 2, d = d1, label_offset1 = -0.01, label_offset2 = 0, 
                     text_zoom = 1, domain = c(-10, 10), cumulative = FALSE){
  
  # Snap a and b to the domain if they are infinite
  if(is.infinite(a) && a < 0) a = domain[1]
  if(is.infinite(b) && b > 0) b = domain[2]
  
  # If cumulative is TRUE, create a cumulative version of the function 'd'
  if(cumulative){
    d_cum = function(x){
      sapply(x, function(z) integrate(d, lower = domain[1], upper = z)$value)
    }
    plot_fun = d_cum
    subtitle_text = paste("Cumulative distribution: increase in probability from", a, "to", b)
  } else {
    plot_fun = d
    subtitle_text = paste("Density function: area under curve from", a, "to", b)
  }
  
  # Compute the "area" under the curve (or the increase in cumulative probability) between a and b
  area_value = if(cumulative){
    plot_fun(b) - plot_fun(a)
  } else {
    integrate(d, lower = a, upper = b)$value
  }
  
  # Create a sequence for shading the area between a and b
  shade_data = tibble(x = seq(a, b, length.out = 200)) %>%
    mutate(y = plot_fun(x))
  
  # Create the plot using stat_function and add the shaded area with annotations
  p1 = ggplot(data.frame(x = domain), aes(x = x)) +
    stat_function(fun = plot_fun, size = 1.2) +
    geom_area(data = shade_data, aes(x = x, y = y), fill = "blue", alpha = 0.3) +
    geom_segment(aes(x = a, xend = a, y = 0, yend = plot_fun(a)), 
                 linetype = "dashed") +
    geom_segment(aes(x = b, xend = b, y = 0, yend = plot_fun(b)), 
                 linetype = "dashed") +
    annotate("text", x = a, y = label_offset1, label = "a", 
             vjust = -0.5, size = 5) +
    annotate("text", x = b, y = label_offset1, label = "b", 
             vjust = -0.5, size = 5) +
    annotate("text", x = (a + b) / 2, y = min(c(plot_fun(a), plot_fun(b)))*0.5 + label_offset2,
             label = paste("Area =", round(area_value, 3)), 
             size = 3*text_zoom, color = "blue") +
    labs(
      subtitle = subtitle_text,
      x = "x",
      y = if(cumulative) "Cumulative Probability" else "Density"
    ) +
    theme_minimal() + 
    scale_y_continuous(breaks = NULL)
  
  return(p1)
}

