setwd('C:/Users/longtan/Desktop/00-Code Project/99-Map plot')
library("plyr")
library(ggplot2)
library(maptools)

world_map <-readShapePoly("World_countries_shp.shp")
x <- world_map@data 
xs <- data.frame(x,id=seq(0:238)-1)
world_map1 <- fortify(world_map)
world_map_data <- join(world_map1, xs, type = "full")

Mydata<-read.csv("ERI market.csv",sep=';',header=T)
names(Mydata)<-c("NAME","Failures")
#replace USA to United States
Worlddata=join(Mydata, world_map_data, type = "full")

theme_map <- list(theme(panel.grid.minor = element_blank(),
 panel.grid.major = element_blank(),
 panel.border = element_blank(),
 axis.line = element_blank(),
 axis.text.x = element_blank(),
 axis.text.y = element_blank(),
 axis.ticks = element_blank(),
 axis.title.x = element_blank(),
 axis.title.y = element_blank(),
 panel.background = element_blank(),
 plot.background = element_blank()))

p<-ggplot(Worlddata, aes(x = long, y = lat, group = group,fill =Failures)) +geom_polygon(colour="grey")
p<-p+scale_fill_brewer(palette="YlOrRd")+theme_map
p
ggsave("World map ggplot.png", p, height=4.8, width=9.5)

#unique(world_map_data$NAME)
#+coord_cartesian(xlim=c(60,155),ylim=c(0,65)) #china near area