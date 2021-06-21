datatable = matrix(c(74, 68, 154, 18, 18, 16, 54, 10, 12, 12, 58, 44), nrow=4, ncol=3)
chisq.test(datatable)

depts = matrix(c(512, 353, 120, 138, 53, 16, 89, 17, 202, 131, 94, 24), nrow=6, ncol=2)
chisq.test(depts)

fert = na.omit(carData::UN$fertility)
ppgdp = na.omit(carData::UN$ppgdp)

plot(ppgdp, fert)

plot(log(ppgdp, 2.71828), log(fert, 2.71828))
abline(2.6655, -0.2071)

model = lm(log(fertility, 2.71828)~log(ppgdp, 2.71828), carData::UN)
summary(model)

# Coefficients:
# (Intercept)  
# 2.6655  
# log(ppgdp, 2.71828)  
# -0.2071

r_squared = cor(log(ppgdp, 2.71828), log(fert, 2.71828)) ^ 2

height = na.omit(carData::Davis$height)
weight = na.omit(carData::Davis$weight)

mod = lm(height~weight, carData::Davis)
summary(mod)

plot(weight, height)
abline(160.0931, 0.1509)

weightNoTwelve = weight[-12]
heightNoTwelve = height[-12]

line = lm(height[-12]~weight[-12], carData::Davis)
summary(line)

plot(weightNoTwelve, heightNoTwelve)
abline(136.83661, 0.51689)

height.res = resid(line)
plot(weightNoTwelve, height.res)
abline(0,0)
