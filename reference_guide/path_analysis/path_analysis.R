
# Path Analysis

# Samuel Carleial
# Date: 22.06.2019


## preliminaries
set.seed(2537)
rm(list = ls())
library(lavaan)
library(semPlot)
library(dplyr)

## data
dataset <- read.csv("dataset.csv", header = TRUE, sep = ",")


# Path analysis model fit and summary -------------------------------------

## model
## NOTE: the model is conceptually based on your hypothesis/theory background
model <- "output_variable ~ height + mass + age + covariate_1
\n mass ~ height + age
\n age ~ covariate_1"

## correlation matrix with pairwise relationships
temp <- 
  filter(dataset, sex=="male") %>%
  filter(study != "pilot_study") %>%
  select(output_variable, height, mass, age, covariate_1)
temp <- temp %>% cor(method = "spearman", 
                     use = "pairwise.complete.obs")

## number of complete observation cases
sample_size <- nrow(temp[complete.cases(temp), ])

## fit model
fit_temp <- sem(model, 
                sample.cov = temp, 
                sample.nobs = sample_size, 
                estimator = "ML")
summary(m4fit_m, fit.measures = TRUE)


# Path analysis model visualization ---------------------------------------

## plot paths
semPaths(fit_temp, 
         style = "lisrel", 
         layout = "tree",
         intercepts = FALSE, 
         residuals = FALSE,
         # node names are ordered, but pay attention to the rotation argument!
         nodeLabels = c("output_variable",
                        "height",
                        "mass",
                        "age",
                        "covariate_1"),
         # personalize the color of variables
         color = c("tomato", 
                   rep("tan1",2), 
                   rep("azure",2)),
         whatLabels = "std", 
         edge.label.cex = .8,
         label.prop=.9, 
         edge.label.color = "black", 
         rotation = 2, 
         equalizeManifests = TRUE, 
         optimizeLatRes = TRUE, 
         node.width = 2.5, 
         edge.width = 0.5, 
         shapeMan = "circle", 
         shapeLat = "ellipse", 
         shapeInt = "triangle", 
         sizeMan = 4, 
         sizeInt = 2, 
         sizeLat = 4, 
         curve=4, 
         unCol = "black", 
         # set margins of plot to fit all information in the pane
         mar = c(2,6,6,11))
         title(paste0("Path Analysis\nExample 1 (", sample_size, ")"))

# END ---------------------------------------------------------------------

sessionInfo()
