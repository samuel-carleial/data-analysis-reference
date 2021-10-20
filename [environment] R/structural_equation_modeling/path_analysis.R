
# Path Analysis

# Samuel Carleial
# Date: 30.01.2021


# lavaan package & derivates  --------------------------------------------------
## preliminaries
set.seed(2537)
rm(list = ls())
library(lavaan)
library(blavaan)
library(semPlot)
library(lavaanPlot)
library(dplyr)

setwd("~/git_projects/data-analysis-reference/[environment] R/structural_equation_modeling")
dataset <- read.csv('dataset.txt', header = TRUE, sep="\t")

# classical example
## The industrialization and Political Democracy Example 
## Bollen (1989), page 332
help("PoliticalDemocracy")

model <- ' 
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
  indirect:= A+C
  
'

fit <- sem(model, data = PoliticalDemocracy)
summary(fit, fit.measures = TRUE)
semPaths(fit, "std", layout="tree2")
lavaanPlot(fit)


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

model <- 
'
  # measurement model
    latent1 =~ X1 + X2 + X3
    latent2 =~ ~ X4 + X5 + X6
    
  # regressions
    outcome ~ latent1 + latent2 + control1 + control2 + control3
  
  # covariance  
    laten1 ~~ latent2
'

## correlation matrix with pairwise relationships
temp <- 
  filter(dataset, sex=='male') %>%
  filter(study != 'pilot_study') %>%
  select(outcome, X1, X2, X3, X4, X5, X6, control1, control2, control3)
temp <- temp %>% cor(method = 'spearman', use = 'pairwise.complete.obs')

## number of complete observation cases
sample_size <- nrow(temp[complete.cases(temp), ])

## fit model
## OBSERVATION: the default estimator works only for continuous data (GLS).
## other estimators accept categorical data, and adjust for robust tests:
## GLS, WLS, DWLS, ULS, WLSM, WLSMVS, ULSM, ULSMVS, ULSMV
## MV" suffixes stand for Mean-Variance, these suffixes come for adjustment
## of estimator methods to robust tests.

fit <- sem(model = model, data = dataset, ordered = NULL, estimator = 'MLR')
fit <- sem(model, 
           sample.cov = temp, 
           sample.nobs = sample_size, 
           estimator = 'ML')

## summaries
summary(fit, fit.measures = TRUE)
fitMeasures(fit)[c('aic', 'chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr')]

## modification indices
modificationindices(fit, minimum.value = 10, sort = TRUE)

## r-squared for all model variables, including outcome
inspect(fit, 'r2')

## plot paths
semPaths(fit, 
         style = 'lisrel', 
         layout = 'tree',
         intercepts = FALSE, 
         residuals = FALSE,
         # node names are ordered, but pay attention to the rotation argument!
         nodeLabels = c('outcome',
                        'latent1',
                        'latent2',
                        '...'),
         # personalize the color of variables
         color = c('tomato', 
                   rep('tan1',2), 
                   ...),
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

## back up code
# summary(fit, standardized = TRUE, fit.measures = TRUE)
# summary(fit, standardized = TRUE, fit.measures = TRUE)$FIT['cfi'] >.95
# parameterEstimates(fit, zstat = FALSE, pvalue = FALSE, boot.ci.type = 'bca.simple')
# anova(fit1, fit2) # to compare models
# semPaths(fit, nodeLabels=, layout=c('tree', 'tree2', 'circle', 'circle2', spring))
# lavaanPlot(fit, labels=)
         

# example 1 ---------------------------------------------------------------
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

fit <- bsem(model, data=PoliticalDemocracy, bcontrol=list(cores=3))
summary(fit, neff=TRUE)
plot(fit, pars=1:4, plot.type="trace")
plot(fit, pars=1:4, plot.type="acf")
semPaths(fit, 'std', fade=F, residuals=FALSE, intercepts=FALSE)
         

# example 2 ---------------------------------------------------------------
# from documentation
# Bayesian approach produce credible intervals, not confidence intervals.
# the overall model fit is assessed by the Laplace approximation of the marginal log-likelihood
# and the posterior predictive p value (PPP; should be ideally >.05).

model <- 
' 
  visual  =~ x1 + x2 + x3
  textual =~ x4 + x5 + x6
  speed   =~ x7 + x8 + x9 
'

fit <- bcfa(model, data=HolzingerSwineford1939)
fit <- blavaan(model, data=HolzingerSwineford1939,
              auto.var=TRUE, auto.fix.first=TRUE,
              auto.cov.lv.x=TRUE)
summary(fit)
summary(fit, neff=TRUE)
plot(fit, pars=1:4, plot.type="trace")
plot(fit, pars=1:4, plot.type="acf")
coef(fit)
semPaths(fit, 'std', fade=F, residuals=FALSE, intercepts=FALSE)
      



# NETCoupler package -----------------------------------------------------------
# ref: https://netcoupler.github.io/NetCoupler/index.html
# ref: https://github.com/NetCoupler/NetCoupler


# END ---------------------------------------------------------------------

sessionInfo()
