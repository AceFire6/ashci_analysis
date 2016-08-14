data = read.csv("vocab.csv")
View(data)

data$Subject = factor(data$Subject)
data$Order = factor(data$Order)

summary(data)

library(plyr)
ddply(data, ~ Sex * Social, function(d) summary(d$Vocab))
ddply(data, ~ Sex * Social, summarise, Vocab.mean=mean(Vocab), Vocab.sd=sd(Vocab))

boxplot(Vocab ~ Sex * Social, data=data)

library(MASS)
fit = fitdistr(data[data$Social == "Facebook",]$Vocab, "exponential")$estimate
ks.test(data[data$Social == "Facebook",]$Vocab, "pexp", fit, exact=TRUE)

fit = fitdistr(data[data$Social == "Gplus",]$Vocab, "exponential")$estimate
ks.test(data[data$Social == "Gplus",]$Vocab, "pexp", fit, exact=TRUE)

fit = fitdistr(data[data$Social == "Twitter",]$Vocab, "exponential")$estimate
ks.test(data[data$Social == "Twitter",]$Vocab, "pexp", fit, exact=TRUE)

library(lme4) # for glmer
library(car) # for Anova

# set sum-to-zero contrasts for the Anova call
contrasts(data$Sex) <- "contr.sum"
contrasts(data$Social) <- "contr.sum"
contrasts(data$Order) <- "contr.sum"

m = glmer(Vocab ~ Order + (1|Subject), data=data, family=Gamma(link="log"), nAGQ=0)
Anova(m, type=3)

# main GLMM test on Liked
m = glmer(Vocab ~ Sex * Social + (1|Subject), data=data, family=Gamma(link="log"), nAGQ=0)
Anova(m, type=3)
