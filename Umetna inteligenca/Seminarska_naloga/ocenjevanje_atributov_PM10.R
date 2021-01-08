library(CORElearn)
source("funkcije.R")
#informacijski prispevek je kratkovidna ocena
#(predvideva, da so atributi pogojno neodvisni pri podani vrednosti ciljne spremenljivke)

setwd('C:/Users/Uporabnik/Documents/Faks/2.letnik/Umetna_inteligenca/Seminarska_naloga/')
md <- read.table(file="podatkiSem1.txt", sep=",", header=TRUE)





md$O3 <- cut(md$O3, breaks=c(min(md$O3), 60.0, 120.0, 180.0, max(md$O3)), labels=c("NIZKA", "SREDNJA", "VISOKA", "EKSTREMNA"), include.lowest = TRUE)
md$PM10 <- cut(md$PM10, breaks=c(min(md$PM10), 35, max(md$PM10)), labels = c("NIZKA", "VISOKA"))
md$Datum <- NULL
md$O3 <- NULL
md$Glob_sevanje_min <- NULL

sort(attrEval(PM10 ~ ., md, "InfGain"), decreasing = TRUE) #Sortiranje pomembnosti z Informacijskih prispevkom atributov na 03, padajoce

dt <- CoreModel(PM10 ~ ., md, model="tree", selectionEstimator="InfGain") #Odlocitveno drevo z uporabo informacijskega prispevka, slab primer
plot(dt, md)

#Vse spodnje ocene so kratkovidne (ne morejo zaznati atributov v interakciji)
sort(attrEval(PM10 ~ ., md, "InfGain"), decreasing = TRUE)
sort(attrEval(PM10 ~ ., md, "Gini"), decreasing = TRUE)
sort(attrEval(PM10 ~ ., md, "MDL"), decreasing = TRUE)

#Ocene, ki niso kratkovidne (Relief in ReleifF)
sort(attrEval(PM10 ~ ., md, "Relief"), decreasing = TRUE)
sort(attrEval(PM10 ~ ., md, "ReliefFequalK"), decreasing = TRUE)
sort(attrEval(PM10 ~ ., md, "ReliefFexpRank"), decreasing = TRUE)

#Odlocitveno drevo na podlagi ocene Relief
dt3 <- CoreModel(PM10 ~ ., md, model="tree", selectionEstimator = "ReliefFequalK")
plot(dt3, md)

#GainRatio
sort(attrEval(PM10 ~ ., md, "GainRatio"), decreasing = TRUE)
sort(attrEval(PM10 ~ ., md, "ReliefFequalK"), decreasing = TRUE)
sort(attrEval(PM10 ~ ., md, "MDL"), decreasing = TRUE)

meja <- 0.01
atributi_Relief <- vrniPomembneAtribute(sort(attrEval(PM10 ~ ., md, "Relief"), decreasing = TRUE), meja)
atributi_InfGain <- vrniPomembneAtribute(sort(attrEval(PM10 ~ ., md, "InfGain"), decreasing = TRUE), meja)
atributi_MDL <- vrniPomembneAtribute(sort(attrEval(PM10 ~ ., md, "MDL"), decreasing = TRUE), meja)
atributi_Gini <- vrniPomembneAtribute(sort(attrEval(PM10 ~ ., md, "Gini"), decreasing = TRUE), meja)
atributi <- intersect(intersect(atributi_Relief, atributi_InfGain), intersect(atributi_MDL, atributi_Gini))
atributi

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

#ODLOCITVENO DREVO
#Gradnja modela s pomocjo knjiznice "rpart"
library(e1071)
nb <- naiveBayes(PM10 ~ ., data = learn)
predicted <- predict(nb, test, type="class")
CA(observed, predicted)

predMat <- predict(nb, test, type = "raw")
brier.score(obsMat, predMat)


nb <- naiveBayes(PM10 ~ Glob_sevanje_mean + Glob_sevanje_max + Vlaga_min + Vlaga_mean + Temperatura_Krvavec_max + Temperatura_lokacija_min + Temperatura_Krvavec_min, data = learn)
predicted <- predict(nb, test, type="class")
CA(observed, predicted)

predMat <- predict(nb, test, type = "raw")
brier.score(obsMat, predMat)

