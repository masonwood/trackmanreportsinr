library(ggplot2)
library(ggforce)
library(dplyr)
library(baseballr)

pitch_colors <- c('Four-Seam' = rgb(210/255, 45/255, 73/255, alpha = .5),
                  'Two-Seam' = rgb(222/255, 106/255, 4/255, alpha = .5),
                  'Sinker' = rgb(254/255, 157/255, 0/255, alpha = .5),
                  'Cutter' = rgb(147/255, 63/255, 44/255, alpha = .5),
                  'Slider' = rgb(238/255, 231/255, 22/255, alpha = .5),
                  'Split-Finger' = rgb(59/255, 172/255, 172/255, alpha = .5),
                  'Splitter' = rgb(136/255, 136/255, 136/255, alpha = .5),
                  'Changeup' = rgb(29/255, 190/255, 58/255, alpha = .5),
                  'Sweeper' = rgb(221/255, 179/255, 58/255, alpha = .5),
                  'Knuckle Curve' = rgb(98/255, 54/255, 205/255, alpha = .5),
                  'Curveball' = rgb(0/255, 209/255, 237/255, alpha = .5),
                  'Slurve' = rgb(147/255, 175/255, 212/255, alpha = .5),
                  'Screwball' = rgb(96/255, 219/255, 51/255, alpha = .5),
                  'Forkball' = rgb(85/255, 204/255, 171/255, alpha = .5),
                  'Eephus' = rgb(136/255, 136/255, 136/255, alpha = .5),
                  'Other' = rgb(136/255, 136/255, 136/255, alpha = .5))

# Replace directory below
TrackmanFile <- read.csv("/Users/mason/Desktop/R project/TRACKMAN 2024/testing.csv")

# Replace PitcherId below
pitcher_data <- TrackmanFile %>% 
  filter(PitcherId == 1000092508)

centriod <- pitcher_data %>%
  group_by(AutoPitchType) %>%
  summarize(HorzBreak = mean(HorzBreak),
            InducedVertBreak = mean(InducedVertBreak), .groups="drop")

ggplot(data = pitcher_data, aes(x = HorzBreak, y = InducedVertBreak, color = factor(AutoPitchType))) +
  geom_vline(xintercept = seq(-20, 20, 10), linetype = "dashed", color = "lightgray") +
  geom_hline(yintercept = seq(-20, 20, 10), linetype = "dashed", color = "lightgray") +
  geom_vline(xintercept = 0, linewidth = .5) +
  geom_hline(yintercept = 0, linewidth = .5) +
  geom_point(size = 2.5, stroke = 1) +
  geom_point(data=centriod, mapping = aes(x = HorzBreak, y = InducedVertBreak, color = factor(AutoPitchType)), shape = 4, size = 3.5) +
  stat_ellipse(linetype = "solid", show.legend = FALSE) +
  scale_color_manual(values = pitch_colors) +
  guides(color = guide_legend(override.aes = list(shape = 19))) +
  theme_classic() +
  xlab("Horizontal Break (in)") +
  ylab("Induced Vertical Break (in)") +
  labs(color = "Pitch Type", title = "Pitch Movement Plot") +
  ylim(-25,25) +
  xlim(-25,25) +
  scale_x_continuous(breaks = seq(-20, 20, 10), limits = c(-25, 25)) +
  scale_y_continuous(breaks = seq(-20, 20, 10), limits = c(-25, 25)) +
  theme(plot.title = element_text(hjust = 0.5))