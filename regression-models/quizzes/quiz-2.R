# Question 1 (FALSE)
# Consider the following data with x as the predictor and y as as the outcome.
# Give a P-value for the two sided hypothesis test of whether β1 from a linear
# regression model is 0 or not.

x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
n <- length(y)

beta1 <- cor(y, x) * sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
yhat <- beta0 + beta1 * x
e <- y - yhat        # residuals
sigma <- sqrt(sum(e^2) / (n - 2))
ssx <- sum((x - mean(x))^2)
seBeta0 <- (1 / n + mean(x) ^ 2 / ssx) ^ .5 * sigma
seBeta1 <- sigma / sqrt(ssx)
tBeta0 <- beta0 / seBeta0; tBeta1 <- beta1 / seBeta1
pBeta0 <- 2 * pt(abs(tBeta0), df = n - 2, lower.tail = FALSE)
pBeta1 <- 2 * pt(abs(tBeta1), df = n - 2, lower.tail = FALSE)

# Question 2
# Consider the previous problem, give the estimate of the residual standard
# deviation.

sigma

# Question 3 (FALSE)
# In the mtcars data set, fit a linear regression model of weight (predictor) on
# mpg (outcome). Get a 95% confidence interval for the expected mpg at the
# average weight. What is the lower endpoint?

rm(list=ls()) # clean environment

data(mtcars)
fit <- lm(mtcars$mpg ~ mtcars$wt)
sumCoef <- summary(fit)$coefficients
sumCoef[1,1] + c(-1,1) * qt(.975, df = fit$df) * sumCoef[1, 2]
sumCoef[2,1] + c(-1,1) * qt(.975, df = fit$df) * sumCoef[2, 2]

# [1] -6.486308 -4.202635
# With With 95% confidence, we estimate that a 1000 lb increase in car weight
# results in a 4.20 to 6.48 decrease in MPG.

# Question 4
# Refer to the previous question. Read the help file for mtcars. What is the
# weight coefficient interpreted as?

?mtcars

# The estimated expected change in mpg per 1000 lb increase in weight.

# Question 5
# Consider again the mtcars data set and a linear regression model with mpg as
# predicted by weight (1,000 lbs). A new car is coming weighing 3000 pounds.
# Construct a 95% prediction interval for its mpg. What is the upper endpoint?

rm(list=ls()) # clean environment

fit <- lm(mpg ~ wt, data = mtcars)
predict(fit, data.frame(wt = 3), interval="prediction")

# Question 6
# Consider again the mtcars data set and a linear regression model with mpg as
# predicted by weight (in 1,000 lbs). A “short” ton is defined as 2,000 lbs.
# Construct a 95% confidence interval for the expected change in mpg per 1 short
# ton increase in weight. Give the lower endpoint.

rm(list=ls()) # clean environment
fit <- lm(mpg ~ I(wt / 2), data = mtcars)
coef <- summary(fit)$coefficients
mean <- coef[2,1] 
stderr <- coef[2,2]
df <- fit$df
#Two sides T-Tests
mean + c(-1,1) * qt(0.975, df = df) * stderr


# Question 7
# If my X from a linear regression is measured in centimeters and I convert it
# to meters what would happen to the slope coefficient?

# It would get multiplied by 100.

# Question 8
# I have an outcome, Y, and a predictor, X and fit a linear regression model
# with Y = β0 + β1X + ϵ to obtain β^0 and β^1. What would be the consequence to
# the subsequent slope and intercept if I were to refit the model with a new
# regressor, X+c for some constant, c?

rm(list=ls()) # clean environment
x <- mtcars$wt
y <- mtcars$mpg
fit <- lm(y ~ x)
c <- 5 # some constant
fit2 <- lm(y ~ I(x + c))

beta0 <- c(fit$coefficients[1], fit2$coefficients[1])
beta1 <- c(fit$coefficients[2], fit2$coefficients[2])
beta0; beta1

# We find that the slope is the same, but that the intercept changed.
# Next we find that:
all.equal(beta0[2], beta0[1] - c * beta1[1]) # TRUE

# Question 9
# Refer back to the mtcars data set with mpg as an outcome and weight (wt) as
# the predictor. About what is the ratio of the the sum of the squared errors,
# ∑ni=1(Yi−Y^i)2 when comparing a model with just an intercept (denominator) to
# the model with the intercept and slope (numerator)?

rm(list=ls()) # clean environment
y <- mtcars$mpg; x <- mtcars$wt
fitWithIntercept <- lm(y ~ x)

yhat1 <- fit$coefficients[1] + x
se1 <- sum((y - yhat1)^2)

yhat2 <- fit$coefficients[1] + fit$coefficients[2] * x
se2 <- sum((y - yhat2)^2)

ratio <- se2 / se1

# Question 10
# Do the residuals always have to sum to 0 in linear regression?

# If an intercept is included, then they will sum to 0.
