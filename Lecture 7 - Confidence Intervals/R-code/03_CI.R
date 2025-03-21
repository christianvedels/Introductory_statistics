library(tidyverse)

plot_distribution_with_sd = function(mu = 0, sigma = 1, num_sd = 2, domain = c(-5, 5),
                                     label_offset1 = -0.03, label_offset2 = 0, text_zoom = 1) {
  # Compute the lower and upper limits based on the chosen number of standard deviations
  lower = mu - num_sd * sigma
  upper = mu + num_sd * sigma
  
  # Calculate the area under the curve between these limits
  area_value = pnorm(upper, mean = mu, sd = sigma) - pnorm(lower, mean = mu, sd = sigma)
  
  # Generate a sequence of x-values over the chosen domain and compute corresponding density values
  x_seq = seq(domain[1], domain[2], length.out = 300)
  y_vals = dnorm(x_seq, mean = mu, sd = sigma)
  
  # Prepare data for the shaded area between lower and upper limits
  shade_data = tibble(x = seq(lower, upper, length.out = 200)) %>%
    mutate(y = dnorm(x, mean = mu, sd = sigma))
  
  # Create the plot using ggplot2
  p = ggplot(data.frame(x = x_seq, y = y_vals), aes(x = x, y = y)) +
    geom_line(size = 1.2) +
    geom_area(data = shade_data, aes(x = x, y = y), fill = "blue", alpha = 0.3) +
    geom_segment(aes(x = lower, xend = lower, y = 0, yend = dnorm(lower, mean = mu, sd = sigma)), 
                 linetype = "dashed") +
    geom_segment(aes(x = upper, xend = upper, y = 0, yend = dnorm(upper, mean = mu, sd = sigma)), 
                 linetype = "dashed") +
    annotate("text", x = lower, y = label_offset1, label = paste0("-", num_sd, "SE\n(", round(lower, 3), ")"), 
             vjust = -0.5, size = 3 * text_zoom) +
    annotate("text", x = upper, y = label_offset1, label = paste0("+", num_sd, "SE\n(", round(upper, 3), ")"), 
             vjust = -0.5, size = 3 * text_zoom) +
    annotate("text", 
             x = (lower + upper) / 2, 
             y = min(c(dnorm(lower, mean = mu, sd = sigma), dnorm(upper, mean = mu, sd = sigma))) * 0.5 + label_offset2,
             label = paste("Area =", round(area_value, 3)), 
             size = 3 * text_zoom, color = "blue") +
    labs(
      x = "x",
      y = "Density"
    ) +
    theme_minimal() +
    scale_y_continuous(breaks = NULL) + 
    geom_vline(xintercept = mu, lty = 2)
  
  return(p)
}


# Confidence Interval	Z
# 80%	1.282
# 85%	1.440
# 90%	1.645
# 95%	1.960
# 99%	2.576
# 99.5%	2.807
# 99.9%	3.291
