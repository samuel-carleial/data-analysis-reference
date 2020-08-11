
set.seed(23574)
rm(list = ls())

library(ggfortify)
library(gvlma)
library(stargazer)
library(jtools)

?hatvalues
?influence.measures
?DHARMa

# model diagnostics: continuous (normal) data -----------------------------
# ggplot approach
# source: STHDA.com
# http://www.sthda.com/english/wiki/ggfortify-extension-to-ggplot2-to-handle-some-popular-packages-r-software-and-data-visualization

# Linear Models (lm)
# compute a linear model using iris data
m <- lm(Petal.Width ~
          + Petal.Length
        , data = iris)
# summary
stargazer(m, type = 'text')
summ(m)
# check model fit assumptions
gvlma(m)
# create plots with one line
autoplot(m, which = 1:6, ncol = 2, label.size = 3)
# use groups to highlight observations (ex: 'Species')
autoplot(m, which = 1:6, label.size = 3, data = iris,
         colour = 'Species')

# Generalized Linear Models (glm)
# compute a linear model using USArrests data
m <- glm(Murder ~
           + Assault
         + UrbanPop
         + Rape
         , family = gaussian
         , data = USArrests)
# create plots with one line
autoplot(m, which = 1:6, ncol = 2, label.size = 3,
         colour = 'steelblue') + theme_bw()

# Observations: autoplot use the ggplot syntax. This means that all functions
# in ggplot, such as theme(), labs() and so on should work. However, pay attention
# that the plots are made once, so particular modifications might not be easy to do.

# Note: by scaling predictors, model fit might be more easily achieved.
# However, note that estimates cannot be interpreted as by units of the variables, but instead standard deviation from those values

# model diagnostics: count data -------------------------------------------
# source: Cross Validated
# https://stats.stackexchange.com/questions/70558/diagnostic-plots-for-count-regression

# 1- Test and graph the original count data by plotting observed frequencies and
# fitted frequencies (see chapter 2 in Friendly) which is supported by the vcd
# package in R in large parts.
# For example, with goodfit and a rootogram:
library(MASS)
library(vcd)
data(quine)
fit <- goodfit(quine$Days)
summary(fit)
rootogram(fit)

# Alternatively use Ord_plot(), which help in identifying which count data model
# is underlying (e.g., here the slope is positive and the intercept is positive
# which speaks for a negative binomial distribution):
Ord_plot(quine$Days)

# or iuse with the 'XXXXXXness' plots where XXXXX is the distribution of choice,
# say Poissoness plot (which speaks against Poisson, try also type='nbinom'):
distplot(quine$Days, type='poisson')

# 2- Inspect usual goodness-of-fit measures (such as likelihood ratio statistics
# vs. a null model or similar):
mod1 <- glm(Days ~
              + Age
              + Sex
            , data = quine
            , family = 'poisson')
summary(mod1)
anova(mod1, test = 'Chisq')

# 3- Check for over/underdispersion by looking at residual deviance/df or at a
# formal test statistic (e.g., see this answer). Here we have clearly overdispersion:
library(AER)
deviance(mod1) / mod1$df.residual
dispersiontest(mod1)

# 4- Check for influential and leverage points, e.g., with the influencePlot in
# the car package. Of course here many points are highly influential because
# Poisson is a bad model:
library(car)
influencePlot(mod1)
cor.test()
# 5- Check for zero inflation by fitting a count data model and its zeroinflated
# / hurdle counterpart and compare them (usually with AIC). Here a zero inflated
# model would fit better than the simple Poisson (again probably due to overdispersion):
library(pscl)
mod2 <- zeroinfl(Days ~
                   + Age
                   + Sex
                 , data = quine
                 , dist = 'poisson')
AIC(mod1, mod2)

# 6- Plot the residuals (raw, deviance or scaled) on the y-axis vs. the (log)
# predicted values (or the linear predictor) on the x-axis. Here we see some very
# large residuals and a substantial deviance of the deviance residuals from the
# normal (speaking against the Poisson; Edit: @FlorianHartig's answer suggests
# that normality of these residuals is not to be expected so this is not a
# conclusive clue):
res <- residuals(mod1, type = 'deviance')
plot(log(predict(mod1)), res)
abline(h = 0, lty = 2)
qqnorm(res)
qqline(res)

# 7- If interested, plot a half normal probability plot of residuals by plotting
# ordered absolute residuals vs. expected normal values Atkinson (1981). A
# special feature would be to simulate a reference ‘line’ and envelope with
# simulated / bootstrapped confidence intervals (not shown though):                                                                                                                                                                                                                                                                                                                                                                                                                          one standard error):
library(faraway)
halfnorm(residuals(mod1))

# 8- Diagnostic plots for log linear models for count data (see chapters 7.2 and
# 7.7 in Friendly's book). Plot predicted vs. observed values perhaps with some
# interval estimate (I did just for the age groups--here we see again that we
# are pretty far off with our estimates due to the overdispersion apart, perhaps,
# in group F3. The pink points are the point prediction
# ± one standard error):
plot(Days ~
       + Age
     , data = quine)
prs  <- predict(mod1, type = 'response', se.fit = TRUE)
pris <- data.frame('pest' = prs[[1]]
                   , 'lwr' = prs[[1]] - prs[[2]]
                   , 'upr' = prs[[1]] + prs[[2]])
points(pris$pest ~ quine$Age, col = 'red')
points(pris$lwr  ~ quine$Age, col = 'pink', pch = 19)
points(pris$upr  ~ quine$Age, col = 'pink', pch = 19)

# model diagnostics 2 ---------------------------------------------------------

# use nested variables
# x1/x2 (where x2 is nested in x1)

# maximum number of predictor variables, which include interactions and
# non-linear termsn/3 - n/10

# step-wise approach:
# use submodels for psychological, environmental, systemic, etc. variables..
# then use the significant variables of each previous models into one combined model.

# p-values for main effects which also have interactions are not meaningful by themselves

# split-plot design
# example: different treatments applied to different plots of different sizes:
# glm(y ~ x.medium + x.small + x.smallest + Error(x.LARGEST / x.medium / x.small))
# note that x.LARGEST does not appear as main effect

# summary of models may have different outputs!
# summary.lm() != summary.glm()

# check which modelgives the best fit using the Akaike's fit criteria
AIC(mod1, mod2, mod3)

# summaryzing estimates for the model
drop1(mod1, test='Chi')
summary(mod1)
logLik(mod1)
coefficients(mod1)
effects(mod1)
anova(mod1)
summary(mod1)

# residuals
# get standardized residuals
sresid <- (mod1$residuals - mean(mod1$residuals))/sd(mod1$residuals)
residu <- residuals.glm(mod1)
identical(mod1$residuals, residuals.glm(mod1))
identical(mod1$residuals, residuals(mod1))
identical(mod1$residuals, resid(mod1))

identical(sresid, resid(mod1, type='deviance'))
identical(sresid, resid(mod1, type='pearson'))
identical(sresid, resid(mod1, type='working'))
identical(sresid, resid(mod1, type='response'))
identical(sresid, resid(mod1, type='partial'))

identical(residu, resid(mod1, type='deviance')) # this one
identical(residu, resid(mod1, type='pearson'))
identical(residu, resid(mod1, type='working'))
identical(residu, resid(mod1, type='response'))
identical(residu, resid(mod1, type='partial'))

# assumption1: normality of residuals
par(mfrow=c(1,3))
hist(residu, main='model residuals')
hist(sresid, main='standardized residuals')
qqnorm(sresid, cex = 1.75, pch = 21)
qqline(sresid, lty = 2, lwd = 2, col = 'red')

# assumption2: homocedasticity
par(mfrow=c(2,2))
plot(sresid ~ mod1$fitted.values, pch = 21, cex = 2, cex.lab = 1.5)
# plot standardized residuals against ALL predictor variables
# (or EVEN! non-included predicotrs)
plot(sresid ~ quine$Age)
plot(sresid ~ quine$Sex)

# assumption3: collinearity
pairs(d[, c('edu', 'ag_yrs')], panel = panel.smooth)
d %>%
  dplyr::select(age, child, lperp, con_mil, ec_int, edu, ag_yrs, ptsd_ss, dep_ss) %>%
  # method: 'kendall', 'spearman', 'pearson'
  cor(method = 'pearson', use = 'pairwise.complete.obs') %>%
  round(2)

# variance inflation factors (VIFs)
# if GFIV is < 3 then there is no colinearity in the dataset
car::vif(mod1)

# serial auto-correlation: successive datapoints are correlated (time and space confounding?)
# if p <.05 there seems to be autocorrelated data present
car::durbin.watson(mod1)
car::durbinWatsonTest(mod1)
# visually check autocorrelated datapoints  with the auto-correlation function
acf(sresid, main = 'auto-correlation plot')
Box.test(sresid, lag = 28, fitdf = 5, type = 'Ljung') # if p < .5 it suggests the data is autocorrelated

# outliers
influence <- influence.measures(mod1)
summary(influence)
lm.influence(mod1) # for linear models

# Model diagnostics using boot ------------------------------------------

library(boot)
glm.diag.plots(mod1, iden = TRUE, ret = TRUE)

# Model diagnostics using DHARMa ------------------------------------------

?DHARMa
library(DHARMa)
vignette('DHARMa', package='DHARMa')


# Comparing model classifications using ROC curves ------------------------
# Receiver Operating Characteristics (ROC), area under the curve (AUC)
# usually done for logistic models (binomial)
library(pROC)


# END ---------------------------------------------------------------------

sessionInfo()
