
set.seed(12345)
rm(list = ls())

# Robust Analyses
# MM-type Estimators for Linear Regression
# install.packages('robustbase', dependencies = TRUE)

library(car)
library(multcomp)
library(robustbase)
library(ggplot2)
library(MASS)  

??robustbase
??lmrob()

# Recommendation:
# use the argument "setting = 'KS2014'" inside the fit call lmrob()

# Example 1 ---------------------------------------------------------------

## Dummy data
dummy <- data.frame(
  "DV" = c(1,4,3,6,5,8,1,4,3,6,5,12,1,2,3,4,5,6,1,2,3,4,5,6),
  "IV1" = factor(c(rep("A", 6), rep("B", 6), rep("C", 6), rep("D", 6))),
  "IV2" = factor(rep(c("M","N"), 12))
)
head(dummy)
plot(dummy)

## Fit robust model and view summary
ex1_a = lmrob(DV ~ IV1 + IV2, data = dummy)
summary(ex1_a)

## Effect of IV1
ex1_b = lmrob(DV ~ IV2, data = dummy)
anova(ex1_a, ex1_b)

## Effect of IV2
ex1_c = lmrob(DV ~ IV1, data  = dummy)
anova(ex1_a, ex1_c)

# Documentation for 'car:Anova' doesn't mention lmrob objects, but at least in
# this example, it seems to match the application of the anova.lmrob function.
Anova(ex1_a)

# Likewise, the documentation for 'multcomp package' doesn't mention lmrob objects,
# but at least in this example, the results seem reasonable.
mc <- glht(ex1_a, mcp(IV2 = "Tukey"))
ex1_b_mc <- summary(mc, test=adjusted("single-step"))
ex1_b_mc

mc <- glht(ex1_a, mcp(IV1 = "Tukey"))
ex1_c_mc <- summary(mc, test = adjusted("single-step"))
ex1_c_mc
rm(mc)

# Example 2 - improved ----------------------------------------------------
# reference source: code adapted from the lmrob() documentation

data(coleman, package = "robustbase")

## Default for a very long time:
ex2_a <- lmrob(Y ~ ., data=coleman)
summary(ex2_a)

## Nowadays **strongly recommended** for routine use:
ex2_b <- lmrob(Y ~ ., data=coleman, setting = "KS2014")
summary(ex2_b)

## check model
plot(residuals(ex2_b) ~ weights(ex2_b, type = "robustness")) # -> weights.lmrob()
abline(h = 0, lty = 3)

# Example 3 - improved ----------------------------------------------------
# reference source: code adapted from the lmrob() documentation

data(starsCYG, package = "robustbase")

## Compare fits of simple linear regression and robust regression
ex3_a <- lm(log.light ~ log.Te, data = starsCYG)
ex3_b <- lmrob(log.light ~ log.Te, data = starsCYG)
ex3_c <- lmrob(log.light ~ log.Te, setting = "KS2014", data = starsCYG)
plot(starsCYG)
abline(ex3_a, col = "red")
abline(ex3_b, col = "blue")
abline(ex3_c, col = "green")

## Observations:
## Least square fit has a negative slope
## whereas the robust fit has a slope ~= 2.2 % checked in ../tests/lmrob-data.R
## the setting argument DOES NOT IMPROVE the fit, it is similar to a normal lm()

summary(ex3_b) # 4 outliers; Rsquare of 36%
vcov(ex3_b)
identical(fitted(ex3_b), predict(ex3_b, newdata = starsCYG))

## FIXME: setting = "KS2011"  or  setting = "KS2014"  **FAIL** here

##--- 'init' argument -----------------------------------
# an optional argument to specify or supply the initial estimate

## String
m3 <- lmrob(Y ~ ., init = "S", data = coleman)
stopifnot(all.equal(ex3_a[-18], ex3_a[-18]))

## Function
initFun <- function(x, y, control, ...) { 
  init.S <- lmrob.S(x, y, control)
  list(coefficients = init.S$coef, scale = init.S$scale)
}
m4 <- lmrob(Y ~ ., method = "M", init = initFun, data = coleman)

## List
m5 <- lmrob(Y ~ ., method = "M", data = coleman,
            init = list(coefficients = m3$init$coef, scale = m3$scale))
stopifnot(all.equal(m4[-17], m5[-17]))

# Example 4 - using ggplot2 -----------------------------------------------
# ggplot has a built-in function to plot data using robust fitting from MASS

dummy2 <- data.frame(
  "x"=c(119,118,144,127,78.8,98.4,108,50,74,30.4,50,72,99,155,113,144,102,131,
        105,127,120,85,153,40.6,133),
  "y"=c(1.56,2.17,0.81,1.07,1.12,2.03,0.90,1.48,0.64,0.91,0.85,0.41,0.55,2.18,
        1.49,1.56,0.82,0.93,0.84,1.84,0.78,1.15,3.85,3.30,0.94))      
plot(dummy2)
 
## Robust linear model (rlm method)   
ggplot(data = dummy2, aes(x=x,y=y)) + 
  ggtitle("Robust linear model (rlm method)") +
  xlim(0,160) +
  geom_point() +
  stat_smooth(method = "rlm", fullrange = TRUE)

## Robust linear model (lmrob() function)
ggplot(data = dummy2, aes(x=x,y=y)) +
  ggtitle("Robust linear model (lmrob() function)") +
  xlim(0,160) +
  geom_point() +
  stat_smooth(
    method = function(
      formula,data,weights = weight) lmrob(
        formula,data,weights=weight,method="MM"),
    fullrange=TRUE)

# END ---------------------------------------------------------------------

sessionInfo()
