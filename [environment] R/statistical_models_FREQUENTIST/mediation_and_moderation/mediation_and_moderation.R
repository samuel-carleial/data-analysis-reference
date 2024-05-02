
set.seed(23574)
rm(list = ls())

library(mediation)
library(QuantPsyc)
library(MASS)
library(rockchalk)

# references for MEDIATION:
# https://advstats.psychstat.org/book/mediation/index.php
# https://web.mit.edu/teppei/www/research/mediationR.pdf
# https://imai.fas.harvard.edu/research/files/mediationR2.pdf
# https://personality-project.org/r/psych/HowTo/mediation.pdf
# https://towardsdatascience.com/doing-and-reporting-your-first-mediation-analysis-in-r-2fe423b92171
# https://data.library.virginia.edu/introduction-to-mediation-analysis/

# references for MODERATION:
# https://advstats.psychstat.org/book/moderation/index.php
# https://ademos.people.uic.edu/Chapter14.html#3_moderation_analyses

# references for CAUSAL INFERENCE:
# https://www.r-bloggers.com/an-introduction-to-causal-inference/


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

# EXAMPLE 2: bmem package
# https://advstats.psychstat.org/book/mediation/index.php
library("bmem")
library("sem")
temp.model <- specifyEquations(exog.variances=T) 
Y = b*X + cp*M
X = a*M
#(empty)
effects <- c('a*b', 'cp+a*b') 
temp.res <- bmem.sobel(temp, temp.model, effects)
temp.res <- bmem(temp, temp.model, effects, boot = 999) # bootstraping CIs


# clean up
rm(Y, X, M, temp, fit.MX, fit.YMX, fitmed, temp.model, effects, temp.res)


# MODERATION --------------------------------------------------------------
# to basically test the effect of an interaction between two predictors on an outcome
# it assumes the effect of X being altered (moderated) by Z on an outcome Y

# EXAMPLE 1
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

# EXAMPLE 2
# NOTE: does not allow for setting a different outcome distribution other than Gaussian
fit.mod <- moderate.lm(x = X, z = Z, y = Y, data = temp)
summary(fit.mod)
sim.slopes(fit.mod, temp$Z)

# clean up
rm(Y, X, Z, temp, fit.YZcXc, fit.mod)


# END ---------------------------------------------------------------------

sessionInfo()
