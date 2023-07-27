stock <- read.table("D:/教学资料/研究生/时间序列/data/chapter7 stockmarket.dat_acb3844dd80aaa058cb0febe.txt",head = TRUE)
Ams.ts <- ts(stock[,1], start=1986, frequency = 365)
plot(Ams.ts)
plot(diff(Ams.ts))

library(forecast)
arima(Ams.ts, order = c(0, 1, 0))
arima(Ams.ts, order = c(1, 1, 0))
arima(Ams.ts, order = c(0, 1, 1))
arima(Ams.ts, order = c(1, 1, 1))

best <- arima(Ams.ts, order = c(0,1,0))
acf(resid(best))
acf(resid(best)^2)

library(tseries)
Ams.garch0_1 <- garch(resid(best), order = c(0,1), grad = 'numerical', trace = F)
AIC(Ams.garch0_1)

Ams.garch1_0 <- garch(resid(best), order = c(1,0), grad = 'numerical', trace = F)
AIC(Ams.garch1_0)

Ams.garch1_1 <- garch(resid(best), order = c(1,1), grad = 'numerical', trace = F)
AIC(Ams.garch1_1)

Ams.garch0_2 <- garch(resid(best), order = c(0,2), grad = 'numerical', trace = F)
AIC(Ams.garch0_2)
Ams.garch1_1
t(confint(Ams.garch1_1))

acf(Ams.garch1_1$res[-1])
acf(Ams.garch1_1$res[-1]^2)

