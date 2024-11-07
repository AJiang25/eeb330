###########################################################################################
##### Natural recovery of corals after severe disturbance - Morais et al., 2023 ##########
################################################################ Aug/2023 ###############



##########################################################################################
## Figure 4: Histograms showing frequency distributions of recruit density and the 
#proportion of locations with more than recruits per m2 (percent values and the red dashed lines)			 
#######################################################################################


# Loading necessary packages
library(ggplot2)
library(patchwork)
library(gridExtra)



# ---- Data Import ----

# Importing data for figure 2a
Data_Fig4a <- read.csv('Data/Data_fig4a.csv', header = TRUE, stringsAsFactors = FALSE)

# Importing data for figure 2b
Data_fig4b <- read.csv('Data/Data_Fig4b.csv', header = TRUE, stringsAsFactors = FALSE)




## Fig 4a ##

# ---- Fig 4a: Histogram with data from our study, which includes all quadrats 
#from our sampling area, including those without colonies (n = 428) ---- #
Fig4a <- ggplot(Data_fig4a, aes(x=n_recruit,)) +
  geom_histogram(fill="#56B4D1",alpha=0.5 ) +
  geom_vline(aes(xintercept=11.5),
             linetype="dashed", size = 0.5, color="red",alpha = 0.5) +
  annotate(geom="text", x=6, y=20, label="92.8%",
           color="black", alpha = 0.8, size = 5) +
  annotate(geom="text", x=19, y=20, label="7.2%",
           color="black", alpha = 0.8, size = 5)+
  annotate(geom="text", x=4.1, y=34, label="337 quadrats\nwith no recruits",
           color="black", alpha = 0.9, size = 2.8)+
  coord_cartesian(ylim = c(0, 35))+
  labs(x = expression(paste("Density of recruits (recruits/m"^2, ")")), y= "Count")+
  labs(title = "Lizard Island", subtitle = "post-bleaching (n=428)", tag = "a)")+
  theme_classic() 

# Display the graph
Fig4a





## Fig 4b ##

# Create annotation data frame
annotate_data1 <- data.frame(
  Density = 20,     # Specify x position of annotation
  Count = 7.5,       # Specify y position of annotation
  Merged_Status = "Post-bleaching",  # The facet you want to annotate
  label = "7.4%" # Your annotation
)


annotate_data2 <- data.frame(
  Density = 20,     # Specify x position of annotation
  Count = 7.5,       # Specify y position of annotation
  Merged_Status = "Pre-bleaching",  # The facet you want to annotate
  label = "27%" # Your annotation
)


# ---- Fig 4b: #Histograms with data from reefs at 11 Indo-Pacific locations, before 
#and after local bleaching events (locations in which there was no mention of bleaching 
#events wereassumed to represent pre-bleaching conditions). For panel (b) we used 
#data compiled in Koester et al.(2021). ---- #
Fig4b <- ggplot(Data_fig4b, aes(x=Density)) +
  geom_histogram( fill="#56B4D1",alpha=0.5 )+
  geom_vline(aes(xintercept=11.5),
             linetype="dashed", size = 0.5, color="red", alpha = 0.5) +
  xlab("Recruits per square meter") + ylab("Count")+
  labs(x = expression(paste("Density of recruits (recruits/m"^2, ")")), y= "Count")+
  facet_wrap(~Merged_Status) +
  theme_classic()+
  geom_text(data = annotate_data2, aes(x = Density, y = Count, label = label), 
            inherit.aes = FALSE, size = 5)+
  geom_text(data = annotate_data1, aes(x = Density, y = Count, label = label), 
            inherit.aes = FALSE, size = 5) +
  labs(title = "Indo-Pacific", tag = "b)")

# Display the graph
Fig4b




# Arrange them in a single figure
Fig4a + Fig4b




