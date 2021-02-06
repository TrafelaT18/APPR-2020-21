# 4. faza: Analiza podatkov



#Kako se količina kmetijskih pridelkov skupno skozi leta spreminja
g1 <- ggplot(skupno.pridelki.leta, aes(x=leto, y=kolicina)) + geom_point(color='dark blue')
lin1 <- lm(data = skupno.pridelki.leta, kolicina ~ leto)
graf1 = g1 + geom_smooth(method='lm',fullrange=TRUE,color='black', formula = y~x)
nova1 <- data.frame(leto=seq(2010, 2025, 1))
napoved1 <- mutate(nova1, kolicina=predict(lin1, nova1))
graf_napoved1 <- graf1 + geom_point(data=napoved1, aes(x=leto, y=kolicina), color='red', size = 2) +
  ggtitle('Napoved nadaljnega povprečja pridelkov v Sloveniji po letih') + scale_x_continuous(breaks = seq(2010, 2025, 1)) +
  ylab('kolicina v t/ha') 
  
g2<- ggplot(skupno.zivina.leta, aes(x=leto, y=kolicina)) + geom_point()
lin2 <- lm(data = skupno.zivina.leta, kolicina ~ leto)
graf2 = g2 + geom_smooth(method='lm',fullrange=TRUE,color='black', formula = y~x)
nova2 <- data.frame(leto=c(2003, 2005, 2007, 2010, 2013, 2016, 2019, 2022, 2025))
napoved2 <- mutate(nova2, kolicina=predict(lin2, nova2))
graf_napoved2 <- graf2 + geom_point(data=napoved2, aes(x=leto, y=kolicina), color='red', size = 2) +
  ggtitle('Napoved nadaljnega povprečja živine v Sloveniji po letih') +
  scale_x_continuous(minor_breaks =seq(2003, 2025, 1)  , breaks = c(2003, 2005, 2007, 2010, 2013, 2016, 2019, 2022, 2025)) +
  scale_y_continuous(labels = scales::comma)