### CAUSAL INFERENCE
Cause and association are two different things. With causal inference we try to specifically test causal effects from predictors on outcomes. For this, one may use marginal structural models, consisting of a two-step procedure of first fitting a propensity model for the weights with the exposure as the outcome, then using the inverse of the predicted probabilities (IPW) as weights in a model with just the outcome and exposure. Causal assumptions may be drawn using DAGs (causal directed acyclic graphs).

Another concept of causality deals with confounding factors. Confounding factors are those which "distort" the effect of a given exposure/predictor on an outcome. Can be understood as mediators too. So here, as Rosenbaum and Rubin showed, conditioning on propensity scores in observational studies (contrast from RCT or randomized controlled trials) can lead to unbiased estimates of the exposure effect on the outcome, provided that all confounders are measured and every subject has a nonzero probability of receiving either exposure.

There are several ways to include propensity scores in your final model, namely by: weighting, matching, stratification and direct adjustment. To inspect propensity score one may use love plots (SMD or standardized mean difference: unweighted vs. weighted SMDs) and ECDF (empirical distribution function).

Tools for causal inference:
- Randomized trials
- G-methods...
- Instrumental variables (IV)…

References to read:
- Causal inference (McGuill)
- The Book of Why
- Mastering Metrics
- (Rosenbaum and Ruben)

Steps to take:
- Specify causal question
- Draw assumptions (causal diagram)
- Model assumptions (ex: propensity scores)
- Diagnosticas (analyze propensities)
- Estimate causal effects (IPW; inverse probability weighting)

Packages:
- tidyverse
- ggplot, ggprah, dagitty, ggdag
- broom
- rsamples
