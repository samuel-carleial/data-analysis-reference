###########################################################################
### Data Analysis template    											                    ###
###########################################################################

# Author: 		  Samuel Carleial
# Description: 	...
# Last update: 	YYYY.MM.DD

###########################################################################
### Preliminaries 														                          ###
###########################################################################

setseed(233562)
rm(list = ls())
getwd()
setwd()
library()
source()

###########################################################################
### Load Data 															                            ###
###########################################################################

data <- read.csv(".csv")

###########################################################################
### (1) Data inspection and wrangling 									                ###
###########################################################################



## example code
## Inspect data
head()
summary()
pairs()
apply(, 1, function(x) return(sum(is.na(x))) )
all.equal()
identical()
table()
prop.table(table())
vector1 %in% vector2
sixPlot()

## Modify or recode data
df[df$ == oldValue, "variableOfInterest"] <- newValue
ifelse(condition, valueIF, valueELSE)
df$newVariable <- c(newVariable)
df$remVariable <- NULL
stopifnot()

###########################################################################
### (2) Summary statistics 												                      ###
###########################################################################



## example code
cor()
t.test(x = ,
       y = ,
       alternative = c("two.sided","less","greater"),
       paired = FALSE,
       var.equal = FALSE,
       conf.level = .95)
summary()

###########################################################################
### (3) Data visualization: plots										                    ###
###########################################################################


## example code
par(mfrow = c(rows,cols))

ggplot(aes (y = , x = , fill = , color = ),
       data = ) +
  labs(title = "",
       subtitle = "",
       y = "",
       x = "") +
  geom_...() +
  geom_smooth(method = "loess") +
  theme_classic()

pdf(file = "", width = , height = )
plot(1)
dev.off()

###########################################################################
### (4) Statistical modeling 											                      ###
###########################################################################



## example code
model <- lmer(y ~
            + x1
            + x2
            + x3
            + (1|random1)
            + (1|random2),
            family = ,
            control = ,
            weights = ,
            offset = ,
            data = )

summary()
drop1(, test = "Chisq")
AIC()
anova()
plot()

###########################################################################
### (5) Save data		 														                              ###
###########################################################################



## example code
save(, file = "")
load("")

###########################################################################
### ( ) Test area 														                          ###
###########################################################################



###########################################################################

sessionInfo()
