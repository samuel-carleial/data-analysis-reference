################################################################################

MIXED EFFECTS MODELS

# notes on mixed effects
# definition: the independent variable which usually refers to a nest, hierachical structure. Not really tested or of interest in experiment, but should be used to correct for the design. Can be seen as a factor that is randomly gathered from an infinite possibility of alternatives
# mixed effects shouls have many levels (>5 so that estimates can be drawn from a prob. distribution, otherwise maybe should be treated as fixed effects)
# model fits should have residuals ploted against predictors and random effects to check for heteroscedasticity
# plot(ranef(model))


## random intercept vs. random slopes
http://www.bristol.ac.uk/cmm/learning/videos/random-slopes.html
https://seis.bristol.ac.uk/~frwjb/materials/ver2rirs.pdf
https://benwhalley.github.io/just-enough-r/fixed-or-random.html


###############

MULTILEVEL MODELS
# ref: https://benwhalley.github.io/just-enough-r/multilevel-models.html



################################################################################
## Requirements
################################################################################

# fit models
library("lme4")
library("nlme")
library("MCMCglmm")
library("spaMM")
library("lmerTest")

# summarize and visualize models
library("memisc")
library("stargazer")
library("jtools")
library("ggplot2")

# plot effects and coefficients
library("effects")
plot(allEffects(model))
library("coefplot")
coefplot::coefplot(model)
coefplot::buildModelCI(model)
coefplot::multiplot(model1, model2...)

# diagnose models
library("DHARMa")




## Example of distributions
x1 <- rnorm(200,mean = 20)
x2 <- rbinom(n = 200, size = 1, prob =  .75)
x3 <- rpois(200, lambda = 5)

par(mfrow=c(3,1))
hist(x1, main = "Continuous variable", freq =F)
lines(density(x1), col="red")

hist(x2, main = "Bimodal variable", xaxt = "n", xlim = c(-.5, 1.5), freq = F)
axis(1, c(0,1), labels = c("nao", "sim"), tick = F, padj= -1.5)
lines(density(x2), col = "red")

hist(x3, main = "Categorical variable", freq = F)
lines(density(x3), col = "red")

## Mixed-effect model
data("Arabidopsis")
help(Arabidopsis)
str(Arabidopsis)
# check variability and importance of mixed-effect to be considered included in the model
model <- lmer(total.fruits ~ 1 + (1|reg), data = Arabidopsis)
summ(model) # summ function does not warn for models with convergence issues!!!
ranova(model)

# test interaction
library("reghelper")
simple_slopes(model_with_interaction)
graph_model(model_with_interactions, y=, x=, lines=)

################################################################################
## Gaussian data: continuous
################################################################################
## Binomial data: Bernouli (0/1) or proportion
################################################################################
## Poisson data: count
################################################################################
## Ordinal: categorical
################################################################################


# model selection
step(model, direction = "both", scale = model_residual_standard_error^2)

# summarize model fit
summary()
mtable()
stargazer()
summ()
