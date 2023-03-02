library(ggplot2)

ggplot(data = prints) +
  geom_col(mapping = aes(
    x = CheckoutYear,
    y = Checkouts,
    fill = factor(CheckoutYear)
  )) +
  scale_fill_manual(
    values =
      c("#be2db5","#a6279e","#8f2288","#771c71","#5f165a","#471144","#300b2d","#180617")) +
    labs(
      title = "Number of Print checkouts from 2017 to 2023",
      x = "Year",
      y = "Number Checkouts",
      fill = "Year"
    ) +
      theme(panel.background = element_rect(fill = "#f5ebe0"))
