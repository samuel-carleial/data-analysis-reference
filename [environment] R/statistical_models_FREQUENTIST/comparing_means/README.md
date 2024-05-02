# Reference guide to data analysis
## Comparing means

We can compare means between paired or non-paired samples. Or we can compare means with a reference point, if we have an specific hypothesis to test. If we assume normality of samples, we should apply a t-test. Otherwise, we should use a Mann Whitney U or Wilcoxon rank sun test (both names refer to the same test), because this only assumes independence of samples.

Student's t-tests are parametric tests that have three assumptions, actually:
- samples are independent
- samples are taken from populations with equal variances (homocedasticity)
- samples are taken from populations with a normal distribution
