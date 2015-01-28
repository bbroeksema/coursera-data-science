# Question 1: Consider the space shuttle data ?shuttle in the MASS library.
# Consider modeling the use of the autolander as the outcome (variable name
# use). Fit a logistic regression model with autolander (variable auto) use
# (labeled as "auto" 1) versus not (0) as predicted by wind sign (variable
# wind). Give the estimated odds ratio for autolander use comparing head winds,
# labeled as "head" in the variable headwind (numerator) to tail winds
# (denominator).

library(MASS)
?shuttle
shuttle$use.binary <- as.integer(shuttle$use == "auto")
fit <- glm(use.binary ~ wind - 1, data = shuttle, family = binomial)

summary(fit)$coef

unname(exp(coef(fit))[1]/exp(coef(fit))[2])

# Question 2: Consider the previous problem. Give the estimated odds ratio for
# autolander use comparing head winds (numerator) to tail winds (denominator)
# adjusting for wind strength from the variable magn.

fit <- glm(use.binary ~ wind + magn - 1, data = shuttle, family = binomial)
exp(coef(fit))
unname(exp(coef(fit))[1]/exp(coef(fit))[2])

# Question 3: If you fit a logistic regression model to a binary variable, for
# example use of the autolander, then fit a logistic regression model for one
# minus the outcome (not using the autolander) what happens to the coefficients?

fit1 <- glm(use.binary ~ wind + magn - 1, data = shuttle, family = binomial)
fit2 <- glm(1 - use.binary ~ wind + magn - 1, data = shuttle, family = binomial)

coef(fit1)
coef(fit2)

# Signs invert

# Question 4: Consider the insect spray data InsectSprays. Fit a Poisson model
# using spray as a factor level. Report the estimated relative rate comapring
# spray A (numerator) to spray B (denominator).

fit <- glm(count ~ spray - 1, data = InsectSprays, family = poisson)
coef.exp <- exp(coef(fit))
unname(coef.exp[1] / coef.exp[2])

# Question 5: Consider a Poisson glm with an offset, t. So, for example, a model
# of the form glm(count ~ x + offset(t), family = poisson) where x is a factor
# variable comparing a treatment (1) to a control (0) and t is the natural log
# of a monitoring time.

# What is impact of the coefficient for x if we fit the model
# glm(count ~ x + offset(t2), family = poisson) where t2 <- log(10) + t? In
# other words, what happens to the coefficients if we change the units of the
# offset variable. (Note, adding log(10) on the log scale is multiplying by 10
# on the original scale.)

x <- seq(1, 1000, by = 1)
t <- log(x)
t2 <- log(10) + t
y <- ppois(x, 2)

fit1 <- glm(y ~ x + offset(t), family = poisson, data = InsectSprays)
fit2 <- glm(y ~ x + offset(t2), family = poisson, data = InsectSprays)

summary(fit1)$coef
summary(fit2)$coef

# The coefficient is subtracted by log(10).

# Apparently this is not the right approach, as the answer I get is not correct.
# It's not clear to me what is supposed to be correct.

# Question 6: Consider the data

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)

# Using a knot point at 0, fit a linear model that looks like a hockey stick
# with two lines meeting at x=0. Include an intercept term, x and the knot point
# term. What is the estimated slope of the line after 0?

# Copy from the slides, adapt the knnot point
knots <- c(0)
splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot))
xMat <- cbind(1, x, splineTerms)
model <-lm(y ~ xMat - 1)
yhat <- predict(model)
plot(x, y, frame = FALSE, pch = 21,bg = "lightblue", cex = 2)
lines(x, yhat, col = "red", lwd = 2)

summary(model)

# To calculate the slope from a line: (y2 - y1) / (x2 - x1). We're interested in
# predicted values from (x in 0..5). So we take the predicted values yhat for
# x = 5 and yhat for x = 0.

unname((yhat[11] - yhat[6]) / (5 - 0))

# [1] 1.013067

