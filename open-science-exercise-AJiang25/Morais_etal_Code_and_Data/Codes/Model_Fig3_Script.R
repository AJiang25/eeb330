###########################################################################################
##### Natural recovery of corals after severe disturbance - Morais et al., 2023 ##########
################################################################ Aug/2023 ###############



#####################################################################
## Model (Figure 3): Bayesian generalized linear mixed effects model 
# with a gamma distribution and a log link function.		 
#####################################################################


# Loading necessary packages
library(ggplot2)
library(brms)
library(rstan)
library(tidybayes)
library(ggridges)
library(ggeffects)
library(scales)
library(viridis)
library(emmeans)
library(patchwork)
library(dplyr)
library(modelr)
library(purrr)
library(tibble)




# ---- Data Import ---- #

# Importing data for Relative Growth Plot
dd_Model <- read.csv('Data/Data_model_Fig3.csv', header = TRUE, stringsAsFactors = FALSE)


exposure_order <- c("Semi_exposed", "Exposed", "Lagoon", "Back reef")

dd_Model <- dd_Model %>% mutate(transect = factor(transect),
                      quadrat = factor(quadrat),
                      Exposure = factor(Exposure, levels = exposure_order))



Model_Growth <- brm(G_cm2 ~ scale(n_recruit) + growth_form*scale(log(Initial_S)) + Exposure +  (1|transect/quadrat),
              data=dd_Model,
              family= Gamma(link='log'),
              iter = 5000,
              warmup = 1000,
              chains = 3, cores = 3,
              thin = 5,
              seed = 1,
              control = list(adapt_delta = 0.99))







# ---- FIGURE 3 ---- #


## Fig 3a ##
#Data for figure 3a using ggpredict
Fig3a_data <- ggpredict(Model_Growth,"Exposure [all]") %>% as.data.frame() 

# Rename columns of the dataset
colnames(Fig3a_data) <- c("Exposure", "Predicted", "Lower CI", "Upper CI", " Group")


# ---- Predicted colony growth rates for the different exposure levels plot  ---- #
Fig3a <- ggplot(data = Fig3a_data, aes(x = Predicted, y = Exposure)) +
  geom_errorbar(aes(xmin = `Lower CI`, xmax = `Upper CI`), width = 0.2, size = 1, color = "#B22526") +
  geom_point(size = 5) +
  labs(x = expression(paste("Growth (cm"^2, ".yr"^-1,")"))) +
  scale_y_discrete(limits = c("Back reef", "Lagoon","Semi_exposed","Exposed")) +
  theme_classic() +
  theme(panel.border = element_rect(colour = "black", fill=NA, linewidth=0.8))+
  annotate("text", x = -Inf, y = Inf, label = "a)", hjust = -0.7, vjust = 1.5, size = 5, fontface = "bold")


# Display the graph
Fig3a





## Fig 3b ##
#Data for figure 3b using emmeans
Plot.Exp.em <- Model_Growth %>% emmeans(~Exposure) %>% pairs() %>% gather_emmeans_draws() %>%
  mutate(Percent = 100*(exp(.value)-1))


# ---- pairwise comparisons (ratio) of coral growth rates between the different exposure levels ---#
Fig3b <- Plot.Exp.em %>% ggplot()+
  geom_density_ridges_gradient(aes(x=exp(.value), 
                                   y= reorder(contrast, +exp(.value)), 
                                   fill = stat(x)), 
                               alpha = 0.4, colour = 'white',
                               show.legend = FALSE) +
  geom_vline(xintercept = 1, linetype = 'dashed')+
  scale_x_continuous('Pairwise exposure level coral growth ratio', trans = scales::log2_trans(), breaks = c(0.3, 1, 4)) +
  scale_y_discrete(labels = label_wrap(10)) + #
  scale_fill_viridis(option="C",limits = c(-1, 4.4))+
  labs(y = NULL)+
  scale_y_discrete(position = "right")+
  theme_classic() +theme(panel.border = element_rect(colour = "black", fill=NA, size=0.8))
 


# Display the graph
Fig3b






## Fig 3c ##
#Data for figure 3c using emmeans
dT <- dd_Model %>% filter(growth_form == "Tabular")
dB <- dd_Model %>% filter(growth_form == "Branching")
dC <- dd_Model %>% filter(growth_form == "Corymbose")
dD <- dd_Model %>% filter(growth_form == "Digitate")

grid_T <-with(dT, list(Initial_S = modelr::seq_range(Initial_S, n = 100)))
grid_B <-with(dB, list(Initial_S = modelr::seq_range(Initial_S, n = 100)))
grid_C <-with(dC, list(Initial_S = modelr::seq_range(Initial_S, n = 100)))
grid_D <-with(dD, list(Initial_S = modelr::seq_range(Initial_S, n = 100)))

newdataT <- Model_Growth %>%
  emmeans(~Initial_S|growth_form, at = grid_T, type = "response") %>%
  as.data.frame() %>% 
  filter(growth_form == "Tabular")

newdataB <- Model_Growth %>%
  emmeans(~Initial_S|growth_form, at = grid_B, type = "response") %>%
  as.data.frame()%>% 
  filter(growth_form == "Branching")

newdataC <- Model_Growth %>%
  emmeans(~Initial_S|growth_form, at = grid_C, type = "response") %>%
  as.data.frame() %>% 
  filter(growth_form == "Corymbose")


newdataD <- Model_Growth %>%
  emmeans(~Initial_S|growth_form, at = grid_D, type = "response") %>%
  as.data.frame() %>% 
  filter(growth_form == "Digitate")


merged_data2 <- bind_rows(newdataB, newdataT, newdataC, newdataD)




# ---- Interaction between initial colony size and coral growth form in determining colony growth rate ---#
Fig3c <- ggplot(data = merged_data2, aes(y = response, x = Initial_S)) +
  #geom_point(data=dd_Model,  aes(y=G_cm2,  color=growth_form), alpha = 0.3, size = 1.3) +
  geom_ribbon(aes(ymin = lower.HPD, ymax = upper.HPD, fill = growth_form), alpha = 0.6) +
  geom_line(aes(color = growth_form)) +
  #facet_wrap(~growth_form, ncol = 1) +
  scale_y_log10()+
  labs(x = expression(paste("Initial colony size (cm"^2, ")")),
       y= expression(paste("Growth (cm"^2, ".yr"^-1, ",", "log"[10],  ")" ))) +
  theme_classic()+
  theme(legend.position = c(1, 0), # This positions it in the bottom right corner
        legend.justification = c(1, 0), 
        legend.background = element_blank(),
        legend.box.background = element_rect(colour = NA, fill = NA)) +
  scale_color_manual(values = c("#6DBF5B", "#4A8CBB", "#E67F39","#C37AB3"))+
  scale_fill_manual(values = c("#6DBF5B", "#4A8CBB", "#E67F39","#C37AB3")) 


# Add subtitle to Fig3c
Fig3c <- Fig3c + 
  labs(subtitle = "c)") + 
  theme(plot.subtitle = element_text(hjust = 0))

# Display the graph
Fig3c







## Fig 3d ##
#Data for figure 3c using emmeans
grid1 <- with(dd_Model, list(n_recruit = modelr::seq_range(n_recruit, n = 100)))
newdata1 <- Model_Growth %>% emmeans(~n_recruit, at = grid1, type = "response") %>%
  as.data.frame



# ---- relationship between colony growth rate and recruit density ---#
Fig3d <- ggplot(data = newdata1, aes(y = response, x = n_recruit)) +
  #geom_point(data=dd_Model,  aes(y=G_cm2), fill ="lightblue" , alpha = 0.2, size = 1.3) +
  geom_ribbon(aes(ymin = lower.HPD, ymax = upper.HPD), fill = "#5B99AA", alpha = 0.7) +
  scale_x_continuous(breaks=c( 0,5,10,15,20,25))+
  geom_line(size = 1) +
  labs(x = expression(paste("Density of recruits (recruits/m"^2, ")")),
       y= expression(paste("Growth (cm"^2, ".yr"^-1, ",", "log"[10],  ")" )))+
  scale_y_log10()+
  theme_classic()


# Add subtitle to Fig3d
Fig3d <- Fig3d + 
  labs(subtitle = "b)") + 
  theme(plot.subtitle = element_text(hjust = 0))

# Display the graph
Fig3d





# Arrange them in a single figure

(Fig3a + Fig3b) / (Fig3c + Fig3d)










