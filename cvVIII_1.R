# Pro dne�n� cvi�en� vyu�ijte datovou sadu data.txt
# 
# S vyu�it�m z�kladn� statistiky, graf�, regrese a korelace popi�te datovou sadu (��seln� sloupce)
# 
# 1. vypo��tejte a okomentujte z�kladn� statistick� charakteristiky
# 2. vytvo�te a interpretujte z�kladn� grafy
# 3. zjist�te zda existuje mezi dan�mi jevy z�vislost
# 4. kvantifikujte tuto z�vislost pomocn� rovnice line�rn� regrese a zjist�te kvalitu modelu
# 5. zm�nil se vztah mezi ob�ma obdob�mi?


data <- read.delim("D:/Skola/I-STGST/Cviceni/cvVIII/data.txt", dec=",")

library(psych)
des <- describe(data, na.rm=T)
iqr <- sapply(data[,-1], function(x) IQR(x, na.rm = TRUE))

rhist <- function(x, xl, yl, main) {
  hist(x, xlab = xl, ylab = yl, main = main)
  abline(v = c(mean(x, na.rm = T), median(x, na.rm = T)), col = c('red', 'blue'), lty = 'dotted')
  rug(x)
}

par(mfrow = c(2,2))
rhist(data[,2], 'nezamestnanost (%)', '�etnost', 'Nezam�stnanost (2000)')
rhist(data[,3], 'nezamestnanost (%)', '�etnost', 'Nezam�stnanost (2012)')
rhist(data[,4], 'produktivita', '�etnost', 'Index produktivity (2000)')
rhist(data[,5], 'produktivita', '�etnost', 'Index produktivity (2012)')
par(mfrow = c(1,1))

par(mfrow = c(1,2))
ord <- data[order(data$nezamestnanost_00),]
dotchart(ord[,2], cex = 0.7, labels = ord$Stat, main = "Nezamestnanost v letech 2000 a 2012")
points(x = ord[,3], y = 1:27, cex = 0.7, col = 'red')
abline(v = c(mean(ord[,2], na.rm = T), median(ord[,2], na.rm = T)), col = c("red", "blue"), lty = 3)
abline(v = c(mean(ord[,3], na.rm = T), median(ord[,3], na.rm = T)), col = c("green", "black"), lty = 3)

ord2 <- data[order(data$produktivita_00),]
dotchart(ord2[,4], cex = 0.7, labels = ord2$Stat, main = "Index produktivity v letech 2000 a 2012")
points(x = ord2[,5], y = 1:27, cex = 0.7, col = 'red')
abline(v = c(mean(ord2[,4], na.rm = T), median(ord2[,4], na.rm = T)), col = c("red", "blue"), lty = 3)
abline(v = c(mean(ord[,5], na.rm = T), median(ord[,5], na.rm = T)), col = c("green", "black"), lty = 3)
par(mfrow = c(1,1))

library(qualityTools)
nazvy <- c('Nezam�stnanost (2000)', 'Nezam�stnanost (2012)', 'Index produktivity (2000)', 'Index produktivity (2012)')
par(mfrow = c(2,2))
for(i in 1:4) qqPlot(data[,i+1], xlab = paste('Quantiles for', nazvy[i],' '), main = nazvy[i])
par(mfrow = c(1,1))

plot(x = data[,2], y = data[,4], xlab = 'nezamestnanost (%)', ylab = 'index produktivity', xlim = c(0,30), ylim = c(0,180), pch = '')
text(x = data[,2], y = data[,4], labels = data$Stat, col = 'black', cex = 0.5)
text(x = data[,3], y = data[,5], labels = data$Stat, col = 'red', cex = 0.5)

abline(lm(produktivita_00 ~ nezamestnanost_00, data = data))
abline(lm(produktivita_12 ~ nezamestnanost_12, data = data), col = 'red')

cor.test(data[,2], data[,4])
cor.test(data[,3], data[,5])

summary(lm(produktivita_00 ~ nezamestnanost_00, data = data))
summary(lm(produktivita_00 ~ nezamestnanost_00 + I(nezamestnanost_00^2), data = data))
summary(lm(produktivita_00 ~ nezamestnanost_00 + I(nezamestnanost_00^2) + I(nezamestnanost_00^3), data = data))

summary(lm(produktivita_12 ~ nezamestnanost_12, data = data))
summary(lm(produktivita_12 ~ nezamestnanost_12 + I(nezamestnanost_12^2), data = data))
summary(lm(produktivita_12 ~ nezamestnanost_12 + I(nezamestnanost_12^2) + I(nezamestnanost_12^3), data = data))

par(mfrow = c(1,2))
plot(x = data[,2], y = data[,4], xlab = 'nezamestnanost (%)', ylab = 'index produktivity', xlim = c(0,30), ylim = c(0,180), pch = '')
text(x = data[,2], y = data[,4], labels = data$Stat, col = 'black', cex = 0.5)
km00 <- lm(produktivita_00 ~ nezamestnanost_00 + I(nezamestnanost_00^2), data = data)
km00.p <- predict(km00, interval = 'confidence')
for(j in 1:3) points(data[-15,2], km00.p[,j], pch = '*', cex = 0.6)

plot(x = data[,2], y = data[,4], xlab = 'nezamestnanost (%)', ylab = 'index produktivity', xlim = c(0,30), ylim = c(0,180), pch = '')
text(x = data[,3], y = data[,5], labels = data$Stat, col = 'red', cex = 0.5)
km12 <- lm(produktivita_12 ~ nezamestnanost_12 + I(nezamestnanost_12^2), data = data)
km12.p <- predict(km12, data, interval = 'confidence')
for(j in 1:3) points(data[,3] ,km12.p[,j], col = 'red', pch = '*', cex = 0.6)
par(mfrow = c(1,1))
