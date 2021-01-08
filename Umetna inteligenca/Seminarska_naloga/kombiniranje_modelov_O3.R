library(CORElearn)
library(ipred)
library(randomForest)
library(adabag)
setwd('C:/Users/Uporabnik/Documents/Faks/2.letnik/Umetna_inteligenca/Seminarska_naloga/')
source("mojefunkcije.R")

voting <- function(predictions)
{
  res <- vector()
  
  for (i in 1 : nrow(predictions))  	
  {
    vec <- unlist(predictions[i,])
    res[i] <- names(which.max(table(vec)))
  }
  
  factor(res, levels=levels(predictions[,1]))
}

md <- read.table(file="podatkiSem1.txt", sep=",", header=TRUE)

md$O3 <- cut(md$O3, breaks=c(min(md$O3), 60.0, 120.0, 180.0, max(md$O3)), labels=c("NIZKA", "SREDNJA", "VISOKA", "EKSTREMNA"), include.lowest = TRUE)
md$Datum <- NULL
md$PM10 <- NULL
md$Glob_sevanje_min <- NULL

summary(md)

#Za O3

set.seed(8678686)
sel <- sample(1:nrow(md), size=as.integer(nrow(md)*0.7), replace=F)
learn <- md[sel,]
test <- md[-sel,]



table(learn$O3)
table(test$O3)

#GLASOVANJE
modelDT <- CoreModel(O3 ~ ., learn, model="tree")
modelNB <- CoreModel(O3 ~ ., learn, model="bayes")
modelKNN <- CoreModel(O3 ~ ., learn, model="knn", kInNN = 5)

predDT <- predict(modelDT, test, type = "class")
caDT <- CA(test$O3, predDT)
caDT

predNB <- predict(modelNB, test, type="class")
caNB <- CA(test$O3, predNB)
caNB

predKNN <- predict(modelKNN, test, type="class")
caKNN <- CA(test$O3, predKNN)
caKNN

pred <- data.frame(predDT, predNB, predKNN) #Zdruzimo napovedi v en dataframe
pred

predicted <- voting(pred) #Testni primer klasificiramo v razred z najvec glasovi
CA(test$O3, predicted)

#UTEZENO GLASOVANJE
predDT.prob <- predict(modelDT, test, type="probability")
predNB.prob <- predict(modelNB, test, type="probability")
predKNN.prob <- predict(modelKNN, test, type="probability")

pred.prob <- caDT * predDT.prob + caNB * predNB.prob + caKNN * predKNN.prob #Sestejemo napovedane verjetnosti s strani razlicnih modelov
pred.prob

predicted <- levels(learn$O3)[apply(pred.prob, 1, which.max)] #Izberemo razred z najvecjo verjetnostjo

CA(test$O3, predicted)

#BAGGING
bag <- bagging(O3 ~ ., learn, nbagg=15)
bag.pred <- predict(bag, test, type="class")
CA(test$O3, bag.pred)

#NAKLJUCNI GOZD - je inacica bagginga
rf <- randomForest(O3 ~ ., learn)
predicted <- predict(rf, test, type = "class")
CA(test$O3, predicted)

#BOOSTING
bm <- boosting(O3 ~ ., learn)
predictions <- predict(bm, test)
names(predictions)

predicted <- predictions$class
CA(test$O3, predicted)
