# Reference guide to data analysis
## Mediation and Moderation

Investigating the combined effect of predictors on an outcome is not trivial. Commonly we find a situation where not only a direct effect of X on Y exists, but also X is affecting Y after the effect of another variable. In this case, we may have two scenarios: mediation or moderation.

In R, we can test mediation and moderation with the help of some packages. It is also easy to find help by searching on the internet. In a nutshell, mediation can be understood as the effect of one predictor directly towards an outcome, but also throw the effect of a second predictor (M or mediator). Contrastingly, in a moderator scenario we find the direct effect of an interaction of one main predictor and a second predictor (Z or moderator) towards an outcome. The latter can be easily tested by a linear model including an interaction factor. For the former, a few more steps are required.

This topic of mediation and moderation bring to light also another interesting aspect of data analysis: causal inference. Correlation does not mean causality, and when we model an effect of X on Y, we are testing the correlation by using usually a parametric regression analysis. For causal inference, see section: [https://github.com/samuel-carleial/data-analysis-reference/tree/master/%5Breference_guide%5D%20R/causal_inference]

## Packages:
- mediation
- QuantPsyc
- MASS
- rockchalk
