#Tutoriel : https://www.youtube.com/watch?v=cex9n2F4Ymg&t=621s

#install and load ltm package
#install.packages("ltm")
library(ltm)

#load your data
data <- read.delim("/home/fiddle/AlecolLearning/R/data/data3.txt", header = FALSE)
#View(data)

#define Rasch model
model <- rasch(data, IRT.param = TRUE)

#Si "Warning message:
#In rasch(data, IRT.param = TRUE) : 
#Hessian matrix at convergence is not positive definite; unstable solution.

model <- rasch(data, start.val = "random")


#assessing the model fit of our Rasch model
GoF.rasch(model)

#item difficulty level
coef(model, prob= TRUE,order=TRUE)

#item characteristic curve
plot(model,type ="ICC")
plot(model,type="ICC", items = c(3,4))

#item information curve
plot(model,type="IIC")
plot(model,type="IIC", items =c(3,4))
plot(model,type="IIC",items = 0)

#test information
information(model,c(-4,4))