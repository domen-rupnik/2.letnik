#KLASIFIKACIJSKI MODELI
#Uporabljali bomo funkcije iz naslednjih knjiznic: ipred, prodlim, rpart, CORElearn, e1071, randomForest, kernlab, in nnet
install.packages(c("ipred", "prodlim", "CORElearn", "e1071", "randomForest", "kernlab", "nnet"))
setwd('C:/Users/Uporabnik/Documents/Faks/2.letnik/Umetna_inteligenca/Seminarska_naloga/')
source("funkcije.R")
library(pROC)
library(lubridate)

#Pripravimo podatke, diskretizacija
md <- read.table(file="podatkiSem1.txt", sep=",", header=TRUE)
md$Mesec<-factor(month(md$Datum))
md$Predviden_O3[1] <- md$O3[1]
md$Predviden_PM10[1] <- md$PM10[1]
md$Predviden_PM10[2] <- md$PM10[2]
md$Predviden_O3[2] <- md$O3[2]
md$Predviden_O3[3] <- (md$O3[3-1] + md$O3[3-2])/2
md$Predviden_PM10[3] <- (md$PM10[3-1] + md$PM10[3-2])/2

for(i in 1:nrow(md))
{
  if(i > 3){
    md$Predviden_O3[i] <- (md$O3[i-1] + md$O3[i-2] + md$O3[i-3])/3
    md$Predviden_PM10[i] <- (md$PM10[i-1] + md$PM10[i-2] + md$PM10[i-3])/3
  }
}

md$PM10 <- cut(md$PM10, breaks=c(min(md$PM10), 35.0, max(md$PM10)), labels=c("NIZKA", "VISOKA"), include.lowest = TRUE)
md$O3 <- cut(md$O3, breaks=c(min(md$O3), 60.0, 120.0, 180.0, max(md$O3)), labels=c("NIZKA", "SREDNJA", "VISOKA", "EKSTREMNA"), include.lowest = TRUE)
rezultati <- data.frame("CA" = 0:1, "Brier" = 0:1, "Klasifikator" = c("Odlocitveno drevo", "CORE LEARN drevo", "Bayes", "CORE bayes","KNN","Nakljucni gozd", "CORE MODEL", "E1071", "KERN LAB", "Nevrosnka mreza" ))

summary(md)

write.table(md, "podatkiDodaniAtributi.txt", sep = ",")


#Za O3
#Razdelimo na ucno in testno, 70:30
set.seed(12345)
sel <- sample(1:nrow(md), size=as.integer(nrow(md) * 0.7), replace=F)

learn <- md[sel,]
test <- md[-sel,]

learn$Datum <- NULL
learn$PM10 <- NULL
learn$Predviden_PM10 <- NULL

test$Datum <- NULL
test$PM10 <- NULL
test$Predviden_PM10 <- NULL



observed <- test$O3
obsMat <- model.matrix(~O3-1, test)

#Metoda precnega preverjanja je implementirana v knjiznici "ipred"
library(ipred)

#Pomozne funkcije, ki jih potrebujemo za izvedbo precnega preverjanja
mypredict.generic <- function(object, newdata){predict(object, newdata, type = "class")}
mymodel.coremodel <- function(formula, data, target.model){CoreModel(formula, data, model=target.model)}
mypredict.coremodel <- function(object, newdata) {pred <- predict(object, newdata)$class; destroyModels(object); pred}

#ODLOCITVENO DREVO
#Gradnja modela s pomocjo knjiznice "rpart"
library(rpart)
dt <- rpart(O3 ~ ., data = learn)
#plot(dt);text(dt)
predicted <- predict(dt, test, type="class")
#CA(observed, predicted)

predMat <- predict(dt, test, type = "prob")
#brier.score(obsMat, predMat)

#errorest(O3~., data=learn, model = rpart, predict = mypredict.generic)


rezultati[1,1] <- CA(observed, predicted)
rezultati[1,2] <- brier.score(obsMat, predMat)

#Gradnja modela s pomocjo knjiznice "CORElearn"
#Napise da Glob_sevanje_min ima vse values enake in je skippan, zato ga lahko odstranimo?
#learn$Glob_sevanje_min <- NULL 
library(CORElearn)
cm.dt <- CoreModel(O3 ~ ., data = learn, model="tree")
#plot(cm.dt, learn)
predicted <- predict(cm.dt, test, type="class")
#CA(observed, predicted)

predMat <- predict(cm.dt, test, type = "probability")
#brier.score(obsMat, predMat)

#errorest(O3~., data=learn, model = mymodel.coremodel, predict = mypredict.coremodel, target.model="tree")
rezultati[2,1] <- CA(observed, predicted)
rezultati[2,2] <- brier.score(obsMat, predMat)
#NAIVNI BAYESOV KLASIFIKATOR
#Gradnja modela s pomocjo knjiznice "e1071"
library(e1071)
nb <- naiveBayes(O3 ~ ., data = learn)
predicted <- predict(nb, test, type="class")
#CA(observed, predicted)

predMat <- predict(nb, test, type = "raw")
#brier.score(obsMat, predMat)

#errorest(O3~., data=learn, model = naiveBayes, predict = mypredict.generic)
rezultati[3,1] <- CA(observed, predicted)
rezultati[3,2] <- brier.score(obsMat, predMat)
#Gradnja modela s pomocjo knjiznice "CORElearn"
#Napise da Glob_sevanje_min ima vse values enake in je skippan, zato ga lahko odstranimo?
#learn$Glob_sevanje_min <- NULL
library(CORElearn)
cm.nb <- CoreModel(O3 ~ ., data = learn, model="bayes")
predicted <- predict(cm.nb, test, type="class")
#CA(observed, predicted)

predMat <- predict(cm.nb, test, type = "probability")
#brier.score(obsMat, predMat)

#errorest(O3~., data=learn, model = mymodel.coremodel, predict = mypredict.coremodel, target.model="bayes")
rezultati[4,1] <- CA(observed, predicted)
rezultati[4,2] <- brier.score(obsMat, predMat)
#K-NAJBLIZJIH SOSEDOV
#Gradnja modela s pomocjo knjiznice "CORElearn"
#Napise da Glob_sevanje_min ima vse values enake in je skippan, zato ga lahko odstranimo?
#learn$Glob_sevanje_min <- NULL
library(CORElearn)
cm.knn <- CoreModel(O3 ~ ., data = learn, model="knn", kInNN = 10)
predicted <- predict(cm.knn, test, type="class")
#CA(observed, predicted)

predMat <- predict(cm.knn, test, type = "probability")
#brier.score(obsMat, predMat)

#errorest(O3~., data=learn, model = mymodel.coremodel, predict = mypredict.coremodel, target.model="knn")
rezultati[5,1] <- CA(observed, predicted)
rezultati[5,2] <- brier.score(obsMat, predMat)
#NAKLJUCNI GOZD
#Gradnja modela s pomocjo knjiznice "randomForest"
library(randomForest)
rf <- randomForest(O3 ~ ., data = learn)
predicted <- predict(rf, test, type="class")
#CA(observed, predicted)

predMat <- predict(rf, test, type = "prob")
#brier.score(obsMat, predMat)

#mypredict.rf <- function(object, newdata){predict(object, newdata, type = "class")}
#errorest(O3~., data=learn, model = randomForest, predict = mypredict.generic)
rezultati[6,1] <- CA(observed, predicted)
rezultati[6,2] <- brier.score(obsMat, predMat)
#Gradnja modela s pomocjo knjiznice "CORElearn"
#Napise da Glob_sevanje_min ima vse values enake in je skippan, zato ga lahko odstranimo?
#learn$Glob_sevanje_min <- NULL
library(CORElearn)
cm.rf <- CoreModel(O3 ~ ., data = learn, model="rf")
predicted <- predict(cm.rf, test, type="class")
#CA(observed, predicted)

predMat <- predict(cm.rf, test, type = "probability")
#brier.score(obsMat, predMat)

#errorest(O3~., data=learn, model = mymodel.coremodel, predict = mypredict.coremodel, target.model="rf")
rezultati[7,1] <- CA(observed, predicted)
rezultati[7,2] <- brier.score(obsMat, predMat)
#SVM
#Gradnja modela s pomocjo knjiznice "e1071"
#Napise da Glob_sevanje_min ima vse values enake in je skippan, zato ga lahko odstranimo?
#learn$Glob_sevanje_min <- NULL
library(e1071)

sm <- svm(O3 ~ ., data = learn)
predicted <- predict(sm, test, type="class")
CA(observed, predicted)

sm <- svm(O3 ~ ., learn, probability = T)
pred <- predict(sm, test, probability = T)
predMat <- attr(pred, "probabilities")

# v tem konkretnem primeru, vrstni red razredov (stolpcev) v matriki predMat je 
# obraten kot v matriki obsMat. 
colnames(obsMat)
colnames(predMat)

# Iz tega razloga zamenjemo vrstni red stolpcev v matriki predMat
brier.score(obsMat, predMat[,c(2,1)])

errorest(Class~., data=learn, model = svm, predict = mypredict.generic)
rezultati[8,1] <- CA(observed, predicted)
rezultati[8,2] <- brier.score(obsMat, predMat[,c(2,1)])

#Gradnja modela s pomocjo knjiznice "kernlab"
library(kernlab)
model.svm <- ksvm(O3 ~ ., data = learn, kernel = "rbfdot")
predicted <- predict(model.svm, test, type = "response")
#CA(observed, predicted)

model.svm <- ksvm(O3 ~ ., data = learn, kernel = "rbfdot", prob.model = T)
predMat <- predict(model.svm, test, type = "prob")
#brier.score(obsMat, predMat)

#mypredict.ksvm <- function(object, newdata){predict(object, newdata, type = "response")}
#errorest(O3~., data=learn, model = ksvm, predict = mypredict.ksvm)
rezultati[9,1] <- CA(observed, predicted)
rezultati[9,2] <- brier.score(obsMat, predMat)


rezultati
