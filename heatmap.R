setwd("C:/Users/Eileen/Documents/R")

#read in data
data <- read.csv("AAI_ANI_data.csv",header=TRUE)
rownames=t(data[1]) #pull row names which are in first column
(setattr(data, "row.names", rownames))
data <- data[2:length(data)] #take out first column which is just the row names

data_matrix <- as.matrix(data)
data_matrix

library(reshape2)
melted_matrix <- melt(data_matrix, na.rm=TRUE)

#heatmap
library(ggplot2)

ggheatmap <- ggplot(data=melted_matrix,aes(x=Var2,y=Var1,fill=value*100))+geom_tile()+theme_minimal()+scale_fill_gradient2(low="blue", high="red",mid="yellow",space="Lab", midpoint=95,name="% identity") +coord_fixed()

#add text
ggheatmap + 
  geom_text(aes(Var2, Var1, label = value*100), color = "black", size = 4) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank())
