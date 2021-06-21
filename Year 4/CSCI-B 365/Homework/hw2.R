# Aman Patel
# CSCI-B 365
# February 17, 2021

# Homework 2

################################################################################

# Question 3

# 3a.

x = runif(1000)
y = runif(1000)

a = (x + y) < 1
b = (x - y) < 0
c = runif(1000)
for (i in 1:1000) {
  if (a[i] == TRUE & b[i] == TRUE) {
    c[i] = 0
  }
  if (a[i] == TRUE & b[i] == FALSE) {
    c[i] = 1
  }
  if (a[i] == FALSE & b[i] == TRUE) {
    c[i] = 2
  }
  if (a[i] == FALSE & b[i] == FALSE) {
    c[i] = 3
  }
}

plot(x, y, pch=c)
abline(1, -1)
abline(0, 1)

# The events are independent because the outcome of A does not affect the outcome
# of B. Knowing the sum of x and y does not give any information about which is
# larger. There is no overlap between the different zones of symbols.

# 3b.

n_A = length(a)
p_A = sum(a) / n
margin_A = 1.96*sqrt((p_A * (1-p_A)) / n)
p_A + margin_A
p_A - margin_A

n_AgB = sum(b)
p_AgivenB = sum(a == b & a == TRUE) / sum(b)
margin_AgivenB = 1.96*sqrt((p_AgivenB * (1-p_AgivenB)) / n_AgB)
p_AgivenB + margin_AgivenB
p_AgivenB - margin_AgivenB

# For A and B to be independent, P(A) should be the same as P(A|B). The probabilities
# calculated are nearly equal, and their confidence intervals are mostly overlapping.
# Therefore, the confidence intervals are consistent with the events being independent.

################################################################################

# Question 4

# 4a.

z = runif(1000000)
A = (z < .5)
B = ((2*z) %% 1) < .5

p1 = sum(A) / 1000000
m1 = 1.96*sqrt((p1 * (1-p1)) / 1000000)
p1 - m1
p1 + m1
p2 = sum(B) / 1000000
m2 = 1.96*sqrt((p2 * (1-p2)) / 1000000)
p2 - m2
p2 + m2
p3 = sum(A == B & A == TRUE) / 1000000
m3 = 1.96*sqrt((p3 * (1-p3)) / 1000000)
p3 - m3
p3 + m3

# 4b.

# The events appear to be independent because P(A) * P(B) = P(A and B)
# If A is true, there is a 50% probability that B is also true (if z < 0.25)
# If A is false, there is a 50% probability that B is true (if 0.5 < z < 0.75)
# Regardless of the outcome of A, the probability of B is unchanged.

################################################################################

# Question 6

# 6c.

# The population was set up as follows:
# 0-0.21: S+, T-
# 0.21-0.7: S-, T-
# 0.7-0.73: S-, T+
# 0.73-1: S+, T+

pop = runif(10000000)
S = (pop < 0.21 | pop > 0.73)
T_ = (pop > 0.7)

# 6d.

TgS = (T_ == S & T_ == TRUE)
p_TgS = sum(TgS)/sum(S)
m_TgS = 1.96*sqrt((p_TgS * (1-p_TgS)) / sum(S))
p_TgS - m_TgS
p_TgS + m_TgS

# At a sample size of 10000, the confidence interval varied significantly
# between trials. When the sample size was increased, the proportion converged
# toward the calculated probability of 0.5625.

# 10000: (0.5539027, 0.5819306)
# 100000: (0.5561728, 0.565045)
# 1000000: (0.5615757, 0.5643836)
# 10000000: (0.5620545, 0.562942)
# 100000000: (0.5623709, 0.5626516)