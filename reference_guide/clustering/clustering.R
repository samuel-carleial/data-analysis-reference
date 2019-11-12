
set.seed(23356)
rm(list = ls())

# Regression tree
library("tree")

# Fit a classification or regression tree (tree() documentation)
# A tree is grown by binary recursive partitioning using the response in the 
# specified formula and choosing splits from the terms of the right-hand-side.
see <- tree(curr_agg_re ~ ., data = df) 
plot(see)
summary(see)
text(see)


# END ---------------------------------------------------------------------

sessionInfo()
