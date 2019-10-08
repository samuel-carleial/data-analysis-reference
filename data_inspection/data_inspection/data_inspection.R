###########################################################################
# Data Inspection
###########################################################################

## Author: Samuel Carleial
## Date: 2019.10

###########################################################################
# Create example variables ------------------------------------------------
###########################################################################

## numeric
x1 <- as.numeric(rnorm(200, mean = 30, sd = 2.5))
x1

## categorical
x2 <- as.factor(sample(c(rep("male", 200), rep("female", 200), rep("hermaphrodite", 50)), 200))
x2

## ordinal
x3 <- as.factor(sample(c(rep("0", 100), rep("1", 140), rep("2", 180), rep("3", 200), rep("4", 150), rep("5", 125)), 200))
x3

###########################################################################
# Inspect variables: single variable --------------------------------------
###########################################################################

## common statistics
summary(x1); summary(x2); summary(x3)
range(x1)
table(x2); table(x3)
prop.table(table(x2))
round((prop.table(table(x3)) * 100), 2)

## common plots
boxplot(x1)
hist(x1)
par(mfrow = c(1,3))
plot(x1, main = "numeric"); plot(x2, main = "categorical"); plot(x3, main = "ordinal")

## the four-plot
## reference: Goodsmith et al., YYYY; Common Errors in Statistics
## upgrade: user-defined function to produce the four-plot with add-ons
fourPlot <- function(x) {
  split.screen(c(2, 3))
  # histogram
  screen(1)
  hist(x, 
       probability = TRUE, 
       main = "Histogram",
       breaks = 50, 
       ylim = c(0,1))
  lines(density(x), col = "red")
  # distribution
  screen(2)
  qqnorm(x)
  qqline(x, col = "red")
  # location
  screen(3)
  lag.plot(x,
           main = "lag.plot()",
           diag.col = "forest green", 
           cex = .75)
  # lag / time
  screen(4)
  plot(lag(x), 
       main = "plot(lag())",
       cex = .75)
  abline(a = median(lag(x1)), b = 0, col = "red")
  screen(5)
  plot.ts(x,
          main = "plot.ts")
  abline(a = median(lag(x1)), b = 0, col = "red")
  screen(6)
  acf(x,
      main = "auto/cross-\ncovariance/correlation")
  close.screen(all = TRUE) 
}

fourPlot(x1)

## outliers
# definition (Samuels et al., 2012; in Statistics for the Life Sciences):
# (modified) boxplots are the common types of boxplots that we see. These
# include the points in the extremes, which are exactly the outliers. A boxplot
# has 5 basic elements: min value, quartile 1 (Q1), quartile 2 (median), 
# quartile 3 (Q3), max value. IQR is the inter-quartile range, defined by 
# Q3 - Q1. The 'fences' are the cutt-offs that delimit lower and upper outliers.
# They are the bars in the extremes of boxplots. After those we find the outliers.
# The formula IQ1 - 1.5*IQR and  IQ3 + 1.5*IQR define lower and upper outliers,
# respectively.

x4 <- c(NA,1,3,35,7,3,6,5,NA,8,9,4,3,2,6,8,9,0,54,434,NA)
x4

boxplot.stats(x4)$out # find out outliers
x4[!x4 %in% boxplot.stats(x4)$out] # filter out outliers

## missing values or NAs
is.na(x1)
which(is.na(x2))
which(is.na(x4))

##


###########################################################################
# Inspect variables: multiple variables -----------------------------------
###########################################################################

library(blmeco)
data("frogs")
head(frogs)

## pairwise comparisons
pairs(frogs)
plot(frogs)
GGally::ggpairs(frogs[ ,1:7])

## interaction among variables: correlation matrix
corr_matrix1 <- cor(frogs[ ,1:7])
corr_matrix2 <- Hmisc::rcorr(as.matrix(frogs[ ,1:7]))
corr_matrix2

## interaction among variables: correlation plot and visualization
corrplot::corrplot(corr_matrix1, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)
heatmap(x = corr_matrix1, symm = TRUE)

##


