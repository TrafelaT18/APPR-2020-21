# 4. faza: Analiza podatkov

#podatki <- obcine %>% transmute(obcina, povrsina, gostota,
  #                              gostota.naselij=naselja/povrsina) %>%
 # left_join(povprecja, by="obcina")
#row.names(podatki) <- podatki$obcina
#podatki$obcina <- NULL

# Število skupin
#n <- 5
#skupine <- hclust(dist(scale(podatki))) %>% cutree(n)



#Kako se količina pridelkov skupno skozi leta spreminja
g1 <- ggplot(pridelki.leta, aes(x=leto, y=povprecje)) + geom_point(color='dark blue')
lin1 <- lm(data = pridelki.leta, povprecje ~ leto)
graf1 = g1 + geom_smooth(method='lm',fullrange=TRUE,color='black', formula = y~x)
nova1 <- data.frame(leto=seq(2010, 2025, 1))
napoved1 <- mutate(nova1, povprecje=predict(lin1, nova1))
graf_napoved1 <- graf1 + geom_point(data=napoved1, aes(x=leto, y=povprecje), color='red') +
  ggtitle('Napoved nadaljnega povprečja pridelkov v Sloveniji po letih')
  
g2<- ggplot(zivina.leta, aes(x=leto, y=povprecje)) + geom_point()
lin2 <- lm(data = zivina.leta, povprecje ~ leto)
graf2 = g2 + geom_smooth(method='lm',fullrange=TRUE,color='black', formula = y~x)
nova2 <- data.frame(leto=c(2003, 2005, 2007, 2010, 2013, 2016, 2019, 2022, 2025))
napoved2 <- mutate(nova2, povprecje=predict(lin2, nova2))
graf_napoved2 <- graf2 + geom_point(data=napoved2, aes(x=leto, y=povprecje), color='red') +
  ggtitle('Napoved nadaljnega povprečja živine v Sloveniji po letih')