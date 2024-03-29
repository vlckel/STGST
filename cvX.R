setwd("D:/Skola/I-STGST/Cviceni/cvX")

data <- read.delim("D:/Skola/I-STGST/Cviceni/cvX/data.txt", dec=",")

#### test norm�ln�ho rozd�len� ####
shapiro.test(data[,2])
sapply(data[,-1], shapiro.test)

#############################################
############ Parametricke metody ############
#############################################

#### ANOVA + Tukey HSD - anal�za variance a v�cen�sobn� porovn�v�n� ####
#### zji��ov�n� rozd�l� mezi v�ce ne� dv�ma skupinami, srovn�n� vnitro- a mezi-skupinov�ho rozptylu ####
#### v p��pad� zam�tnut� H0: �1 = �2 nerovn� se �3 nebo �1 nerovn� se �2 = �3 nebo �1 nerovn� se �2 nerovn� se �3 ####

# rozdeleni do skupin
data$skupina <- 1
data[10:18,'skupina'] <- 2
data[19:27,'skupina'] <- 3
data$skupina <- as.factor(data$skupina)

# p�eveden� skupiny na faktor
anova <- aov(nezamestnanost_00 ~  skupina, data = data)
summary(anova)

tukey <- TukeyHSD(anova)
plot(tukey)

a <- quantile(data$nezamestnanost_00, probs=c(0.33, 0.66))
data$skupina <- ifelse(data$nezamestnanost_00 < a[1], 1, ifelse(data$nezamestnanost_00 < a[2], 2, 3))
data$skupina <- as.factor(data$skupina)

anova2 <- aov(produktivita_00 ~  skupina, data = data)
summary(anova2)

tukey2 <- TukeyHSD(anova2); tukey2
plot(tukey2)

#############################################
############ Neparametricke metody ##########
#############################################

EarlyLeavers <- read.delim("D:/Skola/I-STGST/Cviceni/cvX/EarlyLeavers.txt", dec=",")

sapply(EarlyLeavers[,-1], shapiro.test)

#### Kruskal - Wallis test - neparametrick� obdoba ANOVY ####
EarlyLeavers$skupina <- 0

b <- quantile(EarlyLeavers$r2005, probs=c(0.33, 0.66))
EarlyLeavers$skupina <- ifelse(EarlyLeavers$r2005 < b[1], 1, ifelse(EarlyLeavers$r2005 < b[2], 2, 3))
EarlyLeavers$skupina <- as.factor(EarlyLeavers$skupina)

kruskal <- kruskal.test(r2005 ~  skupina, data = EarlyLeavers)
kruskal

library(pgirmess)
kruskalmc(r2005 ~  skupina, data = EarlyLeavers)

kruskal2 <- kruskal.test(r2013 ~  skupina, data = EarlyLeavers)
kruskal2
kruskalmc(r2013 ~  skupina, data = EarlyLeavers)
