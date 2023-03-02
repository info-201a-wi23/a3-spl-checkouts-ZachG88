library(ggplot2)
library(tidyverse)

merged_long_data %>% 
  ggplot(aes(full_date,Checkouts.x, color = 'Book')) +
  geom_point() +
  geom_smooth() +
  geom_point(aes(full_date,Checkouts.y, color = 'Ebook')) +
  geom_smooth(aes(full_date,Checkouts.y, color = 'Ebook')) +
  labs(x = "Month", y = "Checkouts", title = "Book vs. Ebook checkouts over time",
       color = "Type of media") 

                       