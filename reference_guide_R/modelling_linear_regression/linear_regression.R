
set.seed(12345)
rm(list = ls())



# cross-validation of a linear model --------------------------------------

library("DAAG")

# The function below gives internal and cross-validation measures of predictive 
# accuracy for multiple linear regression. (For binary logistic regression, use 
# the CVbinary function.) The data are randomly assigned to a number of ‘folds’.
# Each fold is removed, in turn, while the remaining data is used to re-fit the 
# regression model and to predict at the deleted observations.

# example
data(cars)
cars
par(mfrow = c(1,1))
cvResults <- CVlm(data = cars, 
                  form.lm = dist ~ speed, 
                  m = 5, 
                  dots = FALSE, 
                  seed = 29, 
                  legend.pos = "topleft",  
                  printit = FALSE, 
                  main = "Small symbols are predicted values\nBigger symbols are actual ones")

attr(cvResults, 'ms')  # => 251.2783 mean squared error

# varible importance
library("caret")
lm <- lm(mpg ~ gear + hp + drat, data = mtcars)
summary(lm)
lmVarImp <- varImp(lm, scale = FALSE)
lmVarImp


# line and slope ----------------------------------------------------------

# ref
# https://stackoverflow.com/questions/13114539/how-to-add-rmse-slope-intercept-r2-to-r-plot


# END ---------------------------------------------------------------------

sessionInfo()
