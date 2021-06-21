# Aman Patel
# CSCI-B 365
# March 1, 2021

# Homework 3

################################################################################

# Question 1

# 1e.

# The population was set up as follows:
# [0, 0.06): A+
# [0.06, 0.2): A-
# [0.2, 0.35): B+
# [0.35, 0.5): B-
# [0.5, 0.95): C+
# [0.95, 1]: C-

pop = runif(10000)

# P(A | +) = P(A+) / P(+)

a_fav = sum(pop < 0.06)
b_fav = sum(pop >= 0.2 & pop < 0.35)
c_fav = sum(pop >= 0.5 & pop < 0.95)

a_given_fav = a_fav / (a_fav + b_fav + c_fav)
a_given_fav
# Value should be close to 0.06/0.66 = 1/11
# 0.0909090909090909...

################################################################################

# Question 2

ucb = UCBAdmissions

# 2a.

apply(ucb, c("Dept", "Admit"), sum)
mosaicplot(apply(ucb, c("Dept", "Admit"), sum))

# Department and Admit status do not seem independent because the admittance
# rate between departments is not relatively constant. A & B have high admittance
# rates. C, D, & E are moderate and F is low.

# 2b.

apply(ucb, c("Gender", "Dept"), sum)
mosaicplot(apply(ucb, c("Gender", "Dept"), sum))

# These variables also do not appear to be independent. There is a significantly
# higher proportion of males in departments A and B and a higher proportion of 
# females in departments C-F.

# 2c.

ucb[, , "F"]
mosaicplot(t(ucb[, , "F"]))

# Gender and Admit status seem to be independent for department F applicants
# because the admittance rate for males is approximately the same as the
# admittance rate for females.

# 2d.

apply(ucb["Rejected", ,], c("Gender"), sum)


################################################################################

# Question 3

# 3a.

pc = runif(150)
for (i in 1:150) {
  if (i < 51) {
    pc[i] = 0
  }
  if (i >= 51 & i < 101) {
    pc[i] = 1
  }
  if (i >= 101) {
    pc[i] = 2
  }
}

pairs(iris, pch=pc)
# 3b.

# I believe classifying on petal width will yield the best results because every
# graph containing petal width has reasonable separation between the groups.

################################################################################

# Question 4

# 4a.

event = runif(10000)
die_a = (event < 0.5)
die_b = (event >= 0.5 & event < 0.75)
die_c = (event >= 0.75)
prob = 1/9
res = runif(4000)
for (i in 1:1000) {
  if (die_a[i]) {
    res[i * 4] = "A"
    for (j in 1:3) {
      res[i * 4 - 4 + j] = sample(1:6, 1)
    }
  }
  if (die_b[i]) {
    res[i * 4] = "B"
    for (j in 1:3) {
      p = c(2 * prob, prob, 2 * prob, prob, 2 * prob, prob)
      res[i * 4 - 4 + j] = 7-length(p[cumsum(p) > runif(1, 0, 1)])
    }
  }
  if (die_c[i]) {
    res[i * 4] = "C"
    for (j in 1:3) {
      p = c(prob, prob, prob, 2 * prob, 2 * prob, 2 * prob)
      res[i * 4 - 4 + j] = 7-length(p[cumsum(p) > runif(1, 0, 1)])
    }
  }
}

table = matrix(res, ncol = 4, byrow = TRUE)
colnames(table) = c("Roll 1", "Roll 2", "Roll 3", "Die")
table

# 4b.

a_245 = 0
b_245 = 0
c_245 = 0

for (i in 1:1000) {
  if (res[i * 4 - 3] == "2" & res[i * 4 - 2] == "4" & res[i * 4 - 1] == "5" & res[i * 4] == "A") {
    a_245 = a_245 + 1
  }
  if (res[i * 4 - 3] == "2" & res[i * 4 - 2] == "4" & res[i * 4 - 1] == "5" & res[i * 4] == "B") {
    b_245 = b_245 + 1
  }
  if (res[i * 4 - 3] == "2" & res[i * 4 - 2] == "4" & res[i * 4 - 1] == "5" & res[i * 4] == "C") {
    c_245 = c_245 + 1
  }
}

total_245 = a_245 + b_245 + c_245

p_a = a_245 / (total_245)
p_b = b_245 / (total_245)
p_c = c_245 / (total_245)

# 4c.

# P(A | 2, 4, 5) was the highest of the three, it would be the Bayes classification

# 4d.

probs = runif(1000)
for (k in 1:1000) {
  event = runif(10000)
  die_a = (event < 0.5)
  die_b = (event >= 0.5 & event < 0.75)
  die_c = (event >= 0.75)
  prob = 1/9
  res = runif(4000)
  for (i in 1:1000) {
    if (die_a[i]) {
      res[i * 4] = "A"
      for (j in 1:3) {
        res[i * 4 - 4 + j] = sample(1:6, 1)
      }
    }
    if (die_b[i]) {
      res[i * 4] = "B"
      for (j in 1:3) {
        p = c(2 * prob, prob, 2 * prob, prob, 2 * prob, prob)
        res[i * 4 - 4 + j] = 7-length(p[cumsum(p) > runif(1, 0, 1)])
      }
    }
    if (die_c[i]) {
      res[i * 4] = "C"
      for (j in 1:3) {
        p = c(prob, prob, prob, 2 * prob, 2 * prob, 2 * prob)
        res[i * 4 - 4 + j] = 7-length(p[cumsum(p) > runif(1, 0, 1)])
      }
    }
  }
  
  a_245 = 0
  b_245 = 0
  c_245 = 0
  
  for (i in 1:1000) {
    if (res[i * 4 - 3] == "2" & res[i * 4 - 2] == "4" & res[i * 4 - 1] == "5" & res[i * 4] == "A") {
      a_245 = a_245 + 1
    }
    if (res[i * 4 - 3] == "2" & res[i * 4 - 2] == "4" & res[i * 4 - 1] == "5" & res[i * 4] == "B") {
      b_245 = b_245 + 1
    }
    if (res[i * 4 - 3] == "2" & res[i * 4 - 2] == "4" & res[i * 4 - 1] == "5" & res[i * 4] == "C") {
      c_245 = c_245 + 1
    }
  }
  
  total_245 = a_245 + b_245 + c_245
  
  p_a = a_245 / (total_245)
  p_b = b_245 / (total_245)
  p_c = c_245 / (total_245)
  
  if (total_245 == 0){
    probs[k] = 0
  }
  else {
    probs[k] = max(p_a, p_b, p_c)
  }
}

mean(probs)

################################################################################

# Question 5

# 5a.

X = read.csv("three_related_vars.csv")

mosaicplot(table(X[c("A", "B")]))
# Not independent, proportions of 0 and 1 in B are not the same for A = 1 and A = 0

mosaicplot(table(X[c("A", "C")]))
# Not independent, proportions of 0 and 1 in C are not the same for A = 1 and A = 0

mosaicplot(table(X[c("B", "C")]))
# Not independent, proportions of 0 and 1 in B are not the same for C = 1 and C = 0

# 5b.

a0 = (X$A == 0)
a1 = (X$A == 1)
b0 = (X$A == 0)
b1 = (X$A == 1)
c0 = (X$A == 0)
c1 = (X$A == 1)

# Conditioning A and B on C == 1

ab = rep(2, 2 * sum(c1))
current_index = 1
for (i in 1:10000) {
  if (c1[i]) {
    ab[current_index * 2 - 1] = X[,2,][i]
    ab[current_index * 2] = X[,3,][i]
    current_index = current_index + 1
  }
}
ab_mat = matrix(ab, ncol = 2)
colnames(ab_mat) = c("A", "B")
plot(ab_mat[,1], ab_mat[,2])

# 5c.

X_new = runif(40000)
for (i in 1:10000) {
  nums = runif(3)
  X_new[i * 4 - 3] = i
  if (nums[1] < 4) {
    X_new[i * 4 - 2] = 0
  }
  else {
    X_new[i * 4 - 2] = 1
  }
  if (nums[2] < 0.4) {
    X_new[i * 4 - 1] = 0
  }
  else {
    X_new[i * 4 - 1] = 1
  }
  if (nums[3] <= 0.3) {
    X_new[i * 4] = 0
  }
  else {
    X_new[i * 4] = 1
  }
}

X_2 = matrix(X_new, ncol = 4, byrow = TRUE)
colnames(X_2) = c("X", "A", "B", "C")
X_2