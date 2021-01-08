library(lubridate)
library(ggplot2)
source("funkcije.R")
setwd('C:/Users/Uporabnik/Documents/Faks/2.letnik/Umetna_inteligenca/Seminarska_naloga/')
md <- read.table("podatkiSem1.txt", header = T, sep = ",")

#GRAF Povprečje ozona in PM10 delcev glede na mesec

izris_povprecje_ozonaInPM10_mesec1(md)

#Izris grafov
#

ggplot(md, aes(x = Glob_sevanje_mean, y = O3)) + geom_point() + geom_smooth(method = "lm", se = F) + xlab("Globalno sevanje") + ggtitle("Vpliv globalnega sevanja na ozon")
ggplot(md, aes(x = Glob_sevanje_mean, y = PM10)) + geom_point() + geom_smooth(method = "lm", se = F)

ggplot(md, aes(x = O3, y = PM10)) + geom_point() + geom_smooth(method = "lm", se = F) + geom_curve()
ggplot(md, aes(x = PM10, y = O3)) + geom_point() + geom_smooth(method = "lm", se = F)

ggplot(md, aes(x = Temperatura_Krvavec_mean, y = O3)) + geom_point() + geom_smooth(method = "lm", se = F)


graf(md$Glob_sevanje_max, md$O3, md$PM10, "Vpliv max globalnega sevanja na O3 in PM10", "Globalno sevanje", "Vrednosti O3 in PM10")
graf(md$Glob_sevanje_mean, md$O3, md$PM10, "Vpliv povprecnega globalnega sevanja na O3 in PM10", "Globalno sevanje", "Vrednosti O3 in PM10")
graf(md$Glob_sevanje_min, md$O3, md$PM10, "Vpliv min globalnega sevanja na O3 in PM10", "Globalno sevanje", "Vrednosti O3 in PM10")
graf(md$Hitrost_vetra_max, md$O3, md$PM10, "Vpliv max hitrosti vetra na O3 in PM10", "Hitrost vetra", "Vrednosti O3 in PM10")
graf(md$Hitrost_vetra_mean, md$O3, md$PM10, "Vpliv povrecne hitrosti vetra na O3 in PM10", "Hitrost vetra", "Vrednosti O3 in PM10")
graf(md$Hitrost_vetra_min, md$O3, md$PM10, "Vpliv min hitrosti vetra na O3 in PM10", "Hitrost vetra", "Vrednosti O3 in PM10")
graf(md$Sunki_vetra_max, md$O3, md$PM10, "Vpliv max sunki vetra na O3 in PM10", "Sunki vetra", "Vrednosti O3 in PM10")
graf(md$Sunki_vetra_mean, md$O3, md$PM10, "Vpliv povprecje sunki vetra na O3 in PM10", "Sunki vetra", "Vrednosti O3 in PM10")
graf(md$Sunki_vetra_min, md$O3, md$PM10, "Vpliv min sunki vetra na O3 in PM10", "Sunki vetra", "Vrednosti O3 in PM10")
graf(md$Padavine_mean, md$O3, md$PM10, "Vpliv povprecje padavin na O3 in PM10", "Padavine", "Vrednosti O3 in PM10")
graf(md$Padavine_sum, md$O3, md$PM10, "Vpliv sestevka padavin na O3 in PM10", "Padavine", "Vrednosti O3 in PM10")
graf(md$Pritisk_max, md$O3, md$PM10, "Vpliv max pritiska na O3 in PM10", "Pritisk", "Vrednosti O3 in PM10")
graf(md$Pritisk_mean, md$O3, md$PM10, "Vpliv povprecnega pritiska na O3 in PM10", "Pritisk", "Vrednosti O3 in PM10")
graf(md$Pritisk_min, md$O3, md$PM10, "Vpliv min pritiska na O3 in PM10", "Pritisk", "Vrednosti O3 in PM10")
graf(md$Vlaga_max, md$O3, md$PM10, "Vpliv max vlage na O3 in PM10", "Vlaga", "Vrednosti O3 in PM10")
graf(md$Temperatura_lokacija_max, md$O3, md$PM10, "Vpliv najvisje temperature na O3 in PM10", "Temperatura", "Vrednosti O3 in PM10")
graf(md$Temperatura_lokacija_mean, md$O3, md$PM10, "Vpliv povprecne temperature na O3 in PM10", "Temperatura", "Vrednosti O3 in PM10")
graf(md$Temperatura_Krvavec_max, md$O3, md$PM10, "Vpliv najvisje temperature na O3 in PM10", "Temperatura", "Vrednosti O3 in PM10")
graf(md$Temperatura_Krvavec_mean, md$O3, md$PM10, "Vpliv povprecne temperature na O3 in PM10", "Temperatura", "Vrednosti O3 in PM10")
graf(md$O3, md$Predviden_O3, md$PM10, "Vpliv povprecne temperature na O3 in PM10", "Temperatura", "Vrednosti O3 in PM10")

plot(md$O3, md$Predviden_O3, col = "green", ylab = "O3", xlab = "Predvidena vrednost O3", main = "Primerjava predvidene vrednosti O3 in dejanske O3")
plot(md$PM10, md$Predviden_PM10, col = "red", ylab = "PM10", xlab = "Predvidena vrednost PM10", main = "Primerjava predvidene vrednosti PM10 in dejanske PM10")



md$Mesec <- month(md$Datum)
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



















#Faktoriziranje meseca
md$Mesec<-factor(month(md$Datum))
md$Leto <- factor(year(md$Datum))

for(i in 1:nrow(md))
{
  if(i > 3){
    md$Predviden_O3[i] <- (md$O3[i-1] + md$O3[i-2] + md$O3[i-3])/3
    md$Predviden_PM10[i] <- (md$PM10[i-1] + md$PM10[i-2] + md$PM10[i-3])/3
  }
}
a <- md$O3[3-1]
b <- md$O3[3-2]
c <- (a + b)/2
d <- md$PM10[3-1]
e <- md$PM10[3-2]
f <- d + e
md$Predviden_O3[3] <- c / 2
md$Predviden_PM10[3] <- f / 2


md$Predviden_O3[1] <- md$O3[1]
md$Predviden_PM10[1] <- md$PM10[1]
md$Predviden_PM10[2] <- md$PM10[2]
md$Predviden_O3[2] <- md$O3[2]
md
