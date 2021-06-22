# Aman Patel
# CSCI-B 365
# April 30, 2021

# Homework 7

################################################################################

# Question 1

# 1a.

z = read.csv("ridge_regression_hw.csv")
y = as.vector(z[,"y"])
x = as.matrix(z[,3:102])

coeff_reg = solve(t(x) %*% x, t(x) %*% y)
order(abs(coeff_reg), decreasing = TRUE)[1:2]
# [1] 42 53
# Regular regression identified predictors 42 and 53 to be the most important

# 1b.

lambda = 10
a = solve(t(x) %*% x + lambda * diag(100), t(x) %*% y)
order(abs(a), decreasing = TRUE)[1:2]
# [1] 10 12
# Ridge regression identified the correct predictors (10 and 12)

################################################################################

# Question 2

n = dim(x)[1]
p = dim(x)[2]
x_rev = x[,ncol(x):1]

# Reversed order of matrix columns to use last column first, remaining code is 
# adapted from forward_selection.r

used = rep(FALSE,p);
var = rep(0,p);
bestsse = rep(10000000,p);
for (j in 1:p)  {
  for (i in which(used == FALSE)) {
    used[i] = TRUE;
    xx = x_rev[,used];
    a = solve(t(xx) %*% xx , t(xx) %*% y);
    yhat = xx %*% a;
    error = y-yhat;
    sse = sum(error*error);
    if (sse < bestsse[j]) {
      bestsse[j] = sse;
      var[j] = i;
    }
    used[i] = FALSE;
  }
  print(sprintf("Variable being removed: X.%d", p + 1 - j))
  print(sprintf("SSE: %f", bestsse[j]))
  used[var[j]] = TRUE;
}
plot(bestsse)

################################################################################

# Question 3

# 3a.

# Iteration 1

# m1 vectors: {(0, 1), (1, 1)}
# m1 = (0.5, 1)
# m2 vectors: {(0, 2), (1, 2), (0, 3), (1, 3)}
# m2 = (0.5, 2.5)

# 3b.

# Iteration 2

# m1 vectors: {(0, 1), (1, 1)}
# m1 = (0.5, 1)
# m2 vectors: {(0, 2), (1, 2), (0, 3), (1, 3)}
# m2 = (0.5, 2.5)

# The partition is unchanged from iteration 1 to 2, thus the k-means algorithm
# has converged.

# 3c.

# After the 2nd iteration, the prototypes and partition did not change

# Final clusters and mean vectors:

# m1 vectors: {(0, 1), (1, 1)}
# m1 = (0.5, 1)
# m2 vectors: {(0, 2), (1, 2), (0, 3), (1, 3)}
# m2 = (0.5, 2.5)

# 3d.

# The terminal point of the algorithm is reached when all clusters are unchanged
# from one iteration to the next

################################################################################

# Question 4

# Initial prototypes
# m1 = (0, 1)
# m2 = (1, 2.1)

# Iteration 1
# m1 vectors: {(0, 1), (1, 1), (0, 2)}
# m2 vectors: {(1, 2), (0, 3), (1, 3)}
# m1 = (1/3, 4/3)
# m2 = (2/3, 8/3)

# Iteration 2
# m1 vectors: {(0, 1), (1, 1), (0, 2)}
# m2 vectors: {(1, 2), (0, 3), (1, 3)}
# m1 = (1/3, 4/3)
# m2 = (2/3, 8/3)

# The clusters are unchanged between iterations, a stable configuration has been
# reached.

# m1 SSE = 2/9 + 5/9 + 5/9 = 12/9 = 4/3
# m2 SSE = 5/9 + 5/9 + 2/9 = 12/9 = 4/3
# H = m1 SSE + m2 SSE = 4/3 + 4/3 = 8/3

# If the total SSE of this stable configuration is greater than that from the
# previous problem, then this configuration cannot be the global optimum.

# Previous problem SSE
# m1 SSE = 1/4 + 1/4 = 1/2
# m2 SSE = 1/2 + 1/2 + 1/2 + 1/2 = 2
# H = m1 SSE + m2 SSE = 1/2 + 2 = 5/2 < 8/3

# The SSE of the stable configuration from the previous problem is less than
# the SSE of the stable configuration from this problem, therefore the 
# configuration from this problem is not the global optimum.