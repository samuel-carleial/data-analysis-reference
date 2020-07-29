## Regression to the mean
## reads: https://conjointly.com/kb/regression-to-the-mean/
## reads: https://fs.blog/2015/07/regression-to-the-mean/
## reads: https://www.britannica.com/topic/regression-to-the-mean
## reads: https://www.statisticshowto.com/regression-mean/


# Extracted from DataCamp
# ref: https://campus.datacamp.com/courses/correlation-and-regression-in-r/simple-linear-regression?ex=9

# Regression to the mean is a concept attributed to Sir Francis Galton. 
# The basic idea is that extreme random observations will tend to be less extreme 
# upon a second trial. This is simply due to chance alone. "Regression to 
# the mean" and "linear regression" are not the same thing.

# One way to see the effects of regression to the mean is to compare the heights 
# of parents to their children's heights. While it is true that tall mothers and 
# fathers tend to have tall children, those children tend to be less tall than 
# their parents, relative to average. That is, fathers who are 3 inches taller 
# than the average father tend to have children who may be taller than average, 
# but by less than 3 inches.

# The Galton_men and Galton_women datasets contain data originally collected by 
# Galton himself in the 1880s on the heights of men and women, respectively, 
# along with their parents' heights.

# Compare the slope of the regression line to the slope of the diagonal line. 
# What does this tell you?
  
galton <- read.csv("[reference_guide] R/accuracy_power_reliability_analysis/dataset_galton.txt",
                   sep="\t") 

# Height of children vs. height of father
library(dplyr)
library(ggplot2)

df <- galton %>%
  group_by(Family) %>%
  summarise(fat = mean(Father),
            mot = mean(Mother),
            kid = mean(Height))

df <- data.frame("family"=rep(df$Family, 3),
                 "person"=c(rep("father",length(df$fat)),
                            rep("mother",length(df$mot)),
                            rep("kid",length(df$kid))),
                 "height"=c(df$fat, df$mot, df$kid))
df <- df[order(df$family),]

ggplot(data = df, aes(x = family, y = height, color = person, group = person)) +
  geom_point() + 
  geom_smooth(method = "lm", formula = 'y ~ x')

# Height of children vs. height of mother

  


# account for RTM in the statistical tests
# select data
data_model <- data_long[,c("id","treatment","time","pssi")]
data_model <- data_model[complete.cases(data_model),]

## model fit
LMEfull <- lme(pssi ~ treatment + time + treatment*time
               , weights = varIdent(form = ~1 | time)
               , random = list(id = ~1)
               , method = "ML"
               , data = data_model)

# account for RTM



# sample data -------------------------------------------------------------
# data
dt
# log-transform the data
dt$l_betac_b <- log(dt$betac_b)
dt$l_betac_f <- log(dt$betac_f)
# Calculate the baseline mean
meanb <- mean(dt$l_betac_b)
# Difference the baseline mean from every baseline observation
dt$adiff <- dt$l_betac_b - meanb
#ANCOVA using lm
model <- lm(formula = l_betac_f~adiff + group,data = dt)
summary(model)


# trial -------------------------------------------------------------------
dt2 <- data %>% select(id, pssi_sum_t0, pssi_sum_t3)
dt2 <- dt2[complete.cases(dt2),]