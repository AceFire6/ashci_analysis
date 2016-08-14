data = read.csv("ptgmixed.csv")
View(data)

data$Subject = factor(data$Subject)

summary(data)

library(plyr)
ddply(data, ~ Device * Cursor, function(d) summary(d$Errors))
ddply(data, ~ Device * Cursor, summarize, Errors.mean=mean(Errors), Errors.sd=sd(Errors))

boxplot(Errors ~ Cursor * Device, data=data, ylab="Errors")
with(data, interaction.plot(Cursor, Device, Errors, ylim=c(0, max(data$Errors)))) # interaction plot

# libraries for GLMMs with Poisson regression we'll use on Errors
library(lme4) # for glmer
library(car) # for Anova

# set sum-to-zero contrasts for the Anova call
contrasts(data$Cursor) <- "contr.sum"
contrasts(data$Device) <- "contr.sum"

# main GLMM test on Errors
m = glmer(Errors ~ (Device * Cursor) + (1|Subject), data=data, family=poisson, nAGQ=0)
Anova(m, type=3)

with(data, interaction.plot(Device, Cursor, Errors, ylim=c(0, max(data$Errors)))) # for convenience
library(multcomp) # for glht
library(lsmeans) # for lsm
summary(glht(m, lsm(pairwise ~ Device * Cursor)), test=adjusted(type="holm"))

## ART

library(ARTool) # for art, artlm
m = art(Errors ~ (Device * Cursor) + (1|Subject), data=data) # uses LMM
anova(m) # report anova
shapiro.test(residuals(m)) # normality?
qqnorm(residuals(m)); qqline(residuals(m)) # seems to conform

# conduct post hoc pairwise comparisons within each factor
with(data, interaction.plot(Device, Cursor, Errors, ylim=c(0, max(data$Errors)))) # for convenience
library(lsmeans) # for lsmeans
lsmeans(artlm(m, "Device"), pairwise ~ Device)
lsmeans(artlm(m, "Cursor"), pairwise ~ Cursor)
