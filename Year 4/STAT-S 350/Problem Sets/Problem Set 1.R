# Aman Patel
# STAT-S 350
# August 30, 2020

# Problem Set 1

# Q1

treat_weight <- read.table('C:/Users/aman_/Downloads/mydata.txt')
summary(treat_weight)
n = length(treat_weight$Treat)
diff = c(treat_weight$Postwt-treat_weight$Prewt)
sum(diff)/n
# Result: [1] 2.763889

#Q2

# Q2A
library(MASS)
# The error is thrown because the package that the user wants
# to use is not installed. Running installpackages("MASS")
# would install the package and remove the error.

# Q2B
# The dimensions of a dataframe can be found using the dim()
# function. The first integer shows the number of rows in the
# dataframe, while the second integer shows the number of
# columns. 
dim(Pima.tr2)
# Result: [1] 300   8

#Q2C

# The answer is NA because there are one or more missing
# values in the "bp" column. This can be fixed by removing
# the missing values from the analysis using the na.rm
# function. If any value is NA, it will be excluded.

mean(Pima.tr2$bp, na.rm = TRUE)
# Result: [1] 72.32056