library(tidyverse)
library(gganimate)
library(ggplot2)

set.seed(20)

# Distribution
d1 = function(x, n = NULL) { 
  mu1 = -1    # Mean of first normal distribution
  sigma1 = 2  # Standard deviation of first normal distribution
  
  mu2 = 3     # Mean of second normal distribution
  sigma2 = 1  # Standard deviation of second normal distribution
  
  # If 'n' is provided, generate 'n' random samples
  if (!is.null(n)) {
    # Randomly select from the two distributions
    choices = sample(c(1, 2), size = n, replace = TRUE)  # 1 or 2 for the distributions
    
    samples = sapply(choices, function(choice) {
      if (choice == 1) {
        return(rnorm(1, mu1, sigma1))  # Sample from the first distribution
      } else {
        return(rnorm(1, mu2, sigma2))  # Sample from the second distribution
      }
    })
    
    return(samples)
  }
  
  # If no 'n' is provided, return the density function value for 'x'
  res = dnorm(x, mu1, sigma1) + dnorm(x, mu2, sigma2)
  return(res / 2)
}

# Create a data frame with samples for each sample size from 3 to 100
sample_data = map_dfr(c(1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000), function(n) {
  tibble(
    sample_size = n,
    x = d1(0,n)
  )
})

# Calculate sample mean for each sample size and create a formatted label
sample_means = sample_data %>%
  group_by(sample_size) %>%
  summarise(mean_x = mean(x)) %>%
  mutate(mean_label = sprintf("%.3f", mean_x))

# Merge the sample means back into the sample data so that each frame carries the mean_label value
sample_data = left_join(sample_data, sample_means, by = "sample_size")

# Create the plot:
p = ggplot(sample_data, aes(x = x)) +
  geom_histogram(aes(y = ..density..),
                 bins = 30,
                 fill = "skyblue",
                 color = "black",
                 alpha = 0.6) +
  # Overlay the true normal density curve
  stat_function(fun = d1,
                color = "red",
                size = 1.2) +
  # Add vertical line for the population mean (0)
  geom_vline(
    col = "black",
    xintercept = 1, linetype = "dashed", size = 1
  ) +
  # Add vertical line for the sample mean (calculated for each sample_size)
  geom_vline(
    data = sample_means, aes(xintercept = mean_x),
    col = "blue",
    linetype = "dotted", size = 1
  ) +
  labs(title = 'Number of Samples: {closest_state}',
       x = "x",
       y = "Density") +
  theme_minimal() +
  # Animate over the sample_size variable
  transition_states(sample_size,
                    transition_length = 2,
                    state_length = 1,
                    wrap = FALSE) +
  ease_aes('linear') +
  # Dynamically update the y-axis for each frame
  view_follow(fixed_y = FALSE, fixed_x = TRUE)

# Save the animation as a GIF
animate(p, nframes = 150, fps = 10, width = 300, height = 200, 
        renderer = gifski_renderer("Figures/normal_approximation.gif"))
