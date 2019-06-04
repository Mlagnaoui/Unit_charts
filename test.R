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