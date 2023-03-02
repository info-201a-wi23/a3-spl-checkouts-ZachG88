library(dplyr)
library(knitr)

setwd("/Users/zachgendreau/Desktop/INFO201/A3")
checkouts <- read.csv("spl_10_check.csv")

# Calculates the average number of checkouts for an item in the data set
individual_checkouts <- checkouts %>% group_by(Title) %>% summarise(Checkouts = sum(Checkouts)) 
avg_checkouts <- mean(individual_checkouts$Checkouts)

# Calculates the month/year that "Anna Karenina" was checked out the most
anna <- checkouts %>% filter(Title == "Anna Karenina") %>% filter(Checkouts == max(Checkouts))
anna_most_check <- paste0((anna %>% pull(CheckoutMonth)), "/", (anna %>% pull(CheckoutYear)))

# Calculates the month/year with the most checkouts of ebooks
ebooks <- checkouts %>% filter(MaterialType == "EBOOK") %>% filter(Checkouts == max(Checkouts))
ebook_most <- paste0((ebooks %>% pull(CheckoutMonth)), "/", (ebooks %>% pull(CheckoutYear)))

# Calculates a table of total checkouts per year from 2017-2023
# Used for chart 3
prints <- checkouts %>% filter(MaterialType == "BOOK") %>% group_by(CheckoutYear) %>% summarise(Checkouts = sum(Checkouts))

# Calculates the ratio of book to ebook checkouts
book_and_ebook <- checkouts %>% filter(MaterialType == "BOOK"|MaterialType == "EBOOK") %>% group_by(MaterialType) %>% summarise(Checkouts = sum(Checkouts))
book_ebook_ratio <- (book_and_ebook[1,2]) / (book_and_ebook[2,2])

kable(head(prints[1:2]), format = "markdown")

# Calculates checkouts for most checked out book over time 
# For chart 2
most_book <- checkouts %>% filter(MaterialType == "BOOK") %>% group_by(Title) %>% summarise(Checkouts = sum(Checkouts)) 
most_book_title <- most_book[which.max(most_book$Checkouts),] %>% pull(Title)
most_book_long <- checkouts %>% filter(Title == most_book_title) %>% group_by(CheckoutYear,CheckoutMonth) %>% summarise(Checkouts = sum(Checkouts), Title)
most_book_long <- most_book_long %>% 
  mutate(full_date = as.Date(paste0(CheckoutYear,"-",CheckoutMonth,"-1")))
  
most_ebook <- checkouts %>% filter(MaterialType == "EBOOK") %>% group_by(Title) %>% summarise(Checkouts = sum(Checkouts)) 
most_ebook_title <- most_ebook[which.max(most_ebook$Checkouts),] %>% pull(Title)
most_ebook_long <- checkouts %>% filter(Title == most_ebook_title) %>% group_by(CheckoutYear,CheckoutMonth) %>% summarise(Checkouts = sum(Checkouts), Title)
most_ebook_long <- most_ebook_long %>% 
  mutate(full_date = as.Date(paste0(CheckoutYear,"-",CheckoutMonth,"-1")))

merged_long_data <- left_join(most_book_long, most_ebook_long, by = "full_date")


# Analysis of Digital vs Physical media, used for chart2
dig_phys <- checkouts %>% group_by(CheckoutYear, CheckoutMonth, UsageClass) %>% 
  summarise(Checkouts = sum(Checkouts)) %>% mutate(full_date = as.Date(paste0(CheckoutYear,"-",CheckoutMonth,"-1")))

