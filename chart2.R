library(ggplot2)
library(tidyverse)

dig_phys %>% 
  ggplot(aes(full_date, Checkouts, color = UsageClass)) +
  geom_point(size = 1, lpha = 0.3) +
  geom_line(size = 0.5) +
  theme_minimal() +
  labs(x = "Month", title = "Digital vs. Physical checkouts over time", color = "Usage Class")

  