# Reference guide to statistical analysis
## Mediation and Moderation

Sometimes it is not trivial to investigate the relationship between predictor variables in relation to their combined effect on an outcome variable. Commonly we find a situation where not only a direct effect of X on Y exists, but also X is affecting Y after the effect of another variable. In this case we may have two scenarios: mediation or moderation.

In R, we can test mediation and moderation with the help of some packages. It is also easy to find help by searching on the internet. In a nutshell, mediation can be understood as the effect of one predictor directly towards an outcome, but also throw the effect of a second predictor (M or mediator). Contrastingly, in a moderator scenario we find the direct effect of an interaction of one main predictor and a second predictor (Z or moderator) towards an outcome. The latter can be easily tested by a linear model including an interaction factor. For the former, a few more steps are required.

packages:
- mediation
- QuantPsyc
- MASS
- rockchalk
