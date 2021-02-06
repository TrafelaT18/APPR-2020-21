# 3. faza: Vizualizacija podatkov

#graf za najbolj pogostih po regijah !!!!!!!!!!!!!!!!!!!!!

povprecja.5pridelkov.regije <- povprecja.pridelkov.regije[c(1:24, 85:96, 121:132, 205:216),]

graf.pridelki.regije <- povprecja.5pridelkov.regije %>% ggplot(aes(x = regija, y = povprecje, color=regija)) +
 geom_point(size=2) + facet_wrap(~kmetijska.kultura, ncol = 5, labeller = label_wrap_gen(width=30)) + theme(axis.text.x = element_text(size = 7, angle = 90, vjust = 0.5, hjust=1)) +
  ggtitle('Povprecje posameznih kmetijskih pridelkov po regijah' ) + ylab('povprecje v t/ha')



#diagram povprečnega števila pridelkov v slo v 10 letih
graf.povprecje.pridelkov.slovenija <- ggplot(aes(x = kmetijska.kultura, y = povprecje, group=1), 
                                             data = povprecje.pridelkov.slovenija) + geom_col(fill='darkseagreen3') + coord_flip() + 
   ggtitle("Povprečje kmetijskih kultur v Sloveniji") + xlab('povprecje v t/ha')

#graf kako skozi leta spreminjala količina pridelkov v sloveniji
#!!!!!!!!!!!!!!!!!!!!!!!!
pridelki5.leta <- pridelki.leta[c(1:20, 71:80,101:110, 171:180),]
   
graf.pridelki.leta <- pridelki5.leta %>% ggplot(aes(x = leto, y = kolicina, color=leto)) +
   geom_point(size=2, show.legend = FALSE) + facet_wrap(~kmetijska.kultura, ncol = 5, labeller = label_wrap_gen(width = 20)) + scale_x_continuous(breaks = seq(2010, 2019, 1)) +
   theme(axis.text.x = element_text(size = 7, angle = 90, vjust = 0.5, hjust=0.5)) + ylab('kolicina v t/ha') + ggtitle('Količina kmetijskih kultur po letih')
#graf.pridelki.leta$data$kmetijska.kultura[181:190] <- 'Trajni travniki in pašniki'
#graf.pridelki.leta$data$kmetijska.kultura[11:20] <- 'Breskve in nektarine'
#graf.pridelki.leta$data$kmetijska.kultura[41:50] <- 'Deteljno travne mešanice'
#graf.pridelki.leta$data$kmetijska.kultura[71:80] <- 'Jabolka'
#graf.pridelki.leta$data$kmetijska.kultura[201:210] <- 'Travno deteljne mešanice'

library(scales)
#graf za najbolj pogostih po regijah
graf.zivina.regije <- povprecje.zivine.regije %>% ggplot(aes(x = regija, y = povprecje, color=regija)) + 
   geom_point(size = 1.5) + facet_wrap(~vrsta.zivine, ncol = 3) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
   scale_y_continuous(labels = scales::comma) + ggtitle('Povprečno število živine po regijah') 

#diagram
graf.povprecje.zivine.slovenija <- ggplot(aes(x = vrsta.zivine, y = povprecje, group=1), 
                         data = povprecje.zivine.slovenija) + geom_col(fill='sienna4') + ggtitle("Povprečje živine v Sloveniji") +
   scale_y_continuous(labels = scales::comma)

#graf kako skozi leta spreminjala količina zivine v sloveniji
graf.zivina.leta <- zivina.leta %>% ggplot(aes(x = leto, y = kolicina, color=leto)) +
   geom_point(size=2, show.legend = FALSE) + facet_wrap(~vrsta.zivine, ncol = 6) + scale_x_continuous(minor_breaks =seq(2003, 2025, 1),
                                                 breaks = c(2003, 2005, 2007, 2010, 2013, 2016, 2019, 2022, 2025)) +
   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + scale_y_continuous(breaks = seq(0, 6000000, 1000000), labels = scales::comma) +
   ggtitle('Število živine po letih')





#zemljevid

 najvec.pridelkov.regije$regija[10] <- "Notranjsko-kraška"
 najvec.pridelkov.regije$regija[9] <- "Spodnjeposavska"
 
 najvec.zivine.regije$regija[10] <- "Notranjsko-kraška"
 najvec.zivine.regije$regija[9] <- "Spodnjeposavska"

 zemljevid <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1", encoding = "UTF-8")
 zemljevid1 <- tm_shape(merge(zemljevid, najvec.pridelkov.regije, by.x="NAME_1", by.y="regija" )) + tm_style(style= "natural", bg.color = 'grey') + 
    tm_polygons("povprecje",title="Povprečje kmetijskih pridelkov (t/ha)") + tm_layout(title="Povprečna razširjenost kmetijskih pridelkov po regijah") + tm_text('NAME_1') 
 zemljevid2 <- tm_shape(merge(zemljevid, najvec.zivine.regije, by.x="NAME_1", by.y="regija" ))  + tm_style(style= "natural", bg.color = 'grey') + 
    tm_polygons("povprecje",title="Povprečno število glav živine") + tm_layout(title="Povprečna razširjenost živinoreje po regijah") + tm_text('NAME_1')
 
 
