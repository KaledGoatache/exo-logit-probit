library(tidyverse)
library(ggplot2)
library(readxl)

setwd("/Users/kaledgoatache/Desktop/a programming/r/TD ECON R")
data3 <- read_xlsx("Mobile.xlsx")
view(data3)

# Conversion des variables en format numérique
data3$Fixe <- as.numeric(data3$Fixe)
data3$Elec <- as.numeric(data3$Elec)
data3$Agri <- as.numeric(data3$Agri)
data3$FBCF <- as.numeric(data3$FBCF)
data3$Infl <- as.numeric(data3$Infl)
data3$PopUrb <- as.numeric(data3$PopUrb)
data3$Terr <- as.numeric(data3$Terr)

# Calcul de la part moyenne de la population urbaine pour les pays ayant un nombre d'abonnements mobiles 
# inférieur à 90 pour 100 habitants
(Rep1 <- mean(data3$PopUrb[data3$Mobile == 0]))

# En moyenne, les pays ayant un nombre d'abonnements mobiles inférieur à 90 pour 100 habitants 
# ont 47,7% de leur population vivant en zone urbaine.

library(psych)
describe(data3)
# La plupart des moyennes ne sont pas représentatives de l'ensemble des pays car l'écart-type est trop élevé,
# ce qui traduit une forte hétérogénéité entre les pays étudiés.

# Estimation du modèle Logit Ordonné
library(MASS)
data3$Mobile <- factor(data3$Mobile, levels = c(0, 1, 2, 3))
OL <- polr(Mobile ~ Fixe + Elec + Agri + FBCF + Infl + PopUrb + Terr, data = data3, Hess = TRUE, method = "logistic")

library(stargazer)
stargazer(OL,
          type = "text",
          title = "Résultats du modèle Logit Ordonné",
          digits = 2,
          report = "vc*p") # Affichage des p-values au lieu des erreurs standard

# La variable Elec est la seule significative. Plus l'accès à l'électricité est élevé,
# plus le nombre d'abonnements mobiles augmente. Significatif au seuil de 1%.
# AIC = 303,46, BIC = 331,99

# Estimation du modèle Probit Ordonné
library(ordinal)
OP2 <- clm(Mobile ~ Fixe + Elec + Agri + FBCF + Infl + PopUrb + Terr, data = data3, link = "probit")

stargazer(OP2,
          type = "text",
          title = "Résultats du modèle Probit Ordonné",
          digits = 2,
          report = "vc*p")
(summary(OP2))

# Le modèle Probit étant plus sensible aux valeurs extrêmes, la variable Agri devient significative au seuil de 10%.
# AIC = 301,47, BIC = 329,30

# Sélection du modèle en fonction de AIC et BIC : le modèle Probit est préféré.

# Estimation du modèle Probit Ordonné avec seulement deux variables explicatives
OP3 <- clm(Mobile ~ Elec + Agri, data = data3, link = "probit")
(summary(OP3))

stargazer(OP3,
          type = "text",
          title = "Résultats du modèle Probit Ordonné à 2 variables explicatives",
          digits = 2,
          report = "vc*p")

# Calcul des probabilités pour le pays fictif ProbitLand
