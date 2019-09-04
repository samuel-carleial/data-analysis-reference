
# preparation
rm(list = ls())
set.seed(500)
library(mice)   
data <- read.csv("children.csv")

# check data
head(data, 5)
summary(data)

# edit data into binomial format (0: absence; 1:presence)
data <- apply(data[,-1], 2, as.factor)
head(data, 5)
summary(data)

# check the presence of missings across the dataframe
md.pattern(data, rotate.names = TRUE)
sum(is.na(data))
 
# imputation methods present in mice
methods(mice)

# imputation step
# method: "logreg" (for categorical data with two levels: binomial)
# method: "polr" (for categorical data with > 2 levels)
# method: "norm" (for continuous data)

children <- mice(data, m = 1, maxit = 50, meth = "logreg", seed = 500)
summary(children)
plot(children)

# NOTE: the parameter m = defines the number of predicted imputed values.
#       the imputation may produce several possible imputation scenarios.
#       to define those use m and seed, so that results are reproducible.

# extract completed cases (imputed values)
children <- complete(children, 1) # the number 1, selects the first imputation scenario.

sessionInfo()