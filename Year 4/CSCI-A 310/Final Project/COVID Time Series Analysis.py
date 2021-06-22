import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
import pandas

usData = pandas.read_csv("covid-19-data-master/us.csv", header = 0, parse_dates = [0], index_col = 0, squeeze = True)

# Smooth function uses moving average convolution to smooth out curves
def smooth(y, box_pts):
    box = np.ones(box_pts)/box_pts
    y_smooth = np.convolve(y, box, mode='same')
    return y_smooth

# plot cumulative cases in the US from January 21, 2020 - April 13, 2021
usCases = usData["cases"]
usCases.plot()
plt.title(label = "COVID-19 Cases in the United States")
plt.show()

# calculates the daily incidence (# new cases per day)
newCases = []
for day in range(len(usCases)):
    if day == 0:
        newCases.append(usCases[day])
    else:
        newCases.append(usCases[day] - usCases[day - 1])

x = list(range(0, len(newCases)))

# plots daily incidence and smoothed incidence
plt.plot(x, newCases)
plt.title(label = "Daily Incidence of COVID-19 in the United States")
plt.plot(x, smooth(newCases, 30))

# polynomial regression using matrix multiplication

degree = 6
test_matrix = np.array([1] * len(x))
for i in range(1, degree):
    test_matrix = np.append(test_matrix, [index ** i for index in x])

res = np.transpose(np.reshape(test_matrix, (-1, len(x))))

coeff_matrix = np.linalg.solve(np.matmul(np.transpose(res), res), np.matmul(np.transpose(res), smooth(newCases, 30)))
pred = np.dot(res, coeff_matrix)
plt.plot(x, pred)
plt.show()

# predict future cumulative case counts using Linear Regression
daysOfCOVID = usData.shape[0]
dates = pandas.Series(range(daysOfCOVID)).values.reshape(-1, 1)
cases = usCases.values.reshape(-1, 1)
model = LinearRegression().fit(dates, cases)
forecast = model.predict(pandas.Series(range(daysOfCOVID, 500)).values.reshape(-1, 1))

# appends prediction to existing data and plots
y = list(usCases.values)
for prediction in forecast:
    y.append(prediction[0])
x = list(range(0, 500))

plt.figure()
plt.title(label = "COVID-19 Case Count Prediction (Including Days 1-36 in Training)")
plt.plot(x, y)
plt.show()

# This forecast predicts the total case count will be less than the current value, which is not possible.
# The linear regression is taking the initial flat stretch into account, lowering the line of best fit.
# The following shows the same linear regression excluding the first 36 values (all < 50 cases)

# exclude flat stretch in beginning of time series (Days 1-36)
usCases_NO = usCases[36:]

# predict future cumulative case counts using Linear Regression
daysOfCOVID_NO = len(usCases_NO)
dates_NO = pandas.Series(range(daysOfCOVID_NO)).values.reshape(-1, 1)
cases_NO = usCases_NO.values.reshape(-1, 1)
model_NO = LinearRegression().fit(dates_NO, cases_NO)
forecast_NO = model_NO.predict(pandas.Series(range(daysOfCOVID, 500)).values.reshape(-1, 1))

# appends new prediction to existing data and plots
y = list(usCases.values)
for prediction in forecast_NO:
    y.append(prediction[0])
x = list(range(0, 500))

plt.figure()
plt.title(label = "COVID-19 Case Count Prediction (Excluding Days 1-36 in Training)")
plt.plot(x, y)
plt.show()

# By removing the flat stretch in the beginning of the time series, the regression performed much better.
# The resulting line of best fit was a near continuation of the training data and it seemed to follow the trend of the data well.
# Although data is being removed, lowering the sample size, the reliability of the prediction improved.
# This is because more recent training data should have more weight on the prediction than older data.

############################################################################################

# plot cumulative deaths from January 21, 2020 - April 13, 2021
usDeaths = usData["deaths"]
usDeaths.plot()
plt.title(label = "COVID-19 Deaths in the United States")
plt.show()

# calculates daily mortality (# new deaths per day)
newDeaths = []
for day in range(len(usDeaths)):
    if day == 0:
        newDeaths.append(usDeaths[day])
    else:
        newDeaths.append(usDeaths[day] - usDeaths[day - 1])

x = list(range(0, len(newDeaths)))

# plots daily mortality and smoothed mortality
plt.plot(x, newDeaths)
plt.title(label = "Daily Mortality of COVID-19 in the United States")
plt.plot(x, smooth(newDeaths, 30))
plt.show()

# predict future cumulative death counts using Linear Regression
daysOfCOVID = usData.shape[0]
dates = pandas.Series(range(daysOfCOVID)).values.reshape(-1, 1)
deaths = usDeaths.values.reshape(-1, 1)
model = LinearRegression().fit(dates, deaths)
forecast = model.predict(pandas.Series(range(daysOfCOVID, 500)).values.reshape(-1, 1))

# append prediction to existing data and plots
y = list(usDeaths.values)
for prediction in forecast:
    y.append(prediction[0])
x = list(range(0, 500))

plt.figure()
plt.title(label = "COVID-19 Death Count Prediction (Including Days 1-38 in Training)")
plt.plot(x, y)
plt.show()

# This forecast predicts the total death count will be less than the current value, which is not possible.
# The linear regression is taking the initial flat stretch into account, lowering the line of best fit.
# The following shows the same linear regression excluding the first 38 values (all 0 deaths)

usDeaths_NO = usDeaths[38:]

daysOfCOVID_NO = len(usDeaths_NO)

dates_NO = pandas.Series(range(daysOfCOVID_NO)).values.reshape(-1, 1)
deaths_NO = usDeaths_NO.values.reshape(-1, 1)
model_NO = LinearRegression().fit(dates_NO, deaths_NO)
forecast_NO = model_NO.predict(pandas.Series(range(daysOfCOVID, 500)).values.reshape(-1, 1))

y = list(usDeaths.values)
for prediction in forecast_NO:
    y.append(prediction[0])
x = list(range(0, 500))

plt.figure()
plt.title(label = "COVID-19 Death Count Prediction (Excluding Days 1-38 in Training)")
plt.plot(x, y)
plt.show()

# By removing the flat stretch in the beginning of the time series, the regression performed much better.
# The resulting line of best fit was a near continuation of the training data and it seemed to follow the trend of the data well.
