########################################################################
###### Collection of helpful functions (not built-in in R base)  #######
########################################################################

########################################################################
## Standard error of a vector 										  
########################################################################

std <- function(x) sd(na.omit(x))/sqrt(length(na.omit(x)))

########################################################################
## Percentage table																  
########################################################################
## function: produce a sorted and rounded percentage table from a vector

percTable <- function(x) {
	print("sorted table:")
	print(sort(table(x), decreasing = TRUE))
	print("sorted and rounded percentage table:")
	print(round(prop.table(sort(table(x), decreasing = TRUE))*100, 2))
	}

########################################################################
## The six plot (an adaptation of the four plot) 					  
########################################################################
## reference: Good & Hardin (2012) in Common Errors in Statistics
## function: visual inspection of numeric vectors with six standard plots

sixPlot <- function(x) {
  x <- na.omit(x)
  split.screen(c(2, 3))
  
  screen(1)
  hist(x,
       main = "Histogram", xlab = "concentration of values", ylab = "density",
       probability = TRUE, 
       ylim = c(0,1)
       )
  lines(density(x), col = "red")
  
  screen(2)
  qqnorm(x,
         main = "Normal Q-Q plot", xlab = "theoretical quantiles", ylab = "sample quantiles",
         cex = .75)
  qqline(x, col = "red")
  
  screen(3)
  boxplot(x, 
          main = "Boxplot", ylab = "concentration of values")
  
  screen(4)
  lag.plot(x,
           main = "Lag plot",
           diag.col = "blue",
           cex = .75)
  
  screen(5)
  plot.ts(x,
          main = "Time plot", xlab = "time\n(sampling sequence)", ylab = "concentration of values")
  abline(a = median(lag(x)), b = 0, col = "red")
  mtext("median", cex = .75, 4, col = "red")
  
  screen(6)
  acf(x,
      main = "Autocorrelation plot", xlab = "lag", ylab = "ACF")
  close.screen(all = TRUE) 
}

########################################################################
## The multiplot														  
########################################################################
## reference: www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2) 
## function: combine several plots (ggplots) in one single pane

multiplot <- function(..., plotlist = NULL, file, cols = 1, layout = NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots == 1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

########################################################################
##																	  
########################################################################
## reference: 
## function: 



########################################################################
##																	  
########################################################################
## reference: 
## function: 



########################################################################
##																	  
########################################################################
## reference: 
## function: 

