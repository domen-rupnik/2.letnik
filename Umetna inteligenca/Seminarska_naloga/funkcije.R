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

library(lubridate)
izris_povprecje_ozonaInPM10_mesec1 <- function(tabela)
{
  datumi <- tabela$Datum
  meseci <- month(datumi)
  kolicina_ozona <- tabela$O3
  kolicina_PM10 <- tabela$PM10
  stevilo_elementi_mesec <- c()
  povprecje_ozon_meseci <- c()
  povprecje_PM10_meseci <- c()
  imena_meseci2 <- c(1,2,3,4,5,6,7,8,9,10,11,12)
  for( i in 1:12){
    povprecje_ozon_meseci[i] <- 0
    povprecje_PM10_meseci[i] <- 0
    stevilo_elementi_mesec[i] <- 0
  }
  for (i in 1:nrow(tabela)){
    povprecje_ozon_meseci[month(datumi[i])] <-  povprecje_ozon_meseci[month(datumi[i])] + kolicina_ozona[i]
    povprecje_PM10_meseci[month(datumi[i])] <- povprecje_PM10_meseci[month(datumi[i])] + kolicina_PM10[i]
    stevilo_elementi_mesec[month(datumi[i])] <- 1 + stevilo_elementi_mesec[month(datumi[i])]
  }
  for(i in 1:12){
    povprecje_ozon_meseci[i] <- povprecje_ozon_meseci[i] / stevilo_elementi_mesec[i]
    povprecje_PM10_meseci[i] <- povprecje_PM10_meseci[i] / stevilo_elementi_mesec[i]
  }
  povprecje <- data.frame(povprecje_ozon_meseci, povprecje_PM10_meseci, imena_meseci2)
  izris_povprecje_ozonaInPM10_mesec2(povprecje)
}
izris_povprecje_ozonaInPM10_mesec2 <- function(povprecje)
{
  plot(povprecje$imena_meseci2, povprecje$povprecje_ozon_meseci, type = "l", col = "red", xlab = "Mesec", ylab = "Vrednost ozona ter PM10 delcev", main = "Povpre�je ozona in PM10 delcev glede na mesec", ylim = c(0,140))
  lines(povprecje$imena_meseci2, povprecje$povprecje_PM10_meseci, col = "blue")
  axis(1, seq(1,12,1))
  legend("topleft", legend=c("Ozon", "PM10 delci"),
         col=c("red", "blue"), lty = 1:1, cex=0.8)
}
graf <- function(x,y,z,tit, xl, yl)
{
  plot(x, y, main=tit, col=rgb(100,250,100,70,maxColorValue=255), pch=16, xlab = xl, ylab = yl)
  lines(x, z, type = "p", col = rgb(250, 100, 100,70, maxColorValue = 255), pch = 16)
  legend("topright",c("O3","PM10"),cex=.8,col=c("green","red"),pch=c(1,1))
  
}
vrniPomembneAtribute <- function(atributi, meja){
  a <- vector()
  for(i in 1:length(atributi)){
    if(atributi[i] >= meja){
      a <- c(a, labels(atributi[i]))
    }
  }
  return(a)
}

Sensitivity <- function(observed, predicted, pos.class)
{
	t <- table(observed, predicted)

	t[pos.class, pos.class] / sum(t[pos.class,])
}

Specificity <- function(observed, predicted, pos.class)
{
	t <- table(observed, predicted)
	neg.class <- which(row.names(t) != pos.class)

	t[neg.class, neg.class] / sum(t[neg.class,])
}

scale.data <- function(data)
{
	norm.data <- data

	for (i in 1:ncol(data))
	{
		if (!is.factor(data[,i]))
			norm.data[,i] <- scale(data[,i])
	}
	
	norm.data
}
