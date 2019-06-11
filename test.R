# create a dataframe example

example <- data.frame(member_id = 1:100, sport = c(rep("Wrestling",20),rep("Boxing",64),rep("Sumo",3),rep("BJJ",13)))

#create usable data

usable <- as.data.frame(table(example[,2]))
names(usable)[1] <- names(example)[2]

#make sure to load the functions
source(file="unit_plot_functions.R")
#######

#test 
unit_plot(usable)


#################################################
#############Icon chart
#################################################

usable[,3] <- paste0("icon_",usable[,1])
names(usable)[3] <- 'icon'

library(png)
icon_BJJ <- readPNG("noun_Jiu Jitsu Man_643352.png")
icon_Boxing <- readPNG("noun_boxing_1341502.png")
icon_Sumo <- readPNG("noun_sumo_2255052.png")
icon_Wrestling <- readPNG("noun_Two Wrestlers_631862.png")



require(ggplot2)
require(grid)
  
offset <- 5
points <- NULL
n <- floor(sqrt(max(usable[,2])))
  
for (i in 1:dim(usable)[1]){
  aux <- translation(create_points(usable[i,2],n), (n+3)*i )
  points <- rbind(points,cbind(aux,rep(usable[i,3],dim(aux)[1])))
}
  
names(points) <- c('x','y','z')
  
points[,c(1,2)] <- 10*points[,c(1,2)]
  
p <- ggplot(data = points,aes(x=x,y=y)) + geom_point(size=0)
p <- p + theme(panel.grid.major = element_blank(),
                 panel.grid.minor = element_blank(),
                 axis.line = element_blank(),
                 axis.text =element_blank(),
                 axis.title = element_blank(),
                 axis.ticks = element_blank())
  
  
for (i in 1:dim(points)[1]){
  p <- p + annotation_custom(
    rasterGrob(eval(parse(text = as.character(points[i,3])))),
      xmin = points[i,1]-offset, xmax = points[i,1]+offset, 
      ymin = points[i,2]-offset, ymax = points[i,2]+offset
    ) 
}
  
print(p)
