# Aman Patel
# CSCI-B 365
# April 8, 2021

# Homework 5

################################################################################

# Question 2

tree_data = matrix(scan("tree_data.dat"),byrow=T,ncol = 3)
colnames(tree_data) = c("A", "B", "Terminal")

traverse <- function(i) {
  print(i);
  if (tree_data[i,3] == 0) {
    traverse(2*i)
    traverse(2*i+1)
  }
}
n = tree_data[1,1] + tree_data[1,2]
risk <- function(i) {
  if (tree_data[i,3]) return(min(tree_data[i,1],tree_data[i,2])/n)
  return(risk(2*i)+risk(2*i+1))
}

# 2a.
  risk_star <- function(i) {
    res = min(tree_data[i,1],tree_data[i,2])/n
    if (tree_data[i, 3]) return(res)
    return(min(res, risk_star(2 * i) + risk_star(2 * i + 1) + 0.03))
  }

# 2b.
  nodes_in_tree <- function(i) {
    if (tree_data[i,3]) {
      print(i)
    } else if (risk_star(i) == min(tree_data[i,1], tree_data[i,2])/n) {
      print(i)
    } else {
      print(i)
      nodes_in_tree(2 * i)
      nodes_in_tree(2 * i + 1)
    }
  }

################################################################################

# Question 4

library(rpart)
useful_vars = read.csv("useful_vars.csv")

# 4a.
  fit = rpart(y ~ X.1 + X.2 + X.3 + X.4 + X.5 + X.6 + X.7 + X.8 + X.9 + X.10 + X.11 + X.12 + X.13 + X.14 + X.15 + X.16 + X.17 + X.18 + X.19 + X.20,
              data = useful_vars, method = "class", parms = list(split='information'))

  print(fit)
  # PDF from post was not working for me, I converted the default .ps file to .pdf
  post(fit)

# 4b.

  # Most useful variables: X.11 and X.18

# 4c.
  plot(useful_vars$X.11, useful_vars$X.18, pch = useful_vars$y)
  abline(a=0,b=-1)

# 4d.

  # Rule for generating the dataset:

    # If X.18 < -1 * X.11, Class 1
    # Else, Class 2