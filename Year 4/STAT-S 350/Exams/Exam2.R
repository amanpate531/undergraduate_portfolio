# Exam 2 Work
# Aman Patel
# November 16, 2020
# STAT-S 350

# Problem 1a

waiting  = c(57, 86, 88, 71, 79, 49, 63, 77, 94, 51, 51, 52, 53, 69, 70, 77, 71, 64, 47, 82, 51, 70, 80, 85, 86)
w_mean = mean(waiting)
w_var = mean(waiting^2)-mean(waiting)^2
w_med = quantile(waiting, 0.5, type=2)
w_iqr = quantile(waiting, 0.75, type=2)-quantile(waiting, 0.25, type=2)
w_iqrSD = w_iqr/sqrt(w_var)

# Problem 1b

hist(waiting)
d = density(waiting)
plot(d)
qqnorm(waiting)
qqline(waiting)
# The data appears to have been drawn from a normal distribution because
# the histogram and kernel density plot resemble normal distributions and
# the normal probability plot follows the qqline pretty well.

# Problem 1c

w_len = length(waiting)
w_tstat = (w_mean-74)/(sd(waiting)/sqrt(w_len))
w_pval = pt(w_tstat, w_len-1)

# Problem 2a

# E(X_bar) = mu = 420

# Var(X_bar) = sigma^2 / n
# Sd(X_bar) = sigma / sqrt(n)
# Sd(X_bar) = sqrt(23)/sqrt(92) = 0.5

# X_z = (421-E(X_bar))/Sd(X_bar) = 2
# P(Z > X_z) = P(Z > 2) = 1-pnorm(2, 0, 1) = 0.02

# Problem 2b

# E(Y_bar) = mu = 418

# Var(Y_bar) = sigma^2 / n
# Sd(Y_bar) = sigma / sqrt(n)
# Sd(Y_bar) = sqrt(16)/sqrt(72) = 0.47

# Y_z = (417-E(Y_bar))/Sd(Y_bar) = -2.12132
# P(Z < Y_z) = P(Z < -2.12132) = pnorm(-2.12132, 0, 1) = 0.0169

# Problem 2c

# X_bar - Y_bar = Z_bar
# E(Z_bar) = E(X_bar) - E(Y_bar) = 420-418 = 2

# Var(Z_bar) = Var(X_bar)/n1 + Var(Y_bar)/n2
# Var(Z_bar) = 23/92 + 16/72 = 0.472
# Sd(Z_bar) = sqrt(Var(Z_bar)) = 0.687

# P(Z_bar > 0) = 1-pnorm(0, 2, 0.687) = 0.998
# P(Z_bar > 2) = 1-pnorm(2, 2, 0.687) = 0.5

# Problem 3a

# NutriFood wants to show its food has calories greater than or equal
# to the minimum recommended caloric intake

# Their claim must therefore be in the null hypothesis, as it contains
# an equality.

# Problem 3b

cal = c(2823, 2822, 2764, 2748, 2844, 2705, 2749, 2835, 2797, 2770, 2756, 2738, 2787, 2831, 2786, 2713, 2735, 2885, 2806, 2744, 2782, 2788, 2810, 2765, 2775, 2779, 2785, 2764, 2702, 2835)
c_len = length(cal)
c_mean = mean(cal)
c_sd = sd(cal)
c_tstat = (c_mean-2800)/(c_sd/sqrt(c_len))
c_pval = pt(c_tstat, c_len-1)

# With a p-value less than 0.02, we reject the null hypothesis,
# which states that the population mean is greater than or equal to 
# 2800 kcal. This result is reasonable for the sample because the 
# sample mean is much smaller than the recommended mean caloric intake.

# Problem 3c

t = abs(qt(0.015, c_len-1))
margin = t*(c_sd/sqrt(c_len))
upper = c_mean + margin
lower = c_mean - margin

# 97% of possible values of the distribution lie within the interval,
# therefore the probability that the mean is the minimum is less than 3%.

# Problem 4c

p1 = 402/2014
p2 = 1003/4321
n1 = 2014
n2 = 4321
d = p1-p2
p_tot = (402+1003)/6335
z = d/(sqrt(p_tot * (1-p_tot) * (1/n1 + 1/n2)))
pval = pnorm(z, 0, 1)