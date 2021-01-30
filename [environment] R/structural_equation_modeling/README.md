# Reference guide to data analysis
## Path analysis

Path analyses are used when we want to assess the causal relationship (network) among several correlated variables, usually graphically representing it in a diagram of variables and arrows. It can be seen as a closed system of nested relationships assumed to be causal, linear and additive. Actually, the assumptions for a path analysis are pretty much a copy of a those from linear regression, given that path analyses do rely on linear regressions to assess the importance of the relationships. Besides, the relationships assessed in a path analysis model should be timely ordered, and they should go into one direction. Path analyses are recursive (i.e., do not allow feedback loops or reciprocal causes). Regarding the variables included in a path analysis, these might be of two types: exogenous (X: the independent variables which might have correlations among each other Xs) or endogenous (Y: the dependent variable). Exogenous variables might be continuous, binomial or categorical and should have been measured without error, whereas as endogenous variables are coupled with error terms that are uncorrelated with other error terms. Additionally, in path analysis, there is the option to create endogenous variable constructs (latent variable), which are produced by measured variables observed in the study (Ex: psychopatology, which is a product of PTSD and depression; the latter two were measured in the study, but the first one is a theoretical group formed by the latter, and it was not calculated in the first place during the study conduction). Path diagrams are made of nodes (variables) and edges (paths). Mediation information can be incorporated.

In R, there are plenty of tutorials that show how to code simple path analysis models. They basically use the **lavaan** and **semPlot** packages. The first is used to fit the model, based on the whole dataset or a covariance matrix. The second is used to plot a visual representation of the model with arrows indicating the directions with their respective effects.

General steps in a path analysis in R:
1) Select the dataset and variables
2) Build the associated correlation matrix (optional)
3) Calculate the sample sizes for complete cases (optional)
4) Build the relationship model as a string object. This contains all variables and their relationships
5) Fit the model using sem(), but caution, sometimes NAs are not accepted
6) Check model diagnostic parameters. There are several measures of fit such as the default ML (maximum-likelihood), Chi-square (p-value should be >.05), Root Mean Square Error of Approximation (RMSEA) or the Comparative Fit Index (CFI)
7) Visually represent the path analysis using semPaths()

## Packages:
- sem
- lavaan
- blavaan
- semPlot
