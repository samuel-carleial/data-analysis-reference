# Reference guide to data analysis
## Modelling: predicting model effects

The main function of statistical models is to test the likelihood of hypothesis of being true. Usually, based on results of statistical models, we may have sufficient confidence to say whether a specific predictor variable is strongly affecting ("significance" is what commonly sticks into the jargon) the variation in a response variable.

The bottom line is that this (significant; *urgh*) effect - let us say of X on Y - is what the statistician or experimenter is looking to assess. We may understand effect as the direction and intensity of X on Y, which may assume a linear or non-linear behavior. For example, taking a specific drug (X), may increase the incidence of a particular disorder (Y) linearly by a 2-fold relationship in a particular human sample.

Additionally, not only we may be interested in knowing the X:Y relationship, but also we may be willing to predict or extrapolate the above-mentioned results to a particular scenario which might be of biological or whatever other importance. For example, we know that the drug above positively induced an increment in a disorder occurrence. Yet, how much would we expect if the drug was taken at a particular dose only? If we were to have a more complex model testing for gender, age or other variables, what would we expect to find for a men with 20 years of age within a range A to B for the drug X?

Statistical modeling, model effect interpretations and model effect predictions constitute an important part of data analysis in science or related fields that use statistical models to test hypothesis and investigate quantitative data. In R, some packages might help us visualize model effects (e.g., **effects**) and predict results (built-in functions in the **stats**).

## Packages:
