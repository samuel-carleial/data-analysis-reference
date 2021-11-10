
# Structural Equation Modeling (SEM)
# path analysis, latent variable analysis, and other...

# Samuel Carleial
# Date: 08.11.2021


# preliminaries ----------------------------------------------------------------

## setup
set.seed(2537)
rm(list = ls())
library("lavaan")
library("blavaan")
library("semPlot")
library("dplyr")
#library("lavaanPlot")
#library("NETCoupler")

setwd("~/git_projects/data-analysis-reference/[environment] R/structural_equation_modeling")
dataset <- read.csv('dataset.txt', header = TRUE, sep="\t")
head(dataset)


# reference materials ----------------------------------------------------------

# ref: 
# model fit criteria by Hu & Bentler (1999)
# https://www.tandfonline.com/doi/abs/10.1080/10705519909540118
# standard model fit criteria: 
# - Chisq should be > .05 (for small samples sizes, because with large ones this criteria is not reliable)
# - CFI > .95
# - RMSEA (90% CI) < .05 with upper bound < .10
# - SRMR < .08

# ref:
# packages, syntax and examples
# http://lavaan.ugent.be/tutorial/index.html
# http://www.sachaepskamp.com/files/semPlot.pdf
# https://jeromyanglim.tumblr.com/post/33556941601/lavaan-cheat-sheet
# https://users.ugent.be/~yrosseel/lavaan/lavaanIntroduction.pdf

## model
## NOTE: the model should be conceptually based on a hypothesis/theory background
# =~ means latent variable
# ~~ means variance / covariance
# ~  means regressed on (explained by)


# Frequentist approach ---------------------------------------------------------

# -> example a -----------------------------------------------------------------
# TYPE: simple path analysis
# DESCRIPTION: outcome is explained by X1, X2, X3, and the latter two
# are respectively explained by X4 and X5. See plot below.
model <- 
'
  # measurement model
    
  # regressions
    outcome ~ X1 + X2 + X3
    X2      ~ X4
    X3      ~ X5
  
  # covariance  
'
fit <- sem(model, data = dataset)
summary(fit, fit.measures = TRUE)
semPaths(fit)
rm(model, fit)


# -> example b -----------------------------------------------------------------
# TYPE: mediation analysis
# DESCRIPTION: outcome is explained by X1 and X2, however the effect of X1 is 
# mediated by X2 (there is a direct and indirect effect). See plot below.
model <- 
'
  # measurement model
    
  # regressions
    outcome ~ a*X1 + b*X2
    X2      ~ c*X1
  
  # covariance
  
  # user-defined estimations
  indirect_effect := a*b
  direct_effect   := c
  total_effect    := indirect_effect + direct_effect
'
fit <- sem(model, data = dataset)
summary(fit, fit.measures = TRUE)
semPaths(fit, rotation = 2)
rm(model, fit)

# -> example c -----------------------------------------------------------------
# TYPE: moderation analysis
# Moderation can bbe understood as the interaction of two variables. In a SEM, one
# needs to therefore create a new variable (product of variables) and add it in
# the model. Here, we have X1 and X2 with the X1.X2 interaction effect

dataset$X1.X2 <- dataset$X1*dataset$X2
model <- 
'
  # measurement model
    
  # regressions
    outcome ~ a*X1 + b*X2 + c*X1.X2
  
  # covariance
  
  # user-defined estimations
  effect1      := a
  effect2      := b
  interaction  := c
  main_effect  := a+b
  total_effect := a+b+c
'
fit <- sem(model, data = dataset)
summary(fit, fit.measures = TRUE)
semPaths(fit, rotation = 2)
dataset$X1.X2 <- NULL #(remove variable product)
rm(model, fit)


# -> example d -----------------------------------------------------------------
# TYPE: latent variable analysis
## The industrialization and Political Democracy (Classical Example)
## Bollen (1989), page 332
help("PoliticalDemocracy")

model <- 
' 
  # latent variable definitions
     ind60 =~ x1 + x2 + x3
     dem60 =~ y1 + a*y2 + b*y3 + c*y4
     dem65 =~ y5 + a*y6 + b*y7 + c*y8

  # regressions
    dem60 ~ A*ind60
    dem65 ~ B*ind60 + C*dem60

  # residual correlations
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
  
  # mediation effects
  direct  := B
  indirect:= A*C
'

fit <- sem(model, data = PoliticalDemocracy)
summary(fit, fit.measures = TRUE)
semPaths(fit, "std", layout="tree2")
modificationindices(fit)
rm(model, fit)


# repetition of step above, with some additional explanations
## fit model
## OBSERVATION: the default estimator works only for continuous data (GLS).
## other estimators accept categorical data, and adjust for robust tests:
## GLS, WLS, DWLS, ULS, WLSM, WLSMVS, ULSM, ULSMVS, ULSMV
## MV" suffixes stand for Mean-Variance, these suffixes come for adjustment
## of estimator methods to robust tests.

# fit model
fit <- sem(model = model, data = dataset, ordered = NULL, estimator = 'MLR')
# NOTE: sem model can be fitted using var/cov matrix + sample size arguments
# for this set the arguments: sample.cov= and sample.nobs=, but remove argument data=

## summaries
summary(fit, fit.measures = TRUE)
fitMeasures(fit)[c('aic', 'chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr')]

## modification indices
modificationindices(fit, minimum.value = 10, sort = TRUE)

## r-squared for all model variables, including outcome
inspect(fit, 'r2')

## plot paths
semPaths(fit)
# personalize plot (edit arguments below)
semPaths(fit, 
         style = 'lisrel', 
         layout = 'tree',
         intercepts = FALSE, 
         residuals = FALSE,
         # node names are ordered, but pay attention to the rotation argument!
         # nodeLabels = c('outcome',
         #                'latent1',
         #                'latent2',
         #                '...'),
         # personalize the color of variables
         # color = c('tomato', 
         #           rep('tan1',2), 
         #           ...),
         whatLabels = 'std', 
         edge.label.cex = .8,
         label.prop=.9, 
         edge.label.color = 'black', 
         rotation = 2, 
         equalizeManifests = TRUE, 
         optimizeLatRes = TRUE, 
         node.width = 2.5, 
         edge.width = 0.5, 
         shapeMan = 'circle', 
         shapeLat = 'ellipse', 
         shapeInt = 'triangle', 
         sizeMan = 4, 
         sizeInt = 2, 
         sizeLat = 4, 
         curve=4, 
         unCol = 'black', 
         # set margins of plot to fit all information in the pane
         mar = c(2,6,6,11))
title(paste0('Path Analysis\nExample 1 (', sample_size, ')'))
rm(model, fit)


# Bayesian approach ------------------------------------------------------------
# -> example a -----------------------------------------------------------------
# from documentation
         
model <- 
' 
    # latent variable definitions
    ind60 =~ x1 + x2 + x3
    dem60 =~ y1 + a*y2 + b*y3 + c*y4
    dem65 =~ y5 + a*y6 + b*y7 + c*y8
     
    # regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60
     
    # residual correlations
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
'

fit <- bsem(model, data = PoliticalDemocracy, bcontrol = list(cores = 3))
summary(fit, neff = TRUE)
plot(fit, pars = 1:4, plot.type = "trace")
plot(fit, pars = 1:4, plot.type = "acf")
semPaths(fit, "std", fade = FALSE, residuals = FALSE, intercepts = FALSE)
rm(model, fit)
         

# -> example b -----------------------------------------------------------------
# from documentation
# Bayesian approach produce credible intervals, not confidence intervals.
# the overall model fit is assessed by the Laplace approximation of the marginal 
# log-likelihood and the posterior predictive p value (PPP; should be ideally >.05).

model <- 
' 
  visual  =~ x1 + x2 + x3
  textual =~ x4 + x5 + x6
  speed   =~ x7 + x8 + x9 
'

fit <- bcfa(model, data = HolzingerSwineford1939)
fit <- blavaan(model, data = HolzingerSwineford1939,
              auto.var = TRUE, auto.fix.first = TRUE,
              auto.cov.lv.x = TRUE)
summary(fit)
summary(fit, neff = TRUE)
plot(fit, pars = 1:4, plot.type = "trace")
plot(fit, pars = 1:4, plot.type = "acf")
coef(fit)
semPaths(fit, "std", fade = FALSE, residuals = FALSE, intercepts = FALSE)
rm(model, fit)


# EXTRA ------------------------------------------------------------------------
# NETCoupler package: network analysis of high-dimensional omics data
# ref: https://netcoupler.github.io/NetCoupler/index.html
# ref: https://github.com/NetCoupler/NetCoupler


# END --------------------------------------------------------------------------

sessionInfo()
