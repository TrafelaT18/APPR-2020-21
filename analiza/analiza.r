# 4. faza: Analiza podatkov

#podatki <- obcine %>% transmute(obcina, povrsina, gostota,
  #                              gostota.naselij=naselja/povrsina) %>%
 # left_join(povprecja, by="obcina")
#row.names(podatki) <- podatki$obcina
#podatki$obcina <- NULL

# Število skupin
#n <- 5
#skupine <- hclust(dist(scale(podatki))) %>% cutree(n)




g <- ggplot(pridelki.leta, aes(x=leto, y=povprecje)) + geom_point()
lin <- lm(data = pridelki.leta, povprecje ~ leto)
graf = g + geom_smooth(method='lm', formula = y~x) 
napoved <- predict(lin, data.frame(leto=seq(2010, 2025, 1)))