# Reference guide to statistical analysis
## Path analysis

Path analyses are used when we want to assess the network relationship between several variables that are timely ordered (must not cause each other) and go into one final direction. There are plenty of tutorials in R that show how to code simple path analysis models. They basically use the lavaan and semPlot packages. The first is used to fit the model, based on the whole dataset or a covariance matrix. The second is used to plot a visual representation of the model with arrows indicating the directions with their respective effects.

General steps in a path analysis:

1- select dataset + variables
2- build correlation matrix
3- calculate the sample size for complete cases (no NAs)
4- build the relationship model, a string variable, with all variables and their predictors, being the main variable of importance (the final node in the network, i.e., latent variable) being directly or indirectly explained by the other variables included.
5- calculate the path analysis effects using the sem() function
6- check model estimates. There are several measures of fit (as default usually a maximum-likelihood, ML), such as Chi-square (p-value should be >.05), the Root Mean Square Error of Approximation (RMSEA) or the Comparative Fit Index (CFI).
7- represent the path analysis visually using the semPaths() function
