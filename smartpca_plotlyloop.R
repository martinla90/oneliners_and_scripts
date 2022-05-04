library(plotly)
library(tidyverse)
library(htmlwidgets)
library(ggplot2)
library(data.table)

data <- read.table("PCA.evec", header = F) #.evec file
evals <- read.table("PCA.eval") #.eval file
values <- mutate(evals,V2=format(round(V1/colSums(evals)*100, 2),nsmall = 2))
  
for (i in 1:9) #PCS to plot on X axis, loop will output PCi vs PCi+1
{

htmlwidgets::saveWidget(as_widget(
  ggplotly( 
  ggplot(data=data,aes(x=data[,i+1],y=data[,i+2],text = data[,1]))+
    geom_point(aes(colour  = data[,12]))+
    labs(x=paste0("PC",i,"(",values[i,2],"%",")"), 
         y=paste0("PC",i+1,"(",values[i+1,2],"%",")"), 
         colour = "Population")
          )                     )
,paste0(i,i+1,".html"))
}
