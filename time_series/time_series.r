library(forecast)

# Učitavanje podataka iz datoteke:
podaci <- read.csv("merged_data_rl.csv")
podaci

# Podjela podataka da se samo ispiše humidity:
podaci_humidity <- podaci[2]
podaci_humidity

class(podaci_humidity)

# Dijeljenje podataka na 4 komponente i implementacija vremenske serije:
tsdata <- ts(podaci_humidity, start = 2023, frequency = 365)
ddata <- decompose(tsdata, "multiplicative")
plot(ddata)
plot(tsdata)

# Pregled vremenske serije:
class(tsdata)
tsdata
frequency(tsdata)
start(tsdata)
end(tsdata)

# Prikaz svake komponente posebno:
plot(ddata$trend,
     main = "Apsolutna vlaga zraka",
     ylab = "Vlažnost",
     xlab = "Mjeseci")
plot(ddata$seasonal)
plot(ddata$random)

plot(tsdata,
     main="Vremenska serija od 2023. do 2024. godine",
     ylab = "Vlažnost (%)",
     xlab = "Mjeseci")
abline(reg=lm(tsdata~time(tsdata)), col='red')
abline(h=60, col="blue")

# Prikaz boxplot dijagrama:
boxplot(tsdata~cycle(tsdata),
        xlab="Dani", 
        ylab="Relativna vlažnost zraka (%)", 
        main = "Relativna vlažnost zraka od 2023. do 2024. godine")

# Auto arima:

model <- auto.arima(tsdata)
model

# Graf reziduala:
plot.ts(model$residuals)

# Predviđanje kretanja relativne vlažnosti zraka slijedećih godinu dana:
predikcija <- forecast(model, level=c(95), h=1*365)
plot(predikcija,
     main = "Predviđanje kretanja relativne vlažnosti zraka kroz slijedećih godinu dana",
     ylab = "Vlažnost",
     xlab = "Mjeseci")

#Validacija modela odabirom vrijednosti kašnjenja:
Box.test(model$resid, lag=5, type="Ljung-Box")
Box.test(model$resid, lag=10, type="Ljung-Box")
Box.test(model$resid, lag=15, type="Ljung-Box")
