library("lme4")
library("memisc")
library(effects)

data("Arabidopsis")
head(Arabidopsis)

MCompleto <- 
  glmer(total.fruits~ 
          + status + amd + nutrient 
        + reg + (1|rack) + (1|popu)
        , family = "poisson"
       , data = Arabidopsis)

M1 <- update(MCompleto, .~. -status)
M2 <- update(MCompleto, .~. -amd)

anova(MCompleto, M1)
anova(MCompleto, M2)

plot(allEffects(MCompleto))

summary(MCompleto)
library(multcomp)
summary(glht(MCompleto, linfct = mcp("status" = "Tukey")))

MCompleto
CI <- confint(MCompleto)


par(mfrow = c(1,2))
plot(fitted(MCompleto) ~ Arabidopsis$status)
plot(fitted(MCompleto) ~ Arabidopsis$nutrient)
abline(lm(Arabidopsis$total.fruits ~ Arabidopsis$nutrient), col = "red")

