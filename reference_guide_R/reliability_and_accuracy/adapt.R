# (6) Regression to the mean (RTM): estimates -----------------------------
# select data to plot
fig <- data %>% mutate(treat = ifelse(group == "treatment", "NET", "TAU"),
                       pssi0 = log1p(pssi_sum_t0),
                       pssi3 = log1p(pssi_sum_t3),
                       aas0 = log1p(aas_sum_t0),
                       aas3 = log1p(aas_sum_t3),
                       phq0 = log1p(phq_sum_t0),
                       phq3 = log1p(phq_sum_t3),
                       agg0 = log1p(aggression_sum0),
                       agg3 = log1p(aggression_sum3),
                       z_aags0 = log1p(aags0),
                       z_aags3 = log1p(aags3),
                       saq0 = log1p(saq_sum_t0),
                       saq3 = log1p(saq_sum_t3)) %>%
  select(treat, pssi0, pssi3, aas0, aas3, phq0, phq3,
         agg0, agg3, z_aags0, z_aags3, saq0, saq3)

# pssi
RTM1 <-  ggplot(aes(x = pssi0, y = pssi3 - pssi0, colour = treat),
                data = fig) +
  geom_point(alpha = .5) +
  geom_smooth(method='lm', formula= y~x, se = FALSE) +
  scale_x_log10() +
  scale_colour_manual(values = c("#7570b3", "#d95f02")) +
  geom_hline(yintercept = 0, color = 'grey') +
  theme_classic() +
  theme(legend.position = "none")
# aas
RTM2 <-  ggplot(aes(x = aas0, y = aas3 - aas0, colour = treat),
                data = fig) +
  geom_point(alpha = .5) +
  geom_smooth(method='lm', formula= y~x, se = FALSE) +
  scale_x_log10() +
  scale_colour_manual(values = c("#7570b3", "#d95f02")) +
  geom_hline(yintercept = 0, color = 'grey') +
  theme_classic() +
  theme(legend.position = "none")
# phq
RTM3 <-  ggplot(aes(x = phq0, y = phq3 - phq0, colour = treat),
                data = fig) +
  geom_point(alpha = .5) +
  geom_smooth(method='lm', formula= y~x, se = FALSE) +
  scale_x_log10() +
  scale_colour_manual(values = c("#7570b3", "#d95f02")) +
  geom_hline(yintercept = 0, color = 'grey') + 
  theme_classic() +
  theme(legend.position = "none")
# current aggression
RTM4 <-  ggplot(aes(x = agg0, y = agg3 - agg0, colour = treat),
                data = fig) +
  geom_point(alpha = .5) +
  geom_smooth(method='lm', formula= y~x, se = FALSE) +
  scale_x_log10() +
  scale_colour_manual(values = c("#7570b3", "#d95f02")) +
  geom_hline(yintercept = 0, color = 'grey') +
  theme_classic() +
  theme(legend.position = "none")
# z_aags
RTM5 <-  ggplot(aes(x = z_aags0, y = z_aags3 - z_aags0, colour = treat),
                data = fig) +
  geom_point(alpha = .5) +
  geom_smooth(method='lm', formula= y~x, se = FALSE) +
  scale_x_log10() +
  scale_colour_manual(values = c("#7570b3", "#d95f02")) +
  geom_hline(yintercept = 0, color = 'grey') +
  theme_classic() +
  theme(legend.position = "none")
# saq
RTM6 <-  ggplot(aes(x = saq0, y = saq3 - saq0, colour = treat),
                data = fig) +
  geom_point(alpha = .5) +
  geom_smooth(method='lm', formula= y~x, se = FALSE) +
  scale_x_log10() +
  scale_colour_manual(values = c("#7570b3", "#d95f02")) +
  geom_hline(yintercept = 0, color = 'grey') +
  theme_classic() +
  theme(legend.background = element_rect(fill="gray95", size=.3),
        legend.justification = c(1,1), legend.position = c(1,1))

result_figure4_rtm <- grid.arrange(RTM1, RTM2, RTM3, 
                                   RTM4, RTM5, RTM6,
                                   ncol = 3)
rm(fig, RTM1, RTM2, RTM3, RTM4, RTM5, RTM6)



names(data)
kibumba$agg_su

df <- data %>%
  dplyr::select(code, group, 
    lev_sum, pssi_sum_t0, aas_sum_t0, aggression_sum0)

df$code <- sub(" +$", "", df$code)
head(df)

names(df) <- c("id", "group", "lev_sum", "pssi_sum_t0", "aas_sum_t0", "aggression_sum_t0")
write_csv(df, "plot3d.csv")
