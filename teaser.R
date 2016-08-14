data = read.csv("teaser.csv")
View(data)

data$Subject = factor(data$Subject)
data$Order = factor(data$Order)
data$Liked = factor(data$Liked)

summary(data)

library(plyr)
ddply(data, ~ Teaser, function(d) summary(d$Liked))

library(lme4) # for glmer
library(car) # for Anova

# set sum-to-zero contrasts for the Anova call
contrasts(data$Teaser) <- "contr.sum"
contrasts(data$Order) <- "contr.sum"
contrasts(data$Liked) <- "contr.sum"

m = glmer(Liked ~ Order + (1|Subject), data=data, family=binomial, nAGQ=0)
Anova(m, type=3)

# main GLMM test on Liked
m = glmer(Liked ~ Teaser + (1|Subject), data=data, family=binomial, nAGQ=0)
Anova(m, type=3)


