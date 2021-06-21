# Aman Patel
# CSCI-C 365
# February 4, 2021

# Homework 1

################################################################################

# Question 1

# 1a.

W = rep(0, 10000)
for (i in 1:10000) {
  winner = 0
  # while loop will iterate until a player wins
  while (winner == 0) {
    a = sample(0:1, 1)
    b = sample(0:1, 1)
    c = sample(0:1, 1)
    if (a != b & a != c){
      winner = 1
    }
    if (b != a & b != c){
      winner = 2
    }
    if (c != a & c != b){
      winner = 3
    }
  }
  W[i] = winner
}

a_wins = length(W[W == 1])
a_prob = a_wins / 10000

# 1b.

# 1 / sqrt(n) <= 0.02
# n >= 2500

# 1c.

# The confidence interval assumes a 95% chance of success.
# 95% of the time, the true probability will fall within the confidence interval.
# Also, the simple 1/sqrt(n) rule is pretty accurate, but it isn't perfect.

# 1d.

# True probability: 1/3

# There are 1/(2^3) possibilities for the three coin flips, but only 6 have winners.
# 2 out of the 6 outcomes are a win for A (HTT, THH).
# P(A wins) = 2/6 = 1/3

################################################################################

# Question 2

# 2a.

# 1/sqrt(n) <= 0.005
# n >= 40000

# When turn = 1, it is A's turn
# A red card is drawn when int > 0.5

X = rep(0, 40000)
for (i in 1:40000) {
  turn = 0
  int = 0
  while (int < 0.5) {
    if (turn == 0) {
      turn = 1
    }
    else {
      turn = 0
    }
    int = runif(1, 0, 1)
  }
  X[i] = turn
}

p_A = sum(X) / length(X)

# 2b.

# True Probability: 2/3

# The probability A selects a red with its first draw: 1/2
# The probability A selects a red with its second draw: 1/8
# This is because A has a 1/2 chance to get black as does B, then 1/2 for A to get red.
# The probabilities get progressively smaller by 1/4 each time
# 1/2 + 1/8 + 1/32 + 1/128 + ... = 2/3

sum = 0
for (i in 0:1000) {
  sum = sum + 1/(2^(2 * i + 1))
}
sum

################################################################################

# Question 3

# 3a.

# Omega is composed of every possible arrangement of two unique cards.

# Assuming order matters, there are 52 possibilities for the first card and
# 51 for the second, yielding 2652 potential outcomes.

# If order does not matter, each pair would be counted twice. There would be
# 1326 unique outcomes.

# 3b.

# If order matters: 13 * (4 * 3) = 156
# If order does not matter: 13 * (4 * 3) / 2 = 78

# 3c.

# 156/2652 = 78/1326 = 1/17 = 0.05882353
156/2652

################################################################################

# Question 4

# 4a.

Y = rep(0, 300)
for (i in 1:300) {
  int = runif(1, 0, 1)
  if (int <= 0.1) {
    Y[i] = 1
  }
  else {
    Y[i] = 0
  }
}
n = 300
phat = sum(Y) / n
margin = 1.96 * sqrt(phat * (1-phat) / n)
sprintf("%f +- %f", phat, margin)
sprintf("(%f, %f)", phat - margin, phat + margin)

# 4b.

Y2 = rep(0, 300)
upper = rep(0, 300)
lower = rep(0, 300)
for (i in 1:300) {
  int = runif(1, 0, 1)
  if (int <= 0.1) {
    Y2[i] = 1
  }
  else {
    Y2[i] = 0
  }
  prog_phat = sum(Y2) / i
  prog_margin = 1.96 * sqrt(prog_phat * (1-prog_phat) / i)
  upper[i] = prog_phat + prog_margin
  lower[i] = prog_phat - prog_margin
}
plot(1:300, upper)
plot(1:300, lower)

# 4c.
S = rep(0, 1000)
for (j in 1:1000) {
  Y3 = rep(0, 300)
  for (i in 1:300) {
    int = runif(1, 0, 1)
    if (int <= 0.1) {
      Y3[i] = 1
    }
    else {
      Y3[i] = 0
    }
  }
  n = 300
  phat = sum(Y3) / n
  margin = 1.96 * sqrt(phat * (1-phat) / n)
  if ((phat + margin) > 0.1 & (phat - margin) < 0.1) {
    S[j] = 1
  }
  else {
    S[j] = 0
  }
}

prob = sum(S) / length(S)

################################################################################

# Question 5

# P(A = 1) = 1/n
# P(B < A) = 0

# P(A = 2) = 1/n
# P(B < A) = 1/(n-1)

# P(A = 3) = 1/n
# P(B < A) = 2/(n-1)

# ...

# P(A = n) = 1/n
# P(B < A) = 1

# The probability of A's selection remains 1/n while the probability of B's
# selection being less than A increases by 1/(n-1).

# Multiply the probabilities for each set of events and find the sum.

# 1/n * 0 + 1/n * 1/(n-1) + 1/n * 2/(n-1)
# (1 + 2 + 3 + ... + n-1)/(n^2 - n) = (n)*((n-1)/2)/(n^2 - n)

# Final probability: (n^2 - n)/ (2n^2 - 2n) = 1/2

################################################################################

# Question 6

p = c(.1, .2, .3, .35, .02, .03)
res = 7-length(p[cumsum(p) > runif(1, 0, 1)])

# Simulate 10000 trials to check if probabilities are close to expected.
Z = rep(0, 10000)
num1 = 0
num2 = 0
num3 = 0
num4 = 0
num5 = 0
num6 = 0
for (i in 1:10000) {
  res = 7-length(p[cumsum(p) > runif(1, 0, 1)])
  Z[i] = res
  if (res == 1) num1 = num1 + 1
  if (res == 2) num2 = num2 + 1
  if (res == 3) num3 = num3 + 1
  if (res == 4) num4 = num4 + 1
  if (res == 5) num5 = num5 + 1
  if (res == 6) num6 = num6 + 1
}
p1 = num1/10000
p2 = num2/10000
p3 = num3/10000
p4 = num4/10000
p5 = num5/10000
p6 = num6/10000

################################################################################

# Question 7

# 7a.

# Probability both No = 0.4

# 7b.

# Probability either Yes = 0.3 + 0.2 + 0.1 = 0.6

# 7c.

# Probability Q1 Yes = 0.3 + 0.2 = 0.5

# 7d.

# The events are not mutually exclusive because the intersection is not empty.
# 30% of individuals answered both questions positively (intersection).
