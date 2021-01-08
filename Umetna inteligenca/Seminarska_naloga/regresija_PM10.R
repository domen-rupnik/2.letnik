#REGRESIJA
source("funkcije.R")
md <- read.table(file="podatkiSem1.txt", sep=",", header=TRUE)
md$Glob_sevanje_min <- NULL

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

write.table(learn, "podatkiUcnaRegO3.txt", sep = ",")
write.table(test, "podatkiTestRegO3.txt", sep = ",")


#Za PM10
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
#LINEARNI MODEL
lm.model <- lm(O3 ~ ., data = learn)
lm.model

predicted <- predict(lm.model, test)
head(predicted)

observed <- test$O3
head(observed)

mae(observed, predicted)
rmae(observed, predicted, mean(learn$O3))
mse(observed, predicted)
rmse(observed, predicted, mean(learn$O3))
CA(observed,predicted)


#Regresijsko drevo
library(rpart)
rt.model <- rpart(O3 ~ ., learn)
predicted <- predict(rt.model, test)
mae(observed, predicted)
rmae(observed, predicted, mean(learn$PM10))
plot(rt.model);text(rt.model, pretty = 0)

#Nastavitve za gradnjo drevesa
rpart.control()

#Zgradimo drevo z drugimi parametri
rt <- rpart(O3 ~ ., learn, minsplit = 100)
plot(rt);text(rt, pretty = 0)

#Parameter cp kontrolira rezanje drevesa
rt.model <- rpart(O3 ~ ., learn, cp = 0)
plot(rt.model);text(rt.model, pretty = 0)

#Izpisemo ocenjene napake drevesa za razlicne vrednosti parametra cp
printcp(rt.model)

#Drevo porezemo z ustrezno vrednostjo cp, pri kateri je bila minimalna napaka
rt.model2 <- prune(rt.model, cp = 0.02)
plot(rt.model2);text(rt.model2, pretty = 0)
predicted <- predict(rt.model2, test)
rmae(observed, predicted, mean(learn$O3))

#Regresijska drevesa lahko gradimo tudi s pomocjo knjiznice CORElearn
library(CORElearn)
# modelTypeReg
# type: integer, default value: 5, value range: 1, 8 
# type of models used in regression tree leaves (1=mean predicted value, 2=median predicted value, 3=linear by MSE, 4=linear by MDL, 5=linear as in M5, 6=kNN, 7=Gaussian kernel regression, 8=locally weighted linear regression).

rt.core <- CoreModel(O3 ~ ., data=learn, model="regTree", modelTypeReg = 1)
plot(rt.core, learn)
predicted <- predict(rt.core, test)
rmae(observed, predicted, mean(learn$O3))
mae(observed, predicted)

modelEval(rt.core, test$O3, predicted)

#Preveliko drevo se prevec prilagodi podatkom in slabse napoveduje odvisno spremeljivko
rt.core2 <- CoreModel(O3 ~ ., data=learn, model="regTree",  modelTypeReg = 1, minNodeWeightTree = 1, selectedPrunerReg = 0)
plot(rt.core2, learn)
predicted <- predict(rt.core2, test)
rmae(observed, predicted, mean(learn$O3))

#Drevo z linearnim modelom v listih se lahko prevec prilagodi ucnim primerom
rt.core3 <- CoreModel(O3 ~ ., data=learn, model="regTree",  modelTypeReg = 3, selectedPrunerReg = 2)
plot(rt.core3, learn)
predicted <- predict(rt.core3, test)
rmae(observed, predicted, mean(learn$O3))

#Model se prilega ucnim podatkom, ker ima prevec parametrov, rezultat lahko izboljsamo tako, da poenostavimo model (npr. uporabimo manj atributov)
rt.core4 <- CoreModel(O3 ~ ., data=learn, model="regTree", modelTypeReg = 3)
plot(rt.core4, test)
predicted <- predict(rt.core4, test)
rmae(observed, predicted, mean(learn$O3))
mse(observed, predicted)
rmse(observed, predicted, mean(learn$O3))

#NAKLJUCNI GOZD
library(randomForest)
rf.model <- randomForest(O3 ~ ., learn)
predicted <- predict(rf.model, test)
rmae(observed, predicted, mean(learn$O3))
mae(observed, predicted)
mse(observed, predicted)
rmse(observed, predicted, mean(learn$O3))

#SVM
library(e1071)
svm.model <- svm(O3 ~ ., learn)
predicted <- predict(svm.model, test)
rmae(observed, predicted, mean(learn$O3))
mae(observed, predicted)


#K NAJBLJIZNIH SOSEDOV
library(kknn)
knn.model <- kknn(O3 ~ ., learn, test, k = 10)
predicted <- fitted(knn.model)
rmae(observed, predicted, mean(learn$O3))
mae(observed, predicted)
mse(observed, predicted)
rmse(observed, predicted, mean(learn$O3))

#UMETNE NEVRONSKE MREZE - RMAE PRIDE 1???
library(nnet)
nn.model <- nnet(O3 ~ ., learn, size = 5, decay = 0.0001, maxit = 10000, linout = T)
predicted <- predict(nn.model, test)
rmae(observed, predicted, mean(learn$O3))
mae(observed, predicted)
