

library(readxl)
library(tidyverse)

data = read_excel("Ice_cream_kills.xlsx")


data %>%
  ggplot(aes(`Sale of ice cream (mio.)`, `Downing accidents`)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw()

lm(`Downing accidents` ~ `Sale of ice cream (mio.)`, data = data) %>% summary()


data %>%
  ggplot(aes(Month, `Downing accidents`)) +
  geom_point() + 
  theme_bw() + 
  geom_smooth()

data %>% 
  ggplot(aes(Month, `Sale of ice cream (mio.)`)) +
  geom_point() + 
  theme_bw() + 
  geom_smooth()
