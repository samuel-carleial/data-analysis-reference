# Reference guide to fundamentals analysis
## Imputation

Imputation is the process of substituting missing values (or NAs) in a dataset, based on the remaining observations found in the same dataset. This process may be used to maximize sample size and avoid removing important observations, which otherwise would be removed before fitting a linear-mixed model, for instance. However, many may see the process of imputation very critically, and caveats for this procedure are well spread in literature and online forums.

In any case, conducting imputations in R is quite easy and the mice package may be the most famous for that. Be aware that several parameters and fundamentals must be set, in order to most accurately impute data, particularly the method of imputation. There are quite a lot of different options, such as predictive mean matching (pmm, the default), logistic regression, polynomial regression, etc.

## Packages:
