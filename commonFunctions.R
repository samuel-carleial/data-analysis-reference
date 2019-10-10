########################################################################
###### Collection of common functions that are not built-in in R #######
########################################################################

## standard error of a vector



## the six plot (an adaptation of the four plot)
## a variation of the four plot by Good & Hardin (2012) in Common Errors in Statistics
## aim: create a pane with six plots to visualize and inspect numeric variables

sixPlot <- function(x) {
  split.screen(c(2, 3))
  
  screen(1)
  hist(x,
       main = "Histogram", xlab = "concentration of values", ylab = "density",
       probability = TRUE, 
       breaks = length(x)/4, 
       ylim = c(0,1)
       )
  lines(density(x), col = "red")
  
  screen(2)
  qqnorm(x,
         main = "Normal Q-Q plot", xlab = "theoretical quantiles", ylab = "sample quantiles",
         cex = .75)
  qqline(x, col = "red")
  
  screen(3)
  lag.plot(x,
           main = "Lag plot",
           diag.col = "blue", 
           cex = .75)
  
  screen(4)
  plot(lag(x),
       main = "Time plot (1)", xlab = "time\n(sampling sequence)", ylab = "concentration of values",
       cex = .75)
  abline(a = median(lag(x)), b = 0, col = "red")
  mtext("median", cex = .75, 4, col = "red")
  
  screen(5)
  plot.ts(x,
          main = "Time plot (2)", xlab = "time\n(sampling sequence)", ylab = "concentration of values")
  abline(a = median(lag(x)), b = 0, col = "red")
  mtext("median", cex = .75, 4, col = "red")
  
  screen(6)
  acf(x,
      main = "Autocorrelation plot", xlab = "lag", ylab = "ACF")
  close.screen(all = TRUE) 
}

##

##

##

##

##