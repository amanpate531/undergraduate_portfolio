# Aman Patel
# CSCI-B 365
# April 19, 2021

# Homework 6

################################################################################

# Question 1

# 1a.
data = read.csv('Vocab.csv')
x = data$education
y = data$vocabulary
n = length(x)
X = matrix(c(x, rep(1, n)), ncol = 2)

# 1b. 
coeff_X = solve(t(X) %*% X, t(X) %*% y)
print(coeff_X)
# a = 0.3318736, b = 1.6779393

# 1c.
# Yes, the slope of the regression line (a) is greater than 0, indicating an increase
# in vocabulary as education increases

# 1d. 
# The value of a year of education is shown in the "a" coefficient. For each
# extra year of education, your vocabulary test score is expected to increase by
# 0.3318736

################################################################################

# Question 2

# 2a.
start_point = c(1, 2, 3)
end_point = c(3, 2, 1)
vect = end_point - start_point
d1 = c(1, -1, 2)
d2 = c(5, 4, 0)
d3 = c(1, 1, 1)
D = matrix(c(d1, d2, d3), nrow = 3)
a = solve(D, vect)
print(a)
# c(0.5454545, 0.9090909, -3.0909091)
D %*% a

# 2b.
D2 = matrix(c(d1, d2), ncol = 2)

#  1 5          2 
# -1 4 * b1 =   0
#  2 0   b2    -2 

# 3 eqs, 2 vars
# b1 + 5b2 = 2
# -b1 + 4b2 = 0
# 2b1 = -2

# These equations cannot be solved because all three cannot be satisfied 
# simultaneously for any values of b1 and b2.

# We can estimate b by using the generic method for regression

b = solve(t(D2) %*% D2, t(D2) %*% vect)
print(b)
# c(-0.376, 0.253)
D2 %*% b

################################################################################

# Question 3

# 3a.
M_and_Ms = c(20, 20, 20, 20, 20, 20)
f1 = c(.2, .4, .2, .1, .1, 0)
f2 = c(0, 0, .1, .3, .3, .3)
f3 = c(0, .4, .2, .4, 0, 0)
f4 = c(.3, 0, .3, 0, .3, .1)
factories = matrix(c(f1, f2, f3, f4), nrow = 6)
c = solve(t(factories) %*% factories, t(factories) %*% M_and_Ms)
pounds = factories %*% c
res = M_and_Ms - pounds
sqrt(sum(res^2))

# 3b.
sim_results = runif(1000)
for (i in 1:1000) {
  rand_nums = .1*rnorm(4)
  sim_vect = c + rand_nums
  if (i < 5) {
    print(sim_vect)
    print(sqrt(sum((M_and_Ms - factories %*% sim_vect)^2)))
  }
  res_sim = M_and_Ms - factories %*% sim_vect
  sim_results[i] = sqrt(sum(res_sim^2))
}
print(min(sim_results))
print(sqrt(sum(res^2)))
# The SSE of the simulated data is slightly larger than that of the proposed solution

# 3c.
factories_noEF = matrix(c(f1[1:4], f2[1:4], f3[1:4], f4[1:4]), nrow = 4)
noEF = solve(factories_noEF, M_and_Ms[1:4])
print(as.numeric(noEF))
# c(100, 100, -50, 0)
# Buy 100 lbs from 1 and 2, sell 50 lbs to 3
# End with 20 lbs A, 20 lbs B, 20 lbs C, 20 lbs D, 40 lbs E, 30 lbs F

################################################################################

# Question 4

# 4a.
dat = read.csv("ais.csv",stringsAsFactors=FALSE, sep=",")
response = as.matrix(dat[2])
predictor = as.matrix(dat[3:12])
rcc_solution = solve(t(predictor) %*% predictor, t(predictor) %*% response)
print(rcc_solution)

#                  rcc
# wcc     1.112919e-03
# hc      1.046425e-01
# hg      3.290207e-02
# ferr    3.440278e-05
# bmi    -1.272889e-02
# ssf     3.441954e-03
# pcBfat -9.056660e-03
# lbm     9.588279e-03
# ht     -1.281386e-03
# wt     -6.595720e-03

# 4b.
y_hat = predictor %*% rcc_solution
error = response - y_hat
rcc_sse = sqrt(sum(error^2))
print(rcc_sse)
# 2.430904

# 4c.
sse_omissions = runif(10)
for (i in 1:10) {
  predictor_sim = predictor[,-i]
  sol = solve(t(predictor_sim) %*% predictor_sim, t(predictor_sim) %*% response)
  sse = sqrt(sum((response - predictor_sim %*% sol)^2))
  sse_omissions[i] = sse
}
print(2 + which.max(sse_omissions))

# Omitting variable 4 caused the greatest increase in SSE. Therefore, variable 4
# (hc) appears to be the most important in predicting rcc.

################################################################################

# Question 5

# 5a.
data("nottem")
y = nottem
n = length(y)
x = 1:n
plot(x, y, type="b", pch = 17)

# 5b.
b_col = rep(1, n)
X_nottem = matrix(c(x, b_col), ncol = 2)
coeff = solve(t(X_nottem) %*% X_nottem, t(X_nottem) %*% y)
abline(coeff[2], coeff[1])

# 5c.
plot.new()
plot(x, y, type="b", pch = 17)
cos_col = cos(2 * pi * x / 12)
sin_col = sin(2 * pi * x / 12)
c_col = b_col
X_waves = matrix(c(cos_col, sin_col, c_col), ncol = 3)
coeff_waves = solve(t(X_waves) %*% X_waves, t(X_waves) %*% y)
points(x, X_waves %*% coeff_waves, col = "red", pch = 16)
lines(x, X_waves %*% coeff_waves, col = "red", pch = 16)

# 5d.
plot.new()
plot(x, y, type="b", pch = 17)
X_linear_growth = matrix(c(cos_col, sin_col, c_col, x), ncol = 4)
coeff_linear_growth = solve(t(X_linear_growth) %*% X_linear_growth, t(X_linear_growth) %*% y)
points(x, X_linear_growth %*% coeff_linear_growth, col = "red", pch = 16)
lines(x, X_linear_growth %*% coeff_linear_growth, col = "red", pch = 16)
print(coeff_linear_growth)
# c(-9.245313509, -6.924513489, 48.510318555, 0.004392239)

# The final value in the coefficient vector is ~0.004 > 0, indicating growth
# However, the value is very small, and makes a barely noticeable difference in
# the plot over time.

################################################################################

# Question 6

#6a.
data("AirPassengers")
x = 1:144
y = log(AirPassengers)
plot(x, y, type = "b", pch = 17)
air_sin = sin(2 * pi * x / 12)
air_cos = cos(2 * pi * x / 12)
X_air = matrix(c(air_sin, air_cos, x, rep(1, 144)), ncol = 4)
coeff_air = solve(t(X_air) %*% X_air, t(X_air) %*% y)

# 6b.
y_log = X_air %*% coeff_air
points(x, y_log, col = "red", pch = 16)
lines(x, y_log, col = "red", pch = 16)

# 6c. 
plot.new()
y_exp = exp(X_air %*% coeff_air)
plot(x, AirPassengers, type = "b", pch = 17)
points(x, y_exp, col = "red", pch = 16)
lines(x, y_exp, col = "red", pch = 16)

