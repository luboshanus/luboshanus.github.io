library(ggplot2)

dir.create("assets/img-posts", showWarnings = FALSE, recursive = TRUE)

curve_df <- do.call(
  rbind,
  list(
    data.frame(
      x = seq(-9, 9, length.out = 2000),
      density = dnorm(seq(-9, 9, length.out = 2000), mean = 0, sd = 2),
      panel = "3 sigma centered",
      shade = abs(seq(-9, 9, length.out = 2000)) >= 6
    ),
    data.frame(
      x = seq(-9, 9, length.out = 2000),
      density = dnorm(seq(-9, 9, length.out = 2000), mean = 0, sd = 1),
      panel = "6 sigma centered",
      shade = abs(seq(-9, 9, length.out = 2000)) >= 6
    ),
    data.frame(
      x = seq(-9, 9, length.out = 2000),
      density = dnorm(seq(-9, 9, length.out = 2000), mean = 1.5, sd = 1),
      panel = "6 sigma with 1.5 sigma shift",
      shade = seq(-9, 9, length.out = 2000) >= 6 | seq(-9, 9, length.out = 2000) <= -6
    )
  )
)

curve_df$panel <- factor(
  curve_df$panel,
  levels = c("3 sigma centered", "6 sigma centered", "6 sigma with 1.5 sigma shift")
)

labels_df <- data.frame(
  panel = factor(
    c("3 sigma centered", "6 sigma centered", "6 sigma with 1.5 sigma shift"),
    levels = levels(curve_df$panel)
  ),
  x = c(-8.4, -8.4, -8.4),
  y = c(0.19, 0.43, 0.43),
  label = c(
    "Outside specs: about 2,700 ppm",
    "Outside specs: about 0.002 ppm",
    "Outside specs: about 3.4 ppm"
  )
)

p <- ggplot(curve_df, aes(x = x, y = density)) +
  geom_area(
    data = subset(curve_df, shade),
    fill = "#d97706",
    alpha = 0.35
  ) +
  geom_line(color = "#002fa7", linewidth = 0.9) +
  geom_vline(xintercept = c(-6, 6), linetype = "dashed", color = "#7c3aed") +
  geom_text(
    data = labels_df,
    aes(x = x, y = y, label = label),
    inherit.aes = FALSE,
    hjust = 0,
    size = 3.4,
    color = "#243b53"
  ) +
  annotate("text", x = -6, y = 0.01, label = "LSL", color = "#7c3aed", vjust = -0.5, size = 3.2) +
  annotate("text", x = 6, y = 0.01, label = "USL", color = "#7c3aed", vjust = -0.5, size = 3.2) +
  facet_wrap(~panel, ncol = 1, scales = "fixed") +
  labs(
    title = "Why statisticians care about Six Sigma",
    subtitle = "The same specification limits look very different when variation shrinks or when the mean drifts.",
    x = "Measurement scale",
    y = "Density",
    caption = "Centered 6 sigma is much tighter than the business convention of 3.4 defects per million, which uses a 1.5 sigma shift."
  ) +
  coord_cartesian(xlim = c(-9, 9), ylim = c(0, 0.45), expand = FALSE) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", color = "#002fa7"),
    plot.subtitle = element_text(color = "#486581"),
    strip.text = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

ggsave(
  filename = "assets/img-posts/six-sigma-story.png",
  plot = p,
  width = 8.5,
  height = 10.5,
  dpi = 180
)
