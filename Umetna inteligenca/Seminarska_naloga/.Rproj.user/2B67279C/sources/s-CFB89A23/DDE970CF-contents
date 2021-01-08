#FUNKCIJE
# Funkcija za izracun klasifikacijske tocnosti
CA <- function(observed, predicted)
{
  t <- table(observed, predicted)
  
  sum(diag(t)) / sum(t)
}

# Funkcija za izracun Brierjeve mere
brier.score <- function(observedMatrix, predictedMatrix)
{
  sum((observedMatrix - predictedMatrix) ^ 2) / nrow(predictedMatrix)
}

#METODE ZA OCENJEVANJE UCENJA V REGRESIJI
mae <- function(observed, predicted)
{
  mean(abs(observed - predicted))
}

rmae <- function(observed, predicted, mean.val) 
{  
  sum(abs(observed - predicted)) / sum(abs(observed - mean.val))
}

mse <- function(observed, predicted)
{
  mean((observed - predicted)^2)
}

rmse <- function(observed, predicted, mean.val) 
{  
  sum((observed - predicted)^2)/sum((observed - mean.val)^2)
}

setwd("C:\\Users\\Matic\\Desktop\\Faks\\2. letnik\\UI\\domaca_naloga\\")
md <- read.table(file="podatkiSem1.txt", sep=",", header=TRUE)

#Diskretizacije ciljne spremenljivke PM10 in O3

md$PM10 <- cut(md$PM10, breaks=c(min(md$PM10), 35.0, max(md$PM10)), labels=c("NIZKA", "VISOKA"), include.lowest = TRUE)
md$O3 <- cut(md$O3, breaks=c(min(md$O3), 60.0, 120.0, 180.0, max(md$O3)), labels=c("NIZKA", "SREDNJA", "VISOKA", "EKSTREMNA"), include.lowest = TRUE)

#VECINSKI KLASIFIKATOR
#Mnozico razdelimo na ucno in testno, v razmerju 70:30
set.seed(12345)
sel_PM10 <- sample(1:nrow(md), size=as.integer(nrow(md) * 0.7), replace=F)
sel_O3 <- sample(1:nrow(md), size=as.integer(nrow(md) * 0.7), replace=F)



train_PM10 <- md[sel_PM10,]
test_PM10 <- md[-sel_PM10,]

train_O3 <- md[sel_O3,]
test_O3 <- md[-sel_O3,]


#Vecinski klasifikator, vedno klasificira v razred z najvec ucnimi primeri
#v nasem primeru je vecinski razred NIZKA
#Izracunamo tocnost vecinskega klasifikatorja (delez pravilnih napovedi, ce bi vse testne primere klasificirali v vecinski razred)

table(train_PM10$PM10)
table(train_O3$O3)


tocnost_vecinskega_klasifikatorja_PM10 <- sum(test_PM10$PM10 == "NIZKA") / length(test_PM10$PM10)
tocnost_vecinskega_klasifikatorja_PM10

tocnost_vecinskega_klasifikatorja_O3 <- sum(test_O3$O3 == "SREDNJA") / length(test_O3$O3)
tocnost_vecinskega_klasifikatorja_O3



#ODLOCITVENA DREVESA
library(rpart)

#Zgradimo odlocitveno drevo
#Odstranimo datum
train_PM10$Datum <- NULL
train_PM10$O3 <- NULL

train_O3$Datum <- NULL
train_O3$PM10 <- NULL


dt_PM10 <- rpart(PM10 ~ ., data = train_PM10)
dt_O3 <- rpart(O3 ~ ., data = train_O3)

#Narisemo drevo
plot(dt_PM10)
text(dt_PM10, pretty = 0)

plot(dt_O3)
text(dt_O3, pretty = 0)

#Prave vrednosti testnih primerov
observed_PM10 <- test_PM10$PM10
observed_O3 <- test_O3$O3

#Napovedane vrednosti modela
predicted_PM10 <- predict(dt_PM10, test_PM10, type = "class")
predicted_O3 <- predict(dt_O3, test_O3, type = "class")

#Tabela napacnih klasifikacij - elementi na diagonali predstavljajo pravilno klasificirane testne primere
tab_PM10 <- table(observed_PM10, predicted_PM10)
tab_O3 <- table(observed_O3, predicted_O3)

#Klasifikacijska tocnost modela
sum(diag(tab_PM10)) / sum(tab_PM10)
sum(diag(tab_O3)) / sum(tab_O3)

#Druga oblika napovedi modela (nastavitev "prob") vraca verjetnosti, da posamezni testni primer pripada dolocenemu razredu.
predMat_PM10 <- predict(dt_PM10, test_PM10, type = "prob")
predMat_O3 <- predict(dt_O3, test_O3, type = "prob")

#Prave verjetnosti pripadnosti razredom (dejanski razred ima verjetnost 1.0 ostali pa 0.0)
obsMat_PM10 <- model.matrix( ~ PM10-1, test_PM10)
obsMat_O3 <- model.matrix( ~ O3-1, test_O3)

#Funkcija za izracun Brierjeve mere
brier.score <- function(observedMatrix, predictedMatrix)
{
  sum((observedMatrix - predictedMatrix) ^ 2) / nrow(predictedMatrix)
}

#Izracun Brierjeve mere za napovedi drevesa
brier.score(obsMat_PM10, predMat_PM10)
brier.score(obsMat_O3, predMat_O3)


#TRIVIALNI MODEL
#Vedno napove apriorno distribucijo razredov
p0_PM10 <- table(train_PM10$PM10)/nrow(train_PM10)
p0_PM10

p0Mat_PM10 <- matrix(rep(p0_PM10, times=nrow(test_PM10)), nrow = nrow(test_PM10), byrow=T)
colnames(p0Mat_PM10) <- names(p0_PM10)
head(p0Mat_PM10)

brier.score(obsMat_PM10, p0Mat_PM10)

p0_O3 <- table(train_O3$O3)/nrow(train_O3)
p0_O3

p0Mat_O3 <- matrix(rep(p0_O3, times=nrow(test_O3)), nrow = nrow(test_O3), byrow=T)
colnames(p0Mat_O3) <- names(p0_O3)
head(p0Mat_O3)

brier.score(obsMat_O3, p0Mat_O3)

#Senzitivnost - odstotek pozitivnih rezultatov, ki so bili pravilno klasificirani (klasificirani kot pozitivni)
#Specificnost - odstotek negativnih rezultatov, ki so bili pravilno klasificirani (klasificirani kot negativni)

Sensitivity(observed_PM10, predicted_PM10)
Specificity(observed_PM10, predicted_PM10)

Sensitivity(observed_O3, predicted_O3)
Specificity(observed_O3, predicted_O3)

#KLASIFIKACIJSKI MODELI
#Uporabljali bomo funkcije iz naslednjih knjiznic: ipred, prodlim, rpart, CORElearn, e1071, randomForest, kernlab, in nnet

install.packages(c("ipred", "prodlim", "CORElearn", "e1071", "randomForest", "kernlab", "nnet"))
library(pROC)

#Pripravimo podatke, diskretizacija
md <- read.table(file="podatkiSem1.txt", sep=",", header=TRUE)
md$PM10 <- cut(md$PM10, breaks=c(min(md$PM10), 35.0, max(md$PM10)), labels=c("NIZKA", "VISOKA"), include.lowest = TRUE)
md$O3 <- cut(md$O3, breaks=c(min(md$O3), 60.0, 120.0, 180.0, max(md$O3)), labels=c("NIZKA", "SREDNJA", "VISOKA", "EKSTREMNA"), include.lowest = TRUE)

#Za PM10
#Razdelimo na ucno in testno, 70:30
set.seed(12345)
sel <- sample(1:nrow(md), size=as.integer(nrow(md) * 0.7), replace=F)

learn <- md[sel,]
test <- md[-sel,]

learn$Datum <- NULL
learn$O3 <- NULL

test$Datum <- NULL
test$O3 <- NULL



observed <- test$PM10
obsMat <- model.matrix(~PM10-1, test)

#Metoda precnega preverjanja je implementirana v knjiznici "ipred"
library(ipred)

#Pomozne funkcije, ki jih potrebujemo za izvedbo precnega preverjanja
mypredict.generic <- function(object, newdata){predict(object, newdata, type = "class")}
mymodel.coremodel <- function(formula, data, target.model){CoreModel(formula, data, model=target.model)}
mypredict.coremodel <- function(object, newdata) {pred <- predict(object, newdata)$class; destroyModels(object); pred}

#ODLOCITVENO DREVO
#Gradnja modela s pomocjo knjiznice "rpart"
library(rpart)
dt <- rpart(PM10 ~ ., data = learn)
plot(dt);text(dt)
predicted <- predict(dt, test, type="class")
CA(observed, predicted)

predMat <- predict(dt, test, type = "prob")
brier.score(obsMat, predMat)

errorest(PM10~., data=learn, model = rpart, predict = mypredict.generic)

#Gradnja modela s pomocjo knjiznice "CORElearn"
#Napise da Glob_sevanje_min ima vse values enake in je skippan, zato ga lahko odstranimo?
#learn$Glob_sevanje_min <- NULL 
library(CORElearn)
cm.dt <- CoreModel(PM10 ~ ., data = learn, model="tree")
plot(cm.dt, learn)
predicted <- predict(cm.dt, test, type="class")
CA(observed, predicted)

predMat <- predict(cm.dt, test, type = "probability")
brier.score(obsMat, predMat)

errorest(PM10~., data=learn, model = mymodel.coremodel, predict = mypredict.coremodel, target.model="tree")

#NAIVNI BAYESOV KLASIFIKATOR
#Gradnja modela s pomocjo knjiznice "e1071"
library(e1071)
nb <- naiveBayes(PM10 ~ ., data = learn)
predicted <- predict(nb, test, type="class")
CA(observed, predicted)

predMat <- predict(nb, test, type = "raw")
brier.score(obsMat, predMat)

errorest(PM10~., data=learn, model = naiveBayes, predict = mypredict.generic)

#Gradnja modela s pomocjo knjiznice "CORElearn"
#Napise da Glob_sevanje_min ima vse values enake in je skippan, zato ga lahko odstranimo?
#learn$Glob_sevanje_min <- NULL
library(CORElearn)
cm.nb <- CoreModel(PM10 ~ ., data = learn, model="bayes")
predicted <- predict(cm.nb, test, type="class")
CA(observed, predicted)

predMat <- predict(cm.nb, test, type = "probability")
brier.score(obsMat, predMat)

errorest(PM10~., data=learn, model = mymodel.coremodel, predict = mypredict.coremodel, target.model="bayes")

#K-NAJBLIZJIH SOSEDOV
#Gradnja modela s pomocjo knjiznice "CORElearn"
#Napise da Glob_sevanje_min ima vse values enake in je skippan, zato ga lahko odstranimo?
#learn$Glob_sevanje_min <- NULL
library(CORElearn)
cm.knn <- CoreModel(PM10 ~ ., data = learn, model="knn", kInNN = 10)
predicted <- predict(cm.knn, test, type="class")
CA(observed, predicted)

predMat <- predict(cm.knn, test, type = "probability")
brier.score(obsMat, predMat)

errorest(PM10~., data=learn, model = mymodel.coremodel, predict = mypredict.coremodel, target.model="knn")

#NAKLJUCNI GOZD
#Gradnja modela s pomocjo knjiznice "randomForest"
library(randomForest)
rf <- randomForest(PM10 ~ ., data = learn)
predicted <- predict(rf, test, type="class")
CA(observed, predicted)

predMat <- predict(rf, test, type = "prob")
brier.score(obsMat, predMat)

mypredict.rf <- function(object, newdata){predict(object, newdata, type = "class")}
errorest(PM10~., data=learn, model = randomForest, predict = mypredict.generic)

#Gradnja modela s pomocjo knjiznice "CORElearn"
#Napise da Glob_sevanje_min ima vse values enake in je skippan, zato ga lahko odstranimo?
#learn$Glob_sevanje_min <- NULL
library(CORElearn)
cm.rf <- CoreModel(PM10 ~ ., data = learn, model="rf")
predicted <- predict(cm.rf, test, type="class")
CA(observed, predicted)

predMat <- predict(cm.rf, test, type = "probability")
brier.score(obsMat, predMat)

errorest(PM10~., data=learn, model = mymodel.coremodel, predict = mypredict.coremodel, target.model="rf")

#SVM
#Gradnja modela s pomocjo knjiznice "e1071"
#Napise da Glob_sevanje_min ima vse values enake in je skippan, zato ga lahko odstranimo?
#learn$Glob_sevanje_min <- NULL
library(e1071)
sm <- svm(PM10 ~ ., data = learn)
predicted <- predict(sm, test, type="class")
CA(observed, predicted)

sm <- svm(PM10 ~ ., learn, probability = T)
pred <- predict(sm, test, probability = T)
predMat <- attr(pred, "probabilities")

#V tem konkretnem primeru, vrstni red razredov (stolpcev) v matriki predMat je obraten kot v matriki obsMat. 
colnames(obsMat)
colnames(predMat)

# Iz tega razloga zamenjemo vrstni red stolpcev v matriki predMat
brier.score(obsMat, predMat[,c(2,1)])

errorest(PM10~., data=learn, model = svm, predict = mypredict.generic)

#Gradnja modela s pomocjo knjiznice "kernlab"
library(kernlab)
model.svm <- ksvm(PM10 ~ ., data = learn, kernel = "rbfdot")
predicted <- predict(model.svm, test, type = "response")
CA(observed, predicted)

model.svm <- ksvm(PM10 ~ ., data = learn, kernel = "rbfdot", prob.model = T)
predMat <- predict(model.svm, test, type = "prob")
brier.score(obsMat, predMat)

mypredict.ksvm <- function(object, newdata){predict(object, newdata, type = "response")}
errorest(PM10~., data=learn, model = ksvm, predict = mypredict.ksvm)

#UMETNE NEVRONSKE MREZE - NEVEM
#Gradnja modela s pomocjo knjiznice "nnet"
library(nnet)
#Implementacija funkcije za ucenje nevronske mreze daje boljse rezultate v primeru, ko so ucni primeri normalizirani. 

#Poiscemo zalogo vrednosti zveznih atributov
# (v nasem primeru so vsi atributi zvezni, razen ciljne spr. "Class", ki je 58. stolpec)
max_learn <- apply(learn[,-c(1, 5, 25)], 2, max)
min_learn <- apply(learn[,-c(1, 5, 25)], 2, min)

#Skaliramo podatke
learn_scaled <- scale(learn[,-c(1, 5, 25)], center = min_learn, scale = max_learn - min_learn)
learn_scaled <- data.frame(learn_scaled)
learn_scaled$PM10 <- learn$PM10
learn_scaled$Postaja <- learn$Postaja
learn_scaled$Glob_sevanje_min <- NULL

#Vse vrednosti atributov v ucni mnozici so na intervalu [0,1]
summary(learn_scaled)

#Testno mnozico skaliramo na zalogo vrednosti iz ucne mnozice!
test_scaled <- scale(test[,-c(1, 25)], center = min_learn, scale = max_learn - min_learn)
test_scaled <- data.frame(test_scaled)
test_scaled$PM10 <- test$PM10
test_scaled$Postaja <- test$Postaja
test_scaled$Glob_sevanje_min <- NULL


# v testni mnozici ne bodo vse vrednosti na intervalu [0,1]!
summary(test_scaled)


nn <- nnet(PM10 ~ ., data = learn_scaled, size = 5, decay = 0.0001, maxit = 10000)
predicted <- predict(nn, test_scaled, type = "class")
CA(observed, predicted)

# v primeru binarne klasifikacije bo funkcija predict vrnila verjetnosti samo enega razreda.
# celotno matriko moramo rekonstruirati sami

pm <- predict(nn, test_scaled, type = "raw")
predMat <- cbind(1-pm, pm)
brier.score(obsMat, predMat)

mypredict.nnet <- function(object, newdata){as.factor(predict(object, newdata, type = "class"))}
errorest(PM10~., data=learn_scaled, model = nnet, predict = mypredict.nnet, size = 5, decay = 0.0001, maxit = 10000)

#REGRESIJA
md <- read.table(file="podatkiSem1.txt", sep=",", header=TRUE)
md$Glob_sevanje_min <- NULL
#Za PM10
#Razdelimo na ucno in testno, 70:30
set.seed(12345)
sel <- sample(1:nrow(md), size=as.integer(nrow(md) * 0.7), replace=F)

learn <- md[sel,]
test <- md[-sel,]

learn$Datum <- NULL
learn$O3 <- NULL

test$Datum <- NULL
test$O3 <- NULL

#LINEARNI MODEL
lm.model <- lm(PM10 ~ ., data = learn)
lm.model

predicted <- predict(lm.model, test)
head(predicted)

observed <- test$PM10
head(observed)

mae(observed, predicted)
rmae(observed, predicted, mean(learn$PM10))

#Regresijsko drevo
library(rpart)
rt.model <- rpart(PM10 ~ ., learn)
predicted <- predict(rt.model, test)
rmae(observed, predicted, mean(learn$PM10))
plot(rt.model);text(rt.model, pretty = 0)

#Nastavitve za gradnjo drevesa
rpart.control()

#Zgradimo drevo z drugimi parametri
rt <- rpart(PM10 ~ ., learn, minsplit = 100)
plot(rt);text(rt, pretty = 0)

#Parameter cp kontrolira rezanje drevesa
rt.model <- rpart(PM10 ~ ., learn, cp = 0.015)
plot(rt.model);text(rt.model, pretty = 0)

#Izpisemo ocenjene napake drevesa za razlicne vrednosti parametra cp
printcp(rt.model)

#Drevo porezemo z ustrezno vrednostjo cp, pri kateri je bila minimalna napaka
rt.model2 <- prune(rt.model, cp = 0.02)
plot(rt.model2);text(rt.model2, pretty = 0)
predicted <- predict(rt.model2, test)
rmae(observed, predicted, mean(learn$PM10))

#Regresijska drevesa lahko gradimo tudi s pomocjo knjiznice CORElearn
library(CORElearn)
# modelTypeReg
# type: integer, default value: 5, value range: 1, 8 
# type of models used in regression tree leaves (1=mean predicted value, 2=median predicted value, 3=linear by MSE, 4=linear by MDL, 5=linear as in M5, 6=kNN, 7=Gaussian kernel regression, 8=locally weighted linear regression).

rt.core <- CoreModel(PM10 ~ ., data=learn, model="regTree", modelTypeReg = 1)
plot(rt.core, learn)
predicted <- predict(rt.core, test)
rmae(observed, predicted, mean(learn$PM10))

modelEval(rt.core, test$PM10, predicted)

#Preveliko drevo se prevec prilagodi podatkom in slabse napoveduje odvisno spremeljivko
rt.core2 <- CoreModel(PM10 ~ ., data=learn, model="regTree",  modelTypeReg = 1, minNodeWeightTree = 1, selectedPrunerReg = 0)
plot(rt.core2, learn)
predicted <- predict(rt.core2, test)
rmae(observed, predicted, mean(learn$PM10))

#Drevo z linearnim modelom v listih se lahko prevec prilagodi ucnim primerom
rt.core3 <- CoreModel(PM10 ~ ., data=learn, model="regTree",  modelTypeReg = 3, selectedPrunerReg = 2)
plot(rt.core3, learn)
predicted <- predict(rt.core3, test)
rmae(observed, predicted, mean(learn$PM10))

#Model se prilega ucnim podatkom, ker ima prevec parametrov, rezultat lahko izboljsamo tako, da poenostavimo model (npr. uporabimo manj atributov)
rt.core4 <- CoreModel(PM10 ~ ., data=learn, model="regTree", modelTypeReg = 3)
plot(rt.core4, test)
predicted <- predict(rt.core4, test)
rmae(observed, predicted, mean(learn$PM10))








