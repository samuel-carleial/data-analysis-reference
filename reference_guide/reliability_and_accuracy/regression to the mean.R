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