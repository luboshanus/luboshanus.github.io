---
title: "Six Sigma for Statistics Students"
author: Lubos Hanus
---

Six Sigma is often taught as a business buzzword, but its core idea is statistical: reduce variation so that almost all outcomes fall inside customer specifications. The historical story also matters, because the method was not invented in a classroom. It grew out of a manufacturing reliability problem at Motorola in the mid-1980s.

## The original story in one paragraph

The standard historical account credits **Bill Smith**, an engineer at Motorola, as the principal originator of Six Sigma. Motorola had a quality problem: products that needed repair during production were much more likely to fail later in customers' hands. Smith argued that end-of-line inspection was not enough. The real goal had to be **preventing variation and defects upstream**, in process design and control. Motorola leadership, especially **Bob Galvin**, backed the effort, and **Mikel Harry** helped formalize and spread the approach inside the company. In short, Six Sigma started as a response to field failures, warranty costs, and process instability, not as a slogan.

## What "six sigma" means statistically

In statistics, sigma means standard deviation. Suppose a quality characteristic is approximately normal, with target mean `mu`, standard deviation `sigma`, and specification limits set by engineering requirements.

The key link to introductory statistics is the **z-score**:

`z = (x - mu) / sigma`

This tells us how many standard deviations an observation `x` lies away from the target mean. In manufacturing, large positive or negative z-scores are exactly the observations that move toward the specification limits or beyond them. Those are the units most likely to fail quality checks, require repair, or break later in customer use. This is why the statistical idea of an outlier connects directly to the reliability story behind Six Sigma: if the process creates too many extreme observations, reliability falls.

If the nearest specification limit is:

- `2σ` away from the mean, defects are common.
- `3σ` away, defects are much less common but still visible.
- `6σ` away, a centered process produces almost no defects.

For a **centered normal process**, the probability of falling outside `±6σ` is tiny: about `0.002` defects per million. That is much smaller than the famous Six Sigma slogan of **3.4 defects per million opportunities**.

Why the difference? In Motorola's operational convention, later popularized through Six Sigma training, people often assumed a **1.5 sigma long-run shift** in the process mean. Then a process that is `6σ` short-run from the target behaves more like `4.5σ` from one specification limit in the long run, which gives roughly **3.4 defects per million**. Statistically, this is an engineering convention, not a law of nature, and it is worth saying that explicitly to students.

## A simple picture

The figure below compares three situations:

1. A noisy `3σ` process.
2. A centered `6σ` process.
3. A centered `6σ` design that later shifts by `1.5σ`.

The orange tails are the defective observations outside the lower and upper specification limits.

![Six Sigma illustration](/assets/img-posts/six-sigma-story.png)

## R code with `ggplot2`

The plot can be generated directly in R:

```r
library(ggplot2)

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

labels_df <- data.frame(
  panel = c("3 sigma centered", "6 sigma centered", "6 sigma with 1.5 sigma shift"),
  x = c(-8.4, -8.4, -8.4),
  y = c(0.19, 0.43, 0.43),
  label = c(
    "Outside specs: about 2,700 ppm",
    "Outside specs: about 0.002 ppm",
    "Outside specs: about 3.4 ppm"
  )
)

ggplot(curve_df, aes(x = x, y = density)) +
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
  facet_wrap(~panel, ncol = 1) +
  labs(
    title = "Why statisticians care about Six Sigma",
    subtitle = "The same specification limits look very different when variation shrinks or when the mean drifts.",
    x = "Measurement scale",
    y = "Density"
  ) +
  theme_minimal(base_size = 12)
```

## Why this belongs in a statistics course

This is a core statistics concept because it is fundamentally about how far observations lie from the mean when measured in standard deviations. That is exactly the logic of the **z-score**: a z-score tells us how many standard deviations an observation is away from the mean, and Six Sigma applies the same idea to quality control and defect probabilities.

## References

- ASQ, ["Six Sigma: A Breakthrough Strategy for Profitability"](https://asq.org/quality-progress/articles/six-sigma-a-breakthrough-strategy-for-profitability?id=bd6baa689df842a3905d068dd52d2120), which attributes the development of Six Sigma to work by Bob Galvin and Bill Smith at Motorola and explains the `1.5σ` convention.
- North Carolina State University Supply Chain Resource Cooperative, ["What Should the Professional Supply Chain Manager Know about Six Sigma?"](https://scm.ncsu.edu/scm-articles/article/background-what-should-the-professional-supply-chain-manager-know-about-six-sigma), which summarizes Bill Smith's early reliability insight about repaired products failing in customer use.
- ASQ, ["The Confusion Over Six-Sigma Quality"](https://asq.org/quality-progress/articles/the-confusion-over-six-sigma-quality?id=5df937bea5a145b6843738990f422464), which is useful if you want the statistical caveat behind the famous `3.4` number.

<small>Note: This post was compiled with Codex from online sources.</small>
