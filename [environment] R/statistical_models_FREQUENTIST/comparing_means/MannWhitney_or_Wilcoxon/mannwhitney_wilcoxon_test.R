
# Mann Whitney or Wilcoxon test
# used for non-parametric comparison of group means
# assumption: independence of data

# Samuel Carleial
# Date: 12.10.2020


## preliminaries
set.seed(2537)
rm(list = ls())

## data
data("women")
data("iris")

?wilcox.test
?t.test
# NOTE: it has the same principle as a t-test. Function arguments are quite similar

# comparison to a reference point -----------------------------------------
# Data: women
help(women)

# Hypothesis: The average American height for women is 65 inches
# visualize data
summary(women$height)
boxplot(women$height)

# formal statistical test
wilcox.test(women$height, mu=65)

# Since p-value is not < .05, we do not reject the null hypothesis in favor
# of the alternative hypothesis (true mean is not equal to 65). Therefore,
# we have statistical evidence to say that the height of American women is 65in


# non-paired t-test -------------------------------------------------------
# Data: iris
help(iris)

# Hypothesis: the sepal length of spp. versicolor and virginica are different

# visualize data
boxplot(iris$sepal.len ~ iris$species)

# formal statistical test
x <- iris[iris$species=="versicolor", "sepal.len"]
y <- iris[iris$species=="virginica", "sepal.len"]
wilcox.test(x, y, paired = FALSE, alternative = "two.sided")

# Our alternative hypothesis is true. There is a statistical difference
# between species of Iris.


# paired t-test -----------------------------------------------------------
# Hypothesis: for the species of versicolor, we believe that the petal length and width
# is different, and length is larger than width.

x <- iris[iris$species=="versicolor", "petal.len"]
y <- iris[iris$species=="versicolor", "petal.wid"]
wilcox.test(x, y, paired = TRUE, alternative = "greater")

# As obvious, legth is indeed larger than width in Iris versicolor petals
# Here, we have a paired test, because the same flower (observational unit),
# was used to assess petal lenth and width. So observations are not independent

         
# END ---------------------------------------------------------------------

sessionInfo()
