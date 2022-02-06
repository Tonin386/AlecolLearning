#where to download IQ1 dataset
# https://openpsychometrics.org/_rawdata/


#load dataset download
IQ1 <- read.csv(file.choose())

#Pour des données déjà au format binaire en txt
data <- read.delim(file.choose(),header = FALSE)

#select questions only
IQbin<-IQ1[,1:25]

#binary responses
IQbin[IQbin<10]<-0
IQbin[IQbin==10]<-1

#fit 3 binary response unidimensional IRT models
library(ltm)

#fit rasch model (i.e., 1PL)
IRTrasch <- rasch(data, IRT.param = TRUE,constraint = cbind(length(data) + 1, 1))

#fit 2PL model
IRT2pl <- ltm(data~z1,IRT.param = TRUE)

#fit 3PL model
IRT3pl <- tpm(data,type="latent.trait",IRT.param = TRUE)

#return item parameters for each model
coef(IRTrasch, prob = TRUE)
coef(IRT2pl, prob = TRUE)
coef(IRT3pl, prob = TRUE)

#compare model fit 
anova(IRTrasch,IRT2pl) #(Si la p.value > 0.001 alors le modèle à 2 paramètres est meilleur que celui à 1 paramètres)
anova(IRT2pl,IRT3pl) #(Si la p.value > 0.001 alors le modèle à 3 paramètres est meilleur que celui à 2 paramètres)

#Dans la suite, on étudie le modèle à deux paramètres, mais les fonctions peuvent aussi s'appliquer aux autres modèles

#return goodness of fit of the items with chi-square test
item.fit(IRT2pl) #(plus la valeur de Pr(>X^2) est faible plus la donnée est fiable)

#Plot ICC's for each item
plot(IRT2pl,type="ICC")

#Plot ICC's for one item
plot(IRT2pl,type="ICC",items=6)

#Plot Test Information Function 
plot(IRT2pl,type="IIC",items=0) 

#ability estimates
est<-factor.scores(IRT2pl)

est$score.dat$z1[1:5]

#test undimensionality
#first, fit 2PL model with 2 factors
IRT2pl_2 <- ltm(data~z1+z2)

#second, run liklihood ratio test comparing 1 to 2 factor models
anova(IRT2pl,IRT2pl_2) #(si p.value<0.001 alors il n'existe pas qu'un seul facteur dominant, l'hypothèse d'unidimensionnalité n'est pas respectée)