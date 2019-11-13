# Reference guide to statistical analysis
## Path analysis

General introduction:
Path analyses are used when we want to assess the causal relationship (network) among several variables, usually graphically representing it in a diagram of variables and arrows. It can be seen as a closed system of nested relationships assumed to be causal, linear and additive. Actually, the assumptions for a path analysis prety much are a copy of a those from linear regression, given that path analyses do rely on linear regressions to assess the importance of the relationships. Besides, the relationships assessed in a path analysis model should be timely ordered, and they should go into one direction. A final endpoint is commonly referred to as a latent variable. That is, path analyses are recursive (i.e., do not allow feedback loops or reciprocal causes). Regarding the variables included in a path analysis, these might be of two types: exogenous (X: the independent variables which might have correlations among each other Xs) or endogenous (Y: the dependent variable). Exogenous variables might be continuous, binomial or categorical and should have been measured without error, whereas as endogenous variables are coupled with error terms that are uncorrelated with other error terms.

Path analysis in R:
There are plenty of tutorials that show how to code simple path analysis models in R. They basically use the **lavaan** and **semPlot** packages. The first is used to fit the model, based on the whole dataset or a covariance matrix. The second is used to plot a visual representation of the model with arrows indicating the directions with their respective effects.

General steps of a path analysis in R:
1) Select the dataset and variables
2) Build the associated correlation matrix
3) Calculate the sample sizes for complete cases (no NAs allowed!)
4) Build the relationship model: a string variable containing all variables and predictors, being the main variable of importance (the final node in the network or the latent variable) which is directly or indirectly explained by the other variables included)
5) Calculate the path analysis effects using sem()
6) Check the model estimates. There are several measures of fit such as the default ML (maximum-likelihood), Chi-square (p-value should be >.05), Root Mean Square Error of Approximation (RMSEA) or the Comparative Fit Index (CFI)
7) Visually represent the path analysis using semPaths()
