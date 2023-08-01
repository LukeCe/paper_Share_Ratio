library("ggplot2")
simple_change <- data.frame(
  "CSP12" = c(0    ,.2,1),
  "CSP34" = c(.4/.8,.4,0),
  "CSP56" = c(.3/.8,.3,0),
  "CSP78" = c(.1/.8,.1,0))


ggplot(simple_change) +
  geom_line(aes(x = CSP12, y = CSP12, col = "CSP 1-2", lty = "CSP 1-2"),lwd = 1) +
  geom_line(aes(x = CSP12, y = CSP34, col = "CSP 3-4", lty = "CSP 3-4"),lwd = 1) +
  geom_line(aes(x = CSP12, y = CSP56, col = "CSP 5-6", lty = "CSP 5-6"),lwd = 1) +
  geom_line(aes(x = CSP12, y = CSP78, col = "CSP 7-8", lty = "CSP 7-8"),lwd = 1) +
  geom_vline(xintercept = .2, lwd = .5) +
  scale_x_continuous(labels = scales::percent, limits = c(0,1)) +
  scale_y_continuous(labels = scales::percent) +
  scale_color_manual(
    breaks = c("CSP 1-2", "CSP 3-4", "CSP 5-6", "CSP 7-8"),
    values = c("Orange", "Dark Blue", "Red", "Dark Green"),
    name = "Catégories") +
  scale_linetype_manual(
    breaks = c("CSP 1-2", "CSP 3-4", "CSP 5-6", "CSP 7-8"),
    values = c("solid", "dashed", "11111111", "111144"),
    name = "Catégories") +
  labs(x = "% CSP 1-2", y = "% CSP") +
  coord_fixed() +
  theme_bw()

ggsave("variations_X_CSP12.pdf", height = 6, width = 7)
