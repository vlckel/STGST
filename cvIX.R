setwd("D:/Skola/I-STGST/Cviceni/cvIX")

data <- read.delim("D:/Skola/I-STGST/Cviceni/cvIX/data.txt", dec=",")

#### test norm�ln�ho rozd�len� ####
shapiro.test(data[,2])
sapply(data[,-1], shapiro.test)

#### F-test shody rozptyl� ####
var.test(data[,2], data[,3])
var.test(data[,4], data[,5])

#############################################
############ Parametricke metody ############
#############################################
#### t-test o shod� st�edn�ch hodnot ####
#### jednostrann� testy (<, men�� nebo rovno, >, v�t�� nebo rovno), oboustrann� testy (=, nerovn� se) ####
#### jednov�b�rov� t-test - srovn�n� v�b�ru s p�edpokl�dan�m pr�m�rem ####
t.test(data$produktivita_00, mu = 100)
t.test(data$produktivita_00, mu = 100, alternative='less')

t.test(data$produktivita_12, mu = 100)
t.test(data$produktivita_12, mu = 100, alternative='less')

#### dvouv�b�rov� t-test - srovn�n� st�edn�ch hodnot dvou nez�visl�ch v�b�r� ####
# pova�ujeme v�b�ry za nez�visl�, 27 nahodnych mest v polsku a nemecku
nezam_pl <- data$nezamestnanost_00; nezam_ge <- data$nezamestnanost_12
t.test(nezam_pl, nezam_ge)

pr_pl <- data$produktivita_00; pr_ge <- data$produktivita_12
t.test(pr_pl, pr_ge)

#### p�rov� t-test - srovn�n� st�edn�ch hodnot dvou z�visl�ch v�b�r� ####
t.test(data$nezamestnanost_00, data$nezamestnanost_12, paired = T)
t.test(data$produktivita_00, data$produktivita_12, paired = T)

t.test(data$produktivita_00, data$produktivita_12, paired = T, alternative = 'less')

#### ANOVA + Tukey HSD - anal�za variance a v�cen�sobn� porovn�v�n� ####
#### zji��ov�n� rozd�l� mezi v�ce ne� dv�ma skupinami, srovn�n� vnitro- a mezi-skupinov�ho rozptylu ####
#### v p��pad� zam�tnut� H0: �1 = �2 nerovn� se �3 nebo �1 nerovn� se �2 = �3 nebo �1 nerovn� se �2 nerovn� se �3 ####

# rozdeleni do skupin
# data$skupina <- 1
# data[10:18,'skupina'] <- 2
# data[19:27,'skupina'] <- 3
# data$skupina <- as.factor(data$skupina)
# 
# anova <- aov(nezamestnanost_00 ~  skupina, data = data)
# summary(anova)
# 
# tukey <- TukeyHSD(anova)
# plot(tukey)
# 
# a <- quantile(data$nezamestnanost_00, probs=c(0.33, 0.66))
# data$skupina <- ifelse(data$nezamestnanost_00 < a[1], 1, ifelse(data$nezamestnanost_00 < a[2], 2, 3))
# data$skupina <- as.factor(data$skupina)
# 
# anova2 <- aov(produktivita_00 ~  skupina, data = data)
# summary(anova2)
# 
# tukey2 <- TukeyHSD(anova2); tukey2
# plot(tukey2)

#############################################
############ Neparametricke metody ##########
#############################################

EarlyLeavers <- read.delim("D:/Skola/I-STGST/Cviceni/cvIX/EarlyLeavers.txt", dec=",")

sapply(EarlyLeavers[,-1], shapiro.test)

#### Mann - Whitney test - srovn�n� shody rozd�len� dvou nez�visl�ch soubor� ####
#### neparametrick� obdoba dvouv�b�rov�ho t-testu ####
wilcox.test(EarlyLeavers$Men, EarlyLeavers$Women)
wilcox.test(EarlyLeavers$Men, EarlyLeavers$Women, alternative='greater')

wilcox.test(EarlyLeavers$r2013, EarlyLeavers$Target)

#### Wilcoxon�v test - pro p�rov� pozorov�n�, neparametrick� obdoba p�rov�ho t-testu ####
#### H0: medi�n rozd�l� je 0 ####
wilcox.test(EarlyLeavers$r2005, EarlyLeavers$r2013, paired = T)
wilcox.test(EarlyLeavers$r2005, EarlyLeavers$r2013, alternative = 'less', paired = T)
wilcox.test(EarlyLeavers$r2005, EarlyLeavers$r2013, alternative = 'greater', paired = T)
wilcox.test(EarlyLeavers$r2013, EarlyLeavers$Target, paired = T)

#### Kruskal - Wallis test - neparametrick� obdoba ANOVY ####
# EarlyLeavers$skupina <- 0
# 
# b <- quantile(EarlyLeavers$r2005, probs=c(0.33, 0.66))
# EarlyLeavers$skupina <- ifelse(EarlyLeavers$r2005 < b[1], 1, ifelse(EarlyLeavers$r2005 < b[2], 2, 3))
# EarlyLeavers$skupina <- as.factor(EarlyLeavers$skupina)
# 
# kruskal <- kruskal.test(r2005 ~  skupina, data = EarlyLeavers)
# kruskal
# 
# library(pgirmess)
# kruskalmc(r2005 ~  skupina, data = EarlyLeavers)
# 
# kruskal2 <- kruskal.test(r2013 ~  skupina, data = EarlyLeavers)
# kruskal2
# kruskalmc(r2013 ~  skupina, data = EarlyLeavers)
