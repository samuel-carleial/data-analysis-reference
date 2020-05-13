
# Path Analysis

# Samuel Carleial
# Date: 16.03.2020


## preliminaries
set.seed(2537)
rm(list = ls())
library(lavaan)
library(semPlot)
library(lavaanPlot)
library(dplyr)

## data
dataset <- read.csv('dataset.csv', header = TRUE, sep = ',')

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
## NOTE: the model is conceptually based on your hypothesis/theory background
# =~ means latent variable
# ~~ means variance / covariance
# ~  means regressed on (explained by)

model <- '
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
# may be fit with raw data or with covariance matrix (exampes below)
fit <- sem(model = model, data = dataset, ordered = NULL, estimator = 'MLR')
fit <- sem(model, 
           sample.cov = temp, 
           sample.nobs = sample_size, 
           estimator = 'ML')

## summaries
summary(fit, fit.measures = TRUE)
fitMeasures(fit)[c('chisq', 'df', 'pvalue', 'cfi', 'rmsea', 'srmr')]

## modification indices
modificationindices(fit, minimum.value = 10, sort = TRUE)

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
         
         
# END ---------------------------------------------------------------------

sessionInfo()
