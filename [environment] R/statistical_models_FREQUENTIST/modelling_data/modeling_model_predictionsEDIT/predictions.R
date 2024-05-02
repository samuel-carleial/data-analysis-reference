
set.seed(23566)
rm(list = ls())
library(effects)
library(dplyr)
library(ggiraphExtra)

# Example 1 ---------------------------------------------------------------

# build an example model
data("airquality")
names(airquality)
lm <- lm(Ozone ~ Solar.R + Wind + Temp, data = airquality)

# check effects
summary(lm)
drop1(lm, test = "Chisq")
length(residuals(lm))

# plot effects automatically
plot(allEffects(lm))
effectsTheme() # set the lattice theme

# plot effects manually (using the Wind variable only)
par(mfrow = c(1,3))
plot(airquality$Wind[as.numeric(names(resid(lm)))], predict(lm))
abline(lm(predict(lm) ~ airquality$Wind[as.numeric(names(resid(lm)))]), col = "red")

# get predicted values for the response variable, defining a particular scenario for the predictors
# For example, let us say we want to know the predicted values for Ozone when
# the predictor Wind increases gradually, but Solar.R and Temp stay constant at 20 and 15, respectively.
## scenario
solar_constant <- rep(20, length(residuals(lm)))
range(airquality$Wind) # range of possible values for Wind
wind_increasing <- seq(1.7, 20.7, length.out = length(residuals(lm)))
temp_constant <- rep(15, length(residuals(lm)))
## prediction
predicted <- predict(lm, data.frame(Solar.R = solar_constant, 
                                    Wind = wind_increasing,
                                    Temp = temp_constant,
                                    se.fit = FALSE, type = "response"))
## prediction visualization
plot(seq(1.7, 20.7, length.out = length(residuals(lm))), 
     predicted)

rm(lm, predicted, solar_constant, wind_increasing, temp_constant)

# Example 2 ---------------------------------------------------------------
data("Arabidopsis")
head(Arabidopsis)
## model
lm <- lm(total.fruits ~ nutrient + status, data = Arabidopsis)
summary(lm)
## scatterplots with raw data
plot(total.fruits ~ nutrient, data = Arabidopsis)
plot(total.fruits ~ status, data = Arabidopsis)
## plots with effects
plot(allEffects(lm))
## predict values
nutrient_levels <- seq(1, 8, length.out = length(resid(lm)))
summary(Arabidopsis$status)
predicted <- predict.lm(lm,
                        data.frame(nutrient = nutrient_levels,
                                   status = Arabidopsis$status),
                        se.fit = TRUE, type = "response")
predicted$fit
## preparation for plot
A <- as.data.frame(cbind("nutrient_levels" = NA, "fit" = predicted$fit))
A <- A %>% arrange(fit)
A$nutrient_levels <- seq(1,8,length.out = length(A$fit))
## visualize predicted values
plot(total.fruits ~ jitter(nutrient, factor = .5), data = Arabidopsis)
abline(lm(predicted$fit ~ nutrient_levels), col = "red")
lines(A$nutrient_levels, A$fit, col = "blue")

rm(A, predicted, lm, nutrient_levels)

# Example 3 ---------------------------------------------------------------
# Prediction based on different assumptions, namely error distributions.
# Let us assume that aggression can be predicted/explained from the level of trauma
# however, we assume that the relationship between variables is logistic, not linear
aggression <- read.csv("aggression.csv", sep = ";")
names(data)
## Gaussian model
mGd <- lm(aggression ~ trauma, 
          data = aggression)  
## Poisson model (link log)
mPd <- glm(round(aggression,0) ~ trauma, 
           family = "poisson", 
          data = aggression)
AIC(mGd, mPd)
## NOTE: as expected, poisson model predicted aggression from trauma better
## fit a linear regression line on the data using ggplot
ggplot(aes(y = aggression, x = trauma),
       data = aggression) + 
  geom_smooth(method = "lm", se = TRUE) +
  geom_jitter(alpha = .25) + 
  theme_bw()
## modifying the method applied to calculate the line
ggplot(aes(y = aggression, x = trauma),
       data = aggression) + 
  geom_smooth(method = "loess", se = TRUE) +
  geom_jitter(alpha = .25) + 
  theme_bw()
## but, let us compare visually the fit
aggression_predG <- scale(predict(mGd, data.frame(trauma = aggression$trauma), type = "response"), center = FALSE)
aggression_predP <- scale(predict(mPd, data.frame(trauma = aggression$trauma), type = "response"), center = FALSE)
## expand data frame
aggression <- data.frame("aggression" = aggression$aggression,
                         "trauma" = aggression$trauma, 
                         "pred_aggG" = aggression_predG, 
                         "pred_aggP" = aggression_predP)
## order data
aggression <- aggression %>% arrange(trauma, aggression)
par(mfrow = c(1,2))
## gaussian prediction
plot(aggression$aggression, 
     aggression$trauma, main = "GAUSSIAN predicted aggression values\n from trauma")
lines(aggression$pred_aggG, 
      aggression$trauma, col = "red")
## poisson prediction
plot(aggression$aggression, 
     aggression$trauma, main = "POISSON predicted aggression values\n from trauma")
lines(aggression$pred_aggP, 
      aggression$trauma, col = "red")

# Example 4 ---------------------------------------------------------

# Predict Method for GLM Fits (from Venables and Ripley, 2002, pp. 190-2.)
## variables
ldose <- rep(0:5, 2)
numdead <- c(1, 4, 9, 13, 18, 20, 0, 2, 6, 10, 12, 16)
sex <- factor(rep(c("M", "F"), c(6, 6)))
SF <- cbind(numdead, numalive = 20-numdead)
## model
budworm.lg <- glm(SF ~ sex + ldose, family = binomial)
summary(budworm.lg)
## plot predicted effects
plot(c(1,32), c(0,1), type = "n", xlab = "dose",ylab = "prob", log = "x")
text(2^ldose, numdead/20, as.character(sex))
ld <- seq(0, 5, 0.1)
lines(2^ld, predict(budworm.lg, data.frame(ldose = ld,sex = factor(rep("M", length(ld)), levels = levels(sex))),type = "response"))
lines(2^ld, predict(budworm.lg, data.frame(ldose = ld,sex = factor(rep("F", length(ld)), levels = levels(sex))),type = "response"))
## using the package effects to automatically plot effects of the model
plot(allEffects(budworm.lg))

# Example 5 ---------------------------------------------------------
# using ggPredict()
ggPredict(budworm.lg)


# END ---------------------------------------------------------------------

sessionInfo()
