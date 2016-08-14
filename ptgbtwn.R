data = read.csv("ptgbtwn.csv")
View(data)

data$Subject = factor(data$Subject)

summary(data)

library(plyr)
ddply(data, ~ Device * Cursor, function(d) summary(d$Errors))
ddply(data, ~ Device * Cursor, summarize, Errors.mean=mean(Errors), Errors.sd=sd(Errors))

boxplot(Errors ~ Cursor * Device, data=data, ylab="Errors")
with(data, interaction.plot(Cursor, Device, Errors, ylim=c(0, max(data$Errors)))) # interaction plot

library(fitdistrplus)
fit = fitdist(data[data$Cursor == "point" & data$Device == "mouse",]$Errors, "pois", discrete=TRUE)
gofstat(fit) # goodness-of-fit test
fit = fitdist(data[data$Cursor == "point" & data$Device == "touchpad",]$Errors, "pois", discrete=TRUE)
gofstat(fit) # goodness-of-fit test
fit = fitdist(data[data$Cursor == "point" & data$Device == "trackball",]$Errors, "pois", discrete=TRUE)
gofstat(fit) # goodness-of-fit test
fit = fitdist(data[data$Cursor == "area" & data$Device == "mouse",]$Errors, "pois", discrete=TRUE)
gofstat(fit) # goodness-of-fit test
fit = fitdist(data[data$Cursor == "area" & data$Device == "touchpad",]$Errors, "pois", discrete=TRUE)
gofstat(fit) # goodness-of-fit test
fit = fitdist(data[data$Cursor == "area" & data$Device == "trackball",]$Errors, "pois", discrete=TRUE)
gofstat(fit) # goodness-of-fit test
fit = fitdist(data[data$Cursor == "bubble" & data$Device == "mouse",]$Errors, "pois", discrete=TRUE)
gofstat(fit) # goodness-of-fit test
fit = fitdist(data[data$Cursor == "bubble" & data$Device == "touchpad",]$Errors, "pois", discrete=TRUE)
gofstat(fit) # goodness-of-fit test
fit = fitdist(data[data$Cursor == "bubble" & data$Device == "trackball",]$Errors, "pois", discrete=TRUE)
gofstat(fit) # goodness-of-fit test

contrasts(data$Cursor) <- "contr.sum"
contrasts(data$Device) <- "contr.sum"

m = glm(Errors ~ Cursor * Device, data=data, family=poisson)
Anova(m, type=3)

library(multcomp) # for glht
library(lsmeans) # for lsm
summary(glht(m, lsm(pairwise ~ Device * Cursor)), test=adjusted(type="holm"))
