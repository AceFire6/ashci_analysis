# Overview

Below you'll find a description of the datasets for Monday. Included are some
suggestions for analysis that you might need to do. 


# Device pref dataset -- Done

Men and women were recruited for a study to discover which input device they
prefered. Some of the subjects had a disability. Analyze the data to see
how preference differs by different groups.

You'll want to use a binomial regression for this. Create a model with glm 
using family=binomial. Then use the car library and its Anova function with 
type=3, similar to the videos.

You can also multinomial regression with the nnet library and its multinom 
function. Both approaches should give you very similar results since 
multinomial regression is the generalization of binomial regression. Do they?


# Teaser dataset -- Done

Participants were shown teaser trailers for movies and asked whether
or not they enjoyed the teaser. Use a GLMM to analyze this data.

Make sure to test order effects as well as measuring liked by teaser.

Hint: You will want to use the lme4 library and its glmer function 
with family=binomial 


# Vocab dataset

50 recent posts by men and women on social media were analyzed for how many
unique words they used, i.e., the size of their operational vocabulary on 
social media. The research question is how men's and women's vocabulary may 
differ on each of three social media websites. 

Perform three Kolmogorov-Smirnov goodness-of-fit tests on Vocab for each 
level of Social using exponential distributions. What is the lowest p-value 
of these three tests? Hint: Use the MASS library and its fitdistr function on 
Vocab separately for each level of Social. Use "exponential" as the 
distribution type. Save the estimate as a fit. Then use ks.test with "pexp",
passing fit$estimate as the rate and requesting an exact test. 
Ignore any warnings produced about ties.

Use a generalized linear mixed model (GLMM) to conduct a test of order effects 
on Vocab. If there are no problems, use a GLMM to test Vocab by Sex and Social.
For the GLMMs, use the lme4 library and its glmer function with 
family=Gamma(link="log") and Subject as a random effect to build the model.


# Ptgbtwn dataset -- Done

Participants were asked to use different input devices with different cursor
types to complete a series of 100 tasks. The number of errors recorded during
each trial was recorded.

Test if the errors measure fits a poison distribution. Use a GLM to analyze 
errors using a posion distribution regardless of outcome. If appropriate,
run posthoc pairwise comparisons. 


# Ptgmixed dataset -- Done

This dataset is almost the same as the Ptgbtwn dataset, but with one key 
difference, which you will quickly discover.

Participants were asked to use different input devices with different cursor
types to complete a series of 100 tasks. The number of errors recorded during
each trial was recorded.

Using poison regression, run a GLMM on Errors as a scalar response, Cursor 
as a between-subjects nominal factor, Device as a within-subjects nominal factor, 
and Subject as a random effect. 

Also analyze using an ART. Which is more appropriate? Which is more powerful?