# Aman Patel
# CSCI-B 365
# March 25, 2021

# Homework 4

################################################################################

# Question 1

voting = read.csv('C:/Users/aman_/Downloads/chilean_voting.csv')
yes = (voting[,9] == "Y" & !(is.na(voting[,9])))
no = (voting[,9] == "N" & !(is.na(voting[,9])))
voting = voting[no | yes,]
voting[,5] = floor(voting[,5]/10)
voting = voting[complete.cases(voting),]

# 1a.
simplified = table(voting$age, voting$education, voting$vote)

# 1b. 
rows = rownames(simplified)
cols = colnames(simplified)
counts = matrix(, nrow = 21, ncol = 4)

for (i in 1:7) {
  for (j in 1:3) {
    counts[3*i - 3 + j, 1] = paste("(", rows[i], ",", cols[j], ")")
    for (k in 2:3) {
      counts[3*i - 3 + j, k] = strtoi(simplified[i, j, k-1])
    }
  }
}

rownames(counts) = 1:21
colnames(counts) = c("Pair", "N", "Y", "C")

for (i in 1:21) {
  if (strtoi(counts[i, 2]) > strtoi(counts[i, 3])) {
    counts[i, 4] = "N"
  }
  else {
    counts[i, 4] = "Y"
  }
}

# 1c. 

# Classification: No

counts[14, 4]

# 1d.

# Degree of confidence: semi-confident

# All post-secondary education groups from ages 10-59 voted No
# However, there are only 25 samples for people in their 50's with post-secondary education
# This small sample size leads to a higher probability of error, reducing confidence

################################################################################

# Question 2

# 2a. 

# Prior distribution

y_votes = voting[,9] == "Y"
n_votes = voting[,9] == "N"
num_y = sum(y_votes)
num_n = sum(n_votes)
p_y = num_y / (num_y + num_n)
p_n = num_n / (num_y + num_n)
sprintf("Probability of Y: %f", p_y)
sprintf("Probability of N: %f", p_n)

# 2b.

# Class-conditional distributions

# Region
regions = c("N", "C", "S", "SA", "M")
region_probs = matrix(, nrow = 5, ncol = 2)
for (i in 1:5) {
  currentRegion = regions[i]
  region_probs[i, 1] = sum(voting[,9] == "Y" & voting[,2] == currentRegion) / num_y
  region_probs[i, 2] = sum(voting[,9] == "N" & voting[,2] == currentRegion) / num_n
}
colnames(region_probs) = c("Y", "N")
rownames(region_probs) = regions
region_probs

# Gender
genders = c("M", "F")
gender_probs = matrix(, nrow = 2, ncol = 2)
for (i in 1:2) {
  currentGender = genders[i]
  gender_probs[i, 1] = sum(voting[,9] == "Y" & voting[,4] == currentGender) / num_y
  gender_probs[i, 2] = sum(voting[,9] == "N" & voting[,4] == currentGender) / num_n
}
colnames(gender_probs) = c("Y", "N")
rownames(gender_probs) = genders
gender_probs

# Age
ages = c(1, 2, 3, 4, 5, 6, 7)
age_probs = matrix(, nrow = 7, ncol = 2)
for (i in 1:7) {
  currentAge = ages[i]
  age_probs[i, 1] = sum(voting[,9] == "Y" & voting[,5] == currentAge) / num_y
  age_probs[i, 2] = sum(voting[,9] == "N" & voting[,5] == currentAge) / num_n
}
colnames(age_probs) = c("Y", "N")
rownames(age_probs) = ages
age_probs

# Education
educations = c("P", "PS", "S")
education_probs = matrix(, nrow = 3, ncol = 2)
for (i in 1:3) {
  currentEducation = educations[i]
  education_probs[i, 1] = sum(voting[,9] == "Y" & voting[,6] == currentEducation) / num_y
  education_probs[i, 2] = sum(voting[,9] == "N" & voting[,6] == currentEducation) / num_n
}
colnames(education_probs) = c("Y", "N")
rownames(education_probs) = educations
education_probs

# 2c.

# Classification:

# P(F | Yes) = 0.5490
# P(F | No) = 0.4095
# P(PS | Yes) = 0.1471
# P(PS | No) = 0.2537
# P(SA | Yes) = 0.2811
# P(SA | No) = 0.3852
# P(50s | Yes) = 0.1411
# P(50s | No) = 0.1107

# P(F, PS, SA, 50s | Yes) = 0.5490 * 0.1471 * 0.2811 * 0.1411 = 0.003203118
# P(F, PS, SA, 50s | No) = 0.4095 * 0.2537 * 0.3852 * 0.1107 = 0.004430046

# The probability given No is greater than the probability given Yes, therefore
# the classification is No.

################################################################################

# Question 3

p_correct = c(0.65, 0.60, 0.57, 0.62, 0.58, 0.64, 0.67, 0.58, 0.61, 0.60)
correct = 0
for (i in 1:1000) {
  has_cond = runif(1, 0, 1) <= 0.3
  results = rep(0, 10)
  for (j in 1:10) {
    rand = runif(1, 0, 1)
    results[j] = ((rand <= p_correct[j]) & has_cond)
    if ((rand > p_correct[j]) & !has_cond) {
      results[j] = TRUE
    }
  }
  p_post = sum(results) / length(results)
  if ((p_post >= 0.5) == has_cond) {
    correct = correct + 1
  }
}

nb_error = (1000 - correct) / 1000

# The accuracy of the classifier is greater than that of all of its components (tests)

################################################################################

# Question 4

# Adapted iris_nearest_neighbor.r from Canvas to use 5 nearest neighbors

data(iris)

d = as.matrix(dist(iris[,1:4]))  # the Euclidean distance matrix d[i,j] is dist from ith flower to jth flower
n = nrow(iris)

class = as.numeric(iris[,5])  # the true classes
classhat = rep(0,n)    	      # our estimated classes
for (i in 1:n) {
  index = order(d[i, (1:n)])
  nn_5 = index[2:6]
  classes = rep(0, 3)
  for (j in 1:5) {
    if (iris[nn_5[j], 5] == "setosa") {
      classes[1] = classes[1] + 1
    }
    if (iris[nn_5[j], 5] == "virginica") {
      classes[3] = classes[3] + 1
    }
    if (iris[nn_5[j], 5] == "versicolor") {
      classes[2] = classes[2] + 1
    }
  }
  index = order(classes)
  classhat[i] = index[3]
}
cat ("error rate = ", sum(class != classhat)/n,"\n")

# The error rate is low, but it is testing the model on training data.
# In order to get a clear picture of the accuracy of the model, the data should
# be divided into training and testing groups. Then train the model using the
# training data and test using the testing data.

################################################################################

# Question 5

# See attached image.