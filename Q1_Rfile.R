#DATA SCIENCE AND TOOLKIT

# Load libraries
library(tidyverse)
library(ggplot2)
library(readr)

# Load CSV (change path if needed)
df <- read_csv("country_wise_latest - country_wise_latest.csv")

# View structure
print(glimpse(df))

# -------------------------------
# BASIC SUMMARY
# -------------------------------
print(summary(df))

# -------------------------------
# CLEAN COLUMN NAMES (OPTIONAL)
# -------------------------------
df <- df %>% 
  rename(
    Country = `Country/Region`,
    Confirmed = Confirmed,
    Deaths = Deaths,
    Recovered = Recovered
  )

# -------------------------------
# TOP 10 COUNTRIES BY CONFIRMED CASES
# -------------------------------
top_cases <- df %>%
  arrange(desc(Confirmed)) %>%
  slice(1:10)

p1 <- ggplot(top_cases, aes(x = reorder(Country, Confirmed), y = Confirmed)) +
  geom_col() +
  coord_flip() +
  labs(title = "Top 10 Countries by Confirmed Cases", x = "Country", y = "Confirmed Cases")

# -------------------------------
# TOP 10 COUNTRIES BY DEATHS
# -------------------------------
top_deaths <- df %>%
  arrange(desc(Deaths)) %>%
  slice(1:10)

p2 <- ggplot(top_deaths, aes(x = reorder(Country, Deaths), y = Deaths)) +
  geom_col(fill = "red") +
  coord_flip() +
  labs(title = "Top 10 Countries by Deaths", x = "Country", y = "Total Deaths")

# -------------------------------
# SCATTER PLOT: CONFIRMED VS DEATHS
# -------------------------------
p3 <- ggplot(df, aes(x = Confirmed, y = Deaths)) +
  geom_point(alpha = 0.6) +
  labs(title = "Confirmed Cases vs Deaths", x = "Confirmed", y = "Deaths")

# -------------------------------
# HISTOGRAM OF CONFIRMED CASES
# -------------------------------
p4 <- ggplot(df, aes(x = Confirmed)) +
  geom_histogram(bins = 30, fill = "steelblue") +
  labs(title = "Distribution of Confirmed Cases", x = "Confirmed Cases", y = "Frequency")

# -------------------------------
# SAVE ALL PLOTS INTO A SINGLE PDF
# -------------------------------
pdf("visualizations.pdf", width = 10, height = 7)
print(p1)
print(p2)
print(p3)
print(p4)
dev.off()

cat("PDF with all plots saved as: visualizations.pdf\n")
