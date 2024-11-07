###########################################################################################
##### Natural recovery of corals after severe disturbance - Morais et al., 2023 ##########
################################################################ Aug/2023 ###############



#####################################################################
## Figure 1:Relative colony size of Acropora spp. coral recruits across the 24-month sampling period
## (2020-22). Each line represents a single colony, with colors representing the different growth forms.
## Relative size (cm2) is the planar area of each colony relative to the size at first detection and
## bar graph inset in each panel represents the number of colonies from each growth form in each exposure level 			 
#####################################################################




# Loading necessary packages
library(readr)
library(ggplot2)
library(dplyr)






# ---- Data Import ----

# Importing data for Relative Growth Plot
data_fig1 <- read_csv("Data/Data_Fig1_StGrowth.csv") %>% as.data.frame()

# Importing data for Inner Bar Graph
data_fig1_innerplots <- read.csv('Data/Data_Fig1_Innerplots.csv', header = TRUE, stringsAsFactors = FALSE)






# ---- Relative Colony Size Plot ----

Fig1_Relative_Growth <- ggplot() +
  geom_line(data=data_fig1, aes(x=Month, y=relColArea, group=Label, colour=growth_form), 
            alpha = 0.5, size = 1) +
  facet_wrap(~Exposure, ncol = 1) +
  theme_classic() +
  scale_color_manual(values = c("Corymbose" = "#4A8CBC", "Tabular" = "#CD77B0", 
                                "Digitate" ="#E67F39", "Branching" = "#59B547"))


# Display the Relative Colony Size Plot
Fig1_Relative_Growth





# ---- Bar Graph Inset in Each Panel ----

Fig1_Inner_plots <- data_fig1_innerplots %>% 
  ggplot() +
  geom_bar(aes(x=Exposure, fill=growth_form), position=position_dodge()) +
  facet_wrap(~Exposure, ncol = 1) +
  labs(y = "Number of Colonies") +
  theme_classic() +
  scale_fill_manual(values = c("Corymbose" = "#4A8CBB", "Tabular" = "#BF8AB5", 
                               "Digitate" ="#E89054", "Branching" = "#83B776"))


# Display the Bar Graph
Fig1_Inner_plots


