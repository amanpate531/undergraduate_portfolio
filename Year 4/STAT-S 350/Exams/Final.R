# Aman Patel
# 12/17/2020
# STAT-S 350

# Final Exam Intermediate Work

# Question 1

tab = table(HPV)
pos = tab[7:12]
neg = tab[1:6]

percent = 100 * pos/(pos + neg)
percent
# a)

q = qnorm(0.98)
me = q*sd(percent)/sqrt(length(percent))
mean(percent) + me
mean(percent) - me


ages = rowSums(tab)
test = colSums(tab)
total = sum(tab)

exp = (ages %o% test)/total
tab-exp
chi = sum((tab - exp)^2/exp)
chi
df = (6 - 1)* (2 - 1)
1 - pchisq(chi, df)
# p = 1.154756e-07

# Chi-square test for independence should be used in this case because
# we are testing to see if age group is independent of test result

# H0: The variables are independent
# H1: The variables are not independent

# Question 2

# a)

spl = split(salmon, salmon$species)
kok = spl$kokanee
soc = spl$sockeye
hist(kok$skincolor)
hist(soc$skincolor)

# b)

# We would use a z-test because we do not know
# the population variance.

# H0: mu_kokanee - mu_sockeye = 0
# H1: mu_kokanee - mu_sockeye > 0

# c)

# Standard error of a difference of means:
nk = length(kok$species)
ns = length(soc$species)
sdk = sd(kok$skincolor)
sds = sd(soc$skincolor)
se = sqrt((sds^2 / ns) + (sdk^2 / nk))

# d)

t_sal = (mean(kok$skincolor)-mean(soc$skincolor))/se

# e)

t.test(kok$skincolor, soc$skincolor, alternative = "greater")
# p = 2.099e-10

# Question 3

library(fivethirtyeight)
data.full <- na.omit(bechdel)
n.rows = dim(data.full)[1]
n = 200
set.seed(350)
index = sample(1:n.rows, size = n, replace = F)
data3 <- data.full[index,]

pass <- subset(data3, subset = (binary == "PASS"))
fail <- subset(data3, subset = (binary == "FAIL"))
x1 <- (pass$domgross - pass$budget)/1000000
x2 <- (fail$domgross -fail$budget)/1000000

# x1 is the profit of passing movies in millions
# x2 is the profit of failing movies in millions

# a)

hist(x1)
hist(x2)

# b)

# H0: mu_x1 - mu_x2 = 0
# H1: mu_x1 - mu_x2 > 0 

se_bech = sqrt(sd(x1)^2 / length(x1) + sd(x2)^2 / length(x2))

# c)

z_bech = ((mean(x1)-mean(x2)) - 0)/se_bech

# d)

p_bech = 1-pnorm(z_bech)

# Question 4

# a)

plot(data3$budget, data3$domgross)
plot(log(data3$budget), log(data3$domgross))
cor(data3$budget, data3$domgross)
cor(log(data3$budget), log(data3$domgross))

# log appears to be better, as it has a higher correlation,
# and it appears more linear than original

# b)

dg_log = log(data3$domgross)
b_log = log(data3$budget)

model = lm(dg_log~b_log)
summary(model)
abline(0.91639, 0.95702)
b0 = 0.91639
b1 = 0.95702

# b1 represents the slope of the regression line,
# an increase in budget by $0.957M leads to an increase
# in domgross by $1M

# c)

# H0: b1 <= 1.1
# H1: b1 > 1.1

# t = b1-k/se_b1

t_reg = (b1-(1.1))/0.06314
p_reg = 1-pt(t_reg, length(dg_log)-2)

# d)

predict(model, newdata=data.frame(b_log = 80), interval = "prediction", level = 0.95)

