# Reference guide to data analysis
## Modelling: robust regression

Sometimes, few datapoints behave completely different from the other datapoints in a dataset. These are usually called outliers. The line that delimits a datapoint of being considered an outlier, however, may be very loose. Thus, when we talk about outliers and whether they should be excluded or not from an analysis may be a critical issue. Personally, I do not recommend the removal of outliers, provided that the data has been correctly gathered.

In any case, there are statistical methods that account for the effect of those odd observations, fitting linear regressions with less susceptibility to those. Robust linear regressions are one example, and here I selected some example codes to fit a simple two-effect linear regression using this approach.

## Packages:
