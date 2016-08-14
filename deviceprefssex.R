data = read.csv('deviceprefssex.csv')
View(data)

data$Subject = factor(data$Subject)
data$Disability = factor(data$Disability)

summary(data)

plot(data[data$Disability == 0,]$Pref, xlab="Preference for M.0", ylab="n")
plot(data[data$Disability == 1,]$Pref, xlab="Preference for M.1", ylab="n")
plot(data[data$Sex == "F" & data$Disability == 0,]$Pref, xlab="Preference for F.0", ylab="n")
plot(data[data$Sex == "F" & data$Disability == 1,]$Pref, xlab="Preference for F.1", ylab="n")

library(nnet) # for multinom
library(car) # for Anova

# set sum-to-zero contrasts for the Anova call
contrasts(data$Sex) <- "contr.sum"
contrasts(data$Disability) <- "contr.sum"
contrasts(data$Pref) <- "contr.sum"

m = glm(Pref ~ Sex * Disability, data=data, family=binomial)
Anova(m, type=3)

m = multinom(Pref ~ Sex * Disability, data=data) # multinomial logistic
Anova(m, type=3) # note: not "anova" from stats pkg
