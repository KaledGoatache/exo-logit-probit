# Analyse des Déterminants des Abonnements Mobiles avec Logit et Probit Ordonnés

### Description
Ce projet en **R** explore les facteurs influençant le nombre d'abonnements mobiles dans 128 pays en 2019. Il utilise des modèles économétriques ordonnés **Logit et Probit** pour analyser ces déterminants.

### Contenu du script
- **Importation et nettoyage des données** : `read_xlsx()`, `as.numeric()`, `factor()`
- **Analyse exploratoire** : `mean()`, `describe()`
- **Estimation des modèles économétriques** :
  - **Logit Ordonné** : `polr()` (package MASS)
  - **Probit Ordonné** : `clm()` (package ordinal)
  - **Comparaison des modèles** : AIC, BIC
- **Visualisation des résultats** : `stargazer()`

### Technologies utilisées
- `tidyverse`
- `ggplot2`
- `readxl`
- `MASS`
- `ordinal`
- `stargazer`
- `psych`
