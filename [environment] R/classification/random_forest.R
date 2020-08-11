
set.seed(1234)

library('party')
library('caret')
library('caTools')
library('randomForest')
library('randomForestExplainer')

# Regression tree
library("tree")

# Fit a classification or regression tree (tree() documentation)
# A tree is grown by binary recursive partitioning using the response in the 
# specified formula and choosing splits from the terms of the right-hand-side.
see <- tree(curr_agg_re ~ ., data = df) 
plot(see)
summary(see)
text(see)


# NOTES:
# (1) if response is categorical/continuous, the random forest will be of type
# classification or regression, respectively.
# (2) the function may be set as a string or predictor may be added as a matrix
# (3) mtry is the number of random predictors used. Default = sqrt(predictor nr.)
#     ntree is the number of trees. Default = 500. Use odd numbers to avoid split bias
  
# Preliminaries: prepare data
data <- AA_ALPHABET
# Split data into train and test
sample = sample.split(data$y, SplitRatio = .75)
train = data[sample, ]
test  = data[!sample, ]


# Cross validation for measuring the prediction performance of models when using
# different number of predictors. Helpful to use for selecting the nr. of predictors
# ref: https://stats.stackexchange.com/questions/112556/random-forest-need-help-understanding-the-rfcv-function

par(mfrow=c(2,3))
steps <- c(.25, .50, .75, .80, .95, .99)
step <- c()
for (step in steps) {
  check <- rfcv(trainx = train,
                trainy = data[sample, y],
                scale = 'log',
                step = step)
  plot(check$n.var, check$error.cv, 
       ylim=c(.4,.7), xaxt='none', log='x', type='l', lwd=1, main=paste('step=',step))
  axis(1, check$n.var, las=2, cex.axis=.5)
}
check$error.cv #example
rm(step, steps, sample, train, test)

# -> tuneRF before main function ------------------------------------------

#nr_x <- floor(sqrt(ncol(train))) # convention
nr_x <- 30 # based on the rfcv plots above
combn(length(cpgs_intersect), 30) # the total nr. of combinations is too large

# how many cpgs as predictors to use in the models?
# NOTE: the results are very unstable. Each time we run, results change quite a bit
par(mfrow=c(1,3))
tuneRF(train_test1, pheno_BL$phenotype_treatment[sample_test1], 
       stepFactor=1.5, mtryStart = nr_x); title(main='treat')


# Main random forest function
#forest <- randomForest()
forest <- cforest(formula,
                  controls = cforest_unbiased(mtry = ,
                                              ntree = ),
                  importance = TRUE,
                  localImp = TRUE,
                  proximity = TRUE,
                  data = train,
                  )

# Compute conditional variable importance and other estimates

vic <- varimp(forest, conditional = TRUE)

print(forest)
print(importance(forest, type = 2))

plot(forest)
plot(vic)
varImpPlot(forest)

variable_importance() # function from which package???

# caret package alternative
lmVarImp <- varImp(lm, scale = FALSE)
lmVarImp

# plot random forest tree
# https://stats.stackexchange.com/questions/41443/how-to-actually-plot-a-sample-tree-from-randomforestgettree
# https://stackoverflow.com/questions/23003772/r-random-forest-using-cforest-how-to-plot-tree
# https://stackoverflow.com/questions/19924402/cforest-prints-empty-tree
tr <- prettytree(output.forestB@ensemble[[1]], names(output.forestB@data@get('input')))  
plot(new('BinaryTree', tree=tr, data=output.forestB@data, responses=output.forestB@responses))

plot(ctree(treatment ~ ., data = df), type='simple')

# check how many predictor to use in random forest
# https://stats.stackexchange.com/questions/112556/random-forest-need-help-understanding-the-rfcv-function
data(fgl, package='MASS')
tst <- rfcv(trainx = fgl[,-10], trainy = fgl[,10], scale = 'log', step=0.7)
tst$error.cv
