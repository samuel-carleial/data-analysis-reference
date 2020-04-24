################################################################################

## random intercept vs. random slopes
http://www.bristol.ac.uk/cmm/learning/videos/random-slopes.html
https://seis.bristol.ac.uk/~frwjb/materials/ver2rirs.pdf
https://benwhalley.github.io/just-enough-r/fixed-or-random.html

################################################################################
## Requirements
################################################################################

# fit models
library("lme4")
library("nlme")
library("MCMCglmm")
library("spaMM")

# summarize and visualize models
library("memisc")
library("stargazer")
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
