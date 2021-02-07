# 3. faza: Vizualizacija podatkov

#graf za najbolj pogostih po regijah !!!!!!!!!!!!!!!!!!!!!

povprecja.5pridelkov.regije <- povprecja.pridelkov.regije[grep('(Jabolka)|(Belo zelje)|(Breskve)|(Silažna koruza)|(Krompir)',povprecja.pridelkov.regije$kmetijska.kultura),]

graf.pridelki.regije <- povprecja.5pridelkov.regije %>% ggplot(aes(x = regija, y = povprecje, color=regija)) +
   geom_point(size=2) + facet_wrap(~kmetijska.kultura, ncol = 5, labeller = label_wrap_gen(width=20)) + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1)) +
   ggtitle('Povprečje posameznih kmetijskih pridelkov po regijah' ) + ylab('Povprečje v t/ha') + xlab('Regija')



#diagram povprečnega števila pridelkov v slo v 10 letih
graf.povprecje.pridelkov.slovenija <- ggplot(aes(x = kmetijska.kultura, y = povprecje, group=1), 
                                             data = povprecje.pridelkov.slovenija) + geom_col(fill='darkseagreen3') + coord_flip() + 
   ggtitle("Povprečje kmetijskih \n kultur v Sloveniji") + ylab('Povprečje v t/ha') + xlab('Kmetijska kultura')



library(scales)
#graf za najbolj pogostih po regijah
vrstice1 <- grep('(Konji)|(Koze)|(Ovce)', povprecje.zivine.regije$vrsta.zivine)                                                    
povprecje.zivine.regije1 <- povprecje.zivine.regije[vrstice1,]
graf.zivina.regije1 <- povprecje.zivine.regije1 %>% ggplot(aes(x = regija, y = povprecje, color=regija)) + 
   geom_point(size = 2) + facet_wrap(~vrsta.zivine, ncol = 3) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
   scale_y_continuous(labels = scales::comma) + ggtitle('Povprečno število živine po regijah') + ylab('Povprečje') + xlab('Regija')
vrstice2 <- grep('(Govedo)|(Perutnina)|(Prašiči)', povprecje.zivine.regije$vrsta.zivine)
povprecje.zivine.regije2 <- povprecje.zivine.regije[vrstice2,]
graf.zivina.regije2 <- povprecje.zivine.regije2 %>% ggplot(aes(x = regija, y = povprecje, color=regija)) + 
   geom_point(size = 2) + facet_wrap(~vrsta.zivine, ncol = 3) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
   scale_y_continuous(labels = scales::comma) + ggtitle('Povprečno število živine po regijah') + ylab('Povprečje') + xlab('Regija')


#diagram
graf.povprecje.zivine.slovenija <- ggplot(aes(x = vrsta.zivine, y = povprecje, group=1), 
   data = povprecje.zivine.slovenija) + geom_col(fill='sienna4') + ggtitle("Povprečje živine v Sloveniji") +
   scale_y_continuous(labels = scales::comma) + ylab('Povprečje') + xlab('Vrsta živine')




#zemljevid

najvec.pridelkov.regije$regija[10] <- "Notranjsko-kraška"
najvec.pridelkov.regije$regija[9] <- "Spodnjeposavska"

najvec.zivine.regije$regija[10] <- "Notranjsko-kraška"
najvec.zivine.regije$regija[9] <- "Spodnjeposavska"

zemljevid <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1", encoding = "UTF-8")
zemljevid1 <- tm_shape(merge(zemljevid, najvec.pridelkov.regije, by.x="NAME_1", by.y="regija" )) + tm_style(style= "natural", bg.color = 'grey') + 
   tm_polygons("povprecje",title="Povprečje kmetijskih \n pridelkov (t/ha)") + tm_layout(title="Povprečna razširjenost kmetijskih pridelkov po regijah") + tm_text('NAME_1', size = 0.7) 
zemljevid2 <- tm_shape(merge(zemljevid, najvec.zivine.regije, by.x="NAME_1", by.y="regija" ))  + tm_style(style= "natural", bg.color = 'grey') + 
   tm_polygons("povprecje",title="Povprečno število \n glav živine") + tm_layout(title="Povprečna razširjenost živinoreje po regijah") + tm_text('NAME_1', size = 0.7)
