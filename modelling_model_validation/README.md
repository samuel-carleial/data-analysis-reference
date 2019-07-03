# Reference guide to statistical analysis
## Modelling: validating statistical models

Everyone can fit a model in R. It is easy like hell. The danger, however, is that one can fit basically anything in R, as long as he/she feeds (correctly or not) the model fit functions with the according arguments. Another completely different issue though is to validate or diagnose the model fit in R. Statistical models have a theoretical background and their assumptions must be respected in order for us to consider them valid. That is, only when a model fit is valid one may reliably interpret the results that pop up from summaries, significance tests or *post hoc* tests originated from the model. Therefore, model validation (or diagnostics) is a crucial step in any serious statistical analysis.

The most common statistical packages in R for model fit I know are *nlme* and *lme4*. There are however, many others such as *arm* (Bayesian approach), *limma* (for micro-array data), *spaMM*, *BUGS*, and many others.

Unfortunately, there is no unique recipe for model validation. From my experience, model validation is made manually, by calculating standardized residuals, and plotting residuals against model predictors, for example. Besides, model validation might also be slightly different, depending on the model type, such as for binomial, count (poisson) our continuous (normal) data., because each has an associated (and different) error distribution and link function.
