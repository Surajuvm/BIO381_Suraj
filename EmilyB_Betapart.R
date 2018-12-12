# Analyzing occupancy data using betapart 

library(betapart)
library(tidyverse)
library(patchwork)

# Load data
occmats <- readRDS(file = "Zs.RDS")

#Convert to long format for plotting
long.dat <- function(x){
  x <- as.data.frame(x)
  x$Sites <- c(1:16)
  x %>%
    gather(Spec1:Spec8, key = "Species", value = "OccProb")
}
#Run above function
long2016 <- long.dat(x =occmats[[1]])
long2017 <- long.dat(x = occmats[[2]])
#Plot occupancy data as a raster/tile geom
occplot1 <- ggplot(data = long2016, aes(x = Species, y = Sites, fill = OccProb))+
  geom_tile()+
  scale_fill_gradient(low = "white", high = "black", guide = F)+
  scale_x_discrete(expand = c(0, 0.5))+
  theme_bw(base_size = 16)+
  theme(axis.text.x = element_blank())
occplot2 <- ggplot(data = long2017, aes(x = Species, y = Sites, fill = OccProb))+
  geom_tile()+
  scale_fill_gradient(low = "white", high = "black")+
  scale_x_discrete(expand = c(0, 0.5))+
  theme_bw(base_size = 16)+
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(),
        axis.text.x = element_blank())

plot <- occplot1/occplot2
print(plot)

# betapart can only use values between 0 and 1
occmats <- lapply(occmats, function(x) ifelse(x<1,0,x))

# calculate jaccard using beta.temp
temporal <- beta.temp(x=occmats[[1]], y=occmats[[2]],
                      index.family = "jaccard")

# site-by-site differences using beta.pair
spatial <- beta.pair(x=occmats[[1]], index.family = "jaccard")









