#install.packages("forecast")
library(forecast)

# Učitavanje podataka iz datoteke:
podaci <- read.csv("merged_data.csv")
podaci

# Podjela podataka da se samo ispiše humidity:
podaci_humidity <- podaci[2]
podaci_humidity

class(podaci_humidity)

# Kreiranje vremenske serije:
tsp <- ts(podaci_humidity, frequency = 24)
tsp

# Pregled vremenske serije:
class(tsp)
start(tsp)
end(tsp)
frequency(tsp)
summary(tsp)

# Dijeljenje podataka na 4 komponente:
tsdata <- ts(podaci_humidity, frequency = 31)
ddata <- decompose(tsdata, "multiplicative")
plot(ddata)

# Prikaz svake komponente posebno:
plot(ddata$trend)
plot(ddata$seasonal)
plot(ddata$random)

plot(tsdata,
     main="Vremenska serija od 2023. do 2024. godine",
     ylab = "Vlažnost (%)",
     xlab = "Mjeseci")

# Prikaz boxplot dijagrama:
boxplot(tsp~cycle(tsp),
        xlab="Mjeseci", 
        ylab="Relativna vlažnost zraka (%)", 
        main = "Relativna vlažnost zraka od 2023. do 2024. godine")

# Auto arima:
model <- auto.arima(podaci_humidity)
model

plot(tsdata,
     main = "Vremenska serija od 2023 do 2024",
     ylab = "Vlažnost (%)",
     xlab = "Mjeseci")
abline(reg=lm(tsdata~time(tsdata)), col='red')
abline(h=60, col="blue")

# Graf reziduala:
plot.ts(model$residuals)

# Predviđanje kretanja relativne vlažnosti zraka slijedećih 5 godina:
myforecast <- forecast(model, level=c(95), h=5*12)
plot(myforecast,
     main = "Predviđanje kretanja relativne vlažnosti zraka kroz slijedećih 5 godina",
     ylab = "Vlažnost (%)",
     xlab = "Dani")

#Validacija modela odabirom vrijednosti kašnjenja:
Box.test(model$resid, lag=5, type="Ljung-Box")
Box.test(model$resid, lag=10, type="Ljung-Box")
Box.test(model$resid, lag=15, type="Ljung-Box")
