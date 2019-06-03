##auxiliary functions

#1
create_points <- function(n,n_col){
  if (n < n_col){
    points <- data.frame(x=1:n,y=rep(0,n))
  }
  
  else {
    r <- n %% n_col
    q <- n%/% n_col
    
    points <- NULL
    ord <- 0:(q-1)
    abs <- (0:(n_col-1))
    
    points <- rbind(points,expand.grid(abs,ord))
    if (r != 0){
      points <- rbind(points,expand.grid(c(abs[1:r],rep(0,n-r)),q))
    }
    
    names(points) <- c('x','y')
    
  }
  
  return(points)
}

#2
translation <- function(set,n){ #where set is a set of points i.e a two columns dataset of numbers 
  set[,1] <- set[,1] + n
  return(set)
}


#########################
#########################

unit_plot <- function(usable){
  require(ggplot2)
  
  points <- NULL
  n <- floor(sqrt(max(usable[,2])))
  
  for (i in 1:dim(usable)[1]){
    aux <- translation(create_points(usable[i,2],n), (n+3)*i )
    points <- rbind(points,cbind(aux,rep(usable[i,1],dim(aux)[1])))
  }
  
  names(points) <- c('x','y','z')
  
  p <- ggplot(data = points,aes(x=x,y=y,colour=z)) + geom_point() + labs(colour=names(usable)[1])
  p <- p + theme(panel.grid.major = element_blank(),
                 panel.grid.minor = element_blank(),
                 axis.line = element_blank(),
                 axis.text =element_blank(),
                 axis.title = element_blank(),
                 axis.ticks = element_blank())
  print(p)
  
}
