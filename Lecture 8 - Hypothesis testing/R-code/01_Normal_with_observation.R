library(tidyverse)

plot_distribution_with_obs = function(obs, mu = 0, sigma = 1, num_sd = 2, domain = c(-5, 5),
                                      label_offset1 = -0.03, label_offset2 = 0, text_zoom = 1,
                                      area_label_offset = 0.25) {
  # Compute the lower and upper limits based on the chosen number of standard deviations
  lower = mu - num_sd * sigma
  upper = mu + num_sd * sigma
  
  lower_obs = mu - abs(obs)
  upper_obs = mu + abs(obs)
  
  # Calculate the area under the curve between outside 'obs' on both sides
  area_value = (1 - pnorm(obs, mean = mu, sd = sigma))*2
  
  # Generate a sequence of x-values over the chosen domain and compute corresponding density values
  x_seq = seq(domain[1], domain[2], length.out = 300)
  y_vals = dnorm(x_seq, mean = mu, sd = sigma)
  
  # Prepare data for the shaded area between lower and upper limits
  shade_data1 = tibble(x = seq(domain[1], lower_obs, length.out = 200)) %>%
    mutate(y = dnorm(x, mean = mu, sd = sigma))
  shade_data2 = tibble(x = seq(domain[2], upper_obs, length.out = 200)) %>%
    mutate(y = dnorm(x, mean = mu, sd = sigma))
  
  centroid_left = integrate(function(x)
    x * dnorm(x, mean = mu, sd = sigma),
    lower = domain[1],
    upper = lower_obs)$value /
    integrate(function(x)
      dnorm(x, mean = mu, sd = sigma),
      lower = domain[1],
      upper = lower_obs)$value
  
  centroid_right = integrate(function(x)
    x * dnorm(x, mean = mu, sd = sigma),
    lower = upper_obs,
    upper = domain[2])$value /
    integrate(function(x)
      dnorm(x, mean = mu, sd = sigma),
      lower = upper_obs,
      upper = domain[2])$value
  
  # Create the base plot using ggplot2
  p = ggplot(data.frame(x = x_seq, y = y_vals), aes(x = x, y = y)) +
    geom_line(size = 1.2) +
    geom_area(data = shade_data1, aes(x = x, y = y), fill = "blue", alpha = 0.3) +
    geom_area(data = shade_data2, aes(x = x, y = y), fill = "blue", alpha = 0.3) +
    geom_segment(aes(x = lower_obs, xend = lower_obs, y = 0, yend = dnorm(lower_obs, mean = mu, sd = sigma)), 
                 linetype = "dashed") +
    geom_segment(aes(x = upper_obs, xend = upper_obs, y = 0, yend = dnorm(upper_obs, mean = mu, sd = sigma)), 
                 linetype = "dashed") +
    annotate("text", x = lower, y = label_offset1, 
             label = paste0("-", abs(obs)/sigma, "SE\n(", round(-abs(obs), 3), ")"), 
             vjust = -0.5, size = 3 * text_zoom) +
    annotate("text", x = upper, y = label_offset1, 
             label = paste0("+", abs(obs)/sigma, "SE\n(", round(abs(obs), 3), ")"), 
             vjust = -0.5, size = 3 * text_zoom) +
    # Calculate the y coordinate for the "Area =" annotation text
    annotate("text", 
             x = (lower_obs + upper_obs) / 2  + area_label_offset, 
             y = -min(c(dnorm(lower, mean = mu, sd = sigma), 
                        dnorm(upper, mean = mu, sd = sigma))) * 0.5 + label_offset2,
             label = paste("Area =", round(area_value, 3)), 
             size = 3 * text_zoom, color = "blue") +
    # Add arrow segments from the "Area =" annotation to the blue areas
    annotate("segment", 
             x = (lower_obs + upper_obs) / 2 + area_label_offset, 
             y = -min(c(dnorm(lower, mean = mu, sd = sigma), 
                        dnorm(upper, mean = mu, sd = sigma))) * 0.5 + label_offset2,
             xend = centroid_left, 
             yend = dnorm(centroid_left, mean = mu, sd = sigma)/2,
             arrow = arrow(length = unit(0.2, "cm")), 
             color = "blue") +
    annotate("segment", 
             x = (lower_obs + upper_obs) / 2 + area_label_offset, 
             y = -min(c(dnorm(lower, mean = mu, sd = sigma), 
                        dnorm(upper, mean = mu, sd = sigma))) * 0.5 + label_offset2,
             xend = centroid_right, 
             yend = dnorm(centroid_left, mean = mu, sd = sigma)/2,
             arrow = arrow(length = unit(0.2, "cm")), 
             color = "blue") +
    labs(
      x = "x",
      y = "Density"
    ) +
    scale_y_continuous(breaks = NULL) +
    geom_vline(xintercept = mu, linetype = 2) +
    # annotate("text", 
    #          x = mu, 
    #          y = dnorm(mu, mean = mu, sd = sigma), 
    #          label = bquote(mu == .(round(mu, 2))), 
    #          vjust = -1, hjust = -0.5, size = 3 * text_zoom) +
    theme_minimal()
  
  return(p)
}


# plot_distribution_with_obs(2.1, mu = 0, sigma = 1, num_sd = 2, domain = c(-5, 5))

