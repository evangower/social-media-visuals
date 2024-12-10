
# carolina-panthers-winpercentage.R

library(tidyverse)
library(showtext)

# Read results.csv file
data <- read.csv("NFL-Carolina-Panthers.csv")

# Display the data
print(data)

# Add font
font_add_google("DM Sans", "font")
showtext_auto()

# Add in 2024 data
new_row <- data.frame(
  season = 2024,
  conference = "NFC",
  division = "South",
  division_position = NA,
  won = 3,
  lost = 9,
  ties = 0,
  win_percentage = 0.250,
  pf = NA,
  pa = NA,
  pd = NA,
  head_coach = NA,
  playoffs = NA,
  playoffs_seed = NA
)

# Check if the column names and order match
if (all(names(new_row) == names(data))) {
  # Append the new row to the existing data frame
  data <- rbind(data, new_row)
} else {
  stop("Column names or order do not match between the new row and the existing data frame.")
}

# Display the updated data
print(data)

# Set image size
options(repr.plot.width = 8.5, repr.plot.height = 5)

# Create a line chart of win_percentage over season
ggplot(data, aes(x = season, y = win_percentage)) +
  geom_line(color = "grey30", linewidth = 0.6) +
  geom_area(data = subset(data, season >= 2018 & season <= 2024), aes(x = season, y = win_percentage), fill = "#0085CA", alpha = 0.4) +
  geom_point(color = "black", size = 1.5) +
  labs(title = "Still Searching for a Winning Season",
       subtitle = "The Carolina Panthers haven't had a winning season since David Tepper bought the team in 2018",
       caption = "Note 2024 Season 12/17 games played | Data: NFL | Viz: Evan Gower",
       x = "",
       y = "Win %") +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.25), labels = scales::percent) +
  theme_minimal() +
  theme(text = element_text(family = "font")) + theme(
    plot.title = element_text(size = 24, face = "bold", hjust = -0.25, vjust = 1.35),
    plot.subtitle = element_text(size = 13, hjust = -0.72, vjust = 2.5), 
    plot.caption = element_text(size = 10, hjust = -0.14, vjust = 6.5),
    axis.title.y = element_text(size = 16, margin = margin(r = -10)),
    axis.text.y = element_text(size = 13.5, face = "bold", margin = margin(r = 1)),
    axis.text.x = element_text(size = 11.5, face = "bold", vjust = 2, margin = margin(b = -1)), 
    plot.margin = margin(t = 15, r = 10, b = -5, l = 10),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank()) +
  annotate("text", x = 2020.55, y = max(data$win_percentage, na.rm = TRUE), label = "David\nTepper\nEra", color = "black", family = "font", size = 5.5, vjust = 5.4, fontface = "bold", lineheight = 0.8)
