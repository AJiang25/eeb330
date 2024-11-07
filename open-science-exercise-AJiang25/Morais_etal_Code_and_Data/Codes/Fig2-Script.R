###########################################################################################
##### Natural recovery of corals after severe disturbance - Morais et al., 2023 ##########
################################################################ Aug/2023 ###############



##########################################################################################
## Figure 1:Figure 2. a) The relationship between Acropora recruit density (individuals m-2)
#and the change in Acropora coral cover (%) in each quadrat over the 24-month study period. 
# b) Differences in recovery of coral cover between areas with more than 11 recruits m-2 and 
#areas with less than 11 recruits m-2. 			 
#######################################################################################

# Loading necessary packages
library(ggplot2)
library(gridExtra)




# ---- Data Import ----

# Importing data for figure 2a
data_fig2a <- read.csv('Data/Data_fig2a.csv', header = TRUE, stringsAsFactors = FALSE)
data_fig2a_Cover <- read.csv('Data/Data_Fig2_Cover_Diff.csv', header = TRUE, stringsAsFactors = FALSE)


# Importing data for figure 2b
data_fig2b <- read.csv('Data/Data_Fig2b.csv', header = TRUE, stringsAsFactors = FALSE)



## Fig 2a ##

# ---- Fig 2a: Recruit density and  change in coral cover plot ----
Fig2a <- ggplot(data=data_fig2a)+
  geom_ribbon(aes(x=n_recruit, ymin=lower.HPD, ymax=upper.HPD), fill = '#5B99AA',  alpha=0.3)+
  geom_line(aes(y=emmean, x=n_recruit))+
  geom_point(data=data_fig2a_Cover, aes(x=n_recruit, y=Diff_cover), 
             shape = 21, size = 2.5, fill = "black") +
  labs(x = 'Density of Recruits', y =  "Increase in % cover over 24 months")+
  geom_hline(yintercept = 25, linetype="dashed", size = 0.2) +
  geom_vline(xintercept = 11.5, linetype="dashed", size = 0.2) +
  scale_x_continuous(breaks=c(0,5,11.5,15,20,25)) +
  theme_classic()


# Display the Recruit density and  change in coral cover plot
Fig2a




## Fig 2b ##


# ---- Fig 2b: Coral cover change in different recruit densities ----
Fig2b <- ggplot(data = data_fig2b) +
  geom_line(aes(x = Month, y = CoverNew, group = Density_cate, color = Density_cate), size = 1) +
  geom_ribbon(aes(x = Month, ymin = CoverNew - se, ymax = CoverNew + se,  
                  group = Density_cate,  fill = Density_cate), alpha = 0.5) +
  geom_hline(yintercept = 25, linetype="dashed", size = 0.5) +
  labs(x = 'Months', y =  "Coral Cover (%)")+
  annotate(geom="text", x=5, y=27, label="Global average Coral Cover (25%)",
           color="black",  alpha = 1, size = 3.5) +
  theme_classic() +
  scale_color_manual(breaks = c("High", "Low"), 
                     labels = c("More than 11 recriots/m2", "Less than 11 recriots/m2"),
                     values = c("High" = "#0EA8A8", "Low" = "#E5716E" )) +
  scale_fill_manual(breaks = c("High", "Low"), 
                    labels = c("More than 11 recriots/m2", "Less than 11 recriots/m2"),
                    values = c("High" = "#0EA8A8", "Low" = "#E5716E")) +
  theme(legend.position = c(0.03, 1), legend.justification = c(0, 1),
        legend.title = element_blank())



# Display the Recruit density and  change in coral cover plot
Fig2b



# Add subtitle to Fig2a
Fig2a <- Fig2a + 
  labs(subtitle = "a)") + 
  theme(plot.subtitle = element_text(hjust = 0))

# Add subtitle to Fig2b
Fig2b <- Fig2b + 
  labs(subtitle = "b)") + 
  theme(plot.subtitle = element_text(hjust = 0))

# Arrange them vertically
grid.arrange(Fig2a, Fig2b, ncol = 1)



