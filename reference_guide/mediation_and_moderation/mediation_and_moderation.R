
set.seed(23574)
rm(list = ls())

library(mediation)
library(QuantPsyc)
library(MASS)
library(rockchalk)

# good references:
# https://ademos.people.uic.edu/Chapter14.html#3_moderation_analyses
# https://imai.fas.harvard.edu/research/files/mediationR2.pdf
# https://web.mit.edu/teppei/www/research/mediationR.pdf
# https://personality-project.org/r/psych/HowTo/mediation.pdf
# https://advstats.psychstat.org/book/moderation/index.php


# MEDIATION ---------------------------------------------------------------
# to test the intermediate (mediating) effect of X through M on an outcome Y

Y <- 'outcome'
X <- 'main_predictor'
M <- 'mediator'
temp <- df[, c(X, M, Y)]
temp <- temp[complete.cases(temp), ]
names(temp) <- c('X', 'M', 'Y')

# fit separate relationships
fit.MX <- lm(M ~ X, data = temp)
fit.YMX <- lm(Y ~ X + M, data = temp)
fitmed <- mediate(fit.MX, fit.YMX, treat = 'X', mediator = 'M',
                  sims = 999, boot = TRUE, boot.ci.type = 'bca')
# check the indirect/mediation (ACME), direct (ADE) and total effects
# NOTE: if ACME is significant, there is an indication that M mediates the effect of X on Y
summary(fitmed)
plot(fitmed)

# clean up
rm(Y, X, M, temp, fit.MX, fit.YMX, fitmed)


# MODERATION --------------------------------------------------------------
# to basically test the effect of an interaction between two predictors on an outcome
# it assumes the effect of X being altered (moderated) by Z on an outcome Y

Y <- 'outcome'
X <- 'main_predictor'
Z <- 'moderator'
temp <- df[, c(X, Z, Y)]
temp <- temp[complete.cases(temp), ]
names(temp) <- c('X', 'Z', 'Y')

# according to ref 1 (above): "It is important to mean center both your moderator 
# and your main predictor to reduce multicolinearity and make interpretation easier"
temp$Xc <- scale(temp$X, center = TRUE, scale = FALSE) 
temp$Zc <- scale(temp$Z, center = TRUE, scale = FALSE)

# fit a model including the interaction to check its significance
fit.YZcXc <- glm(Y ~ Xc + Zc + Xc*Zc, data = temp, family = 'poisson')
summary(fit.YZcXc)

# plot/visualize moderation effect
plotSlopes(fit.YZcXc, plotx = "Xc", modx = "Zc", xlab = X, ylab = Y, modxVals = "std.dev")

# clean up
rm(Y, X, Z, temp, fit.YZcXc)


# END ---------------------------------------------------------------------

sessionInfo()
