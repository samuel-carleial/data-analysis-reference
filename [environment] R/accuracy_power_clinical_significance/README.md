# Reference guide to data analysis
## Accuracy, Power and Reliability

### STATISTICAL POWER
Statistical power ranges from 0 to 1, because it is a probability estimate. It is the probability that we will correctly reject the null hypothesis. It is used to evaluate scenarios and to help guide decisions or even interpret results. It depends on the true population difference and variance. Is determined by four main parameters:
- effect size
- sample size
- power (by convention 0.80)
- significance level (by convention alpha=0.05)

Effect size is based on the population, not the sample, so power calculations require that you estimate it from your knowledge of the subject. Effect sizes may be extracted from t-tests, ANOVAs, parametric correlations, linear models and Chi-squared-tests.

Do not use observed effect size for post-hoc power, because it does not reliably reflect the true effect size from the population.


## Packages:
