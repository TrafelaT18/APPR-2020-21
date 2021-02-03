# 3. faza: Vizualizacija podatkov

# Uvozimo zemljevid.
#zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
                            # pot.zemljevida="OB", encoding="Windows-1250")
# Če zemljevid nima nastavljene projekcije, jo ročno določimo
#proj4string(zemljevid) <- CRS("+proj=utm +zone=10+datum=WGS84")

#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
 # { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels=levels(obcine$obcina))

# Izračunamo povprečno velikost družine
#povprecja <- druzine %>% group_by(obcina) %>%
 # summarise(povprecje=sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))

 najvec.pridelkov.regije$regija[10] <- "Notranjsko-kraška"
 najvec.pridelkov.regije$regija[9] <- "Spodnjeposavska"
 
 najvec.zivine.regije$regija[10] <- "Notranjsko-kraška"
 najvec.zivine.regije$regija[9] <- "Spodnjeposavska"
 
 zemljevid <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1", encoding = "UTF-8")
 zemljevid1 <- tm_shape(merge(zemljevid, najvec.pridelkov.regije, by.x="NAME_1", by.y="regija" )) + tm_polygons("povprecje",title="Povprečje") +
   tm_layout(title="Povprečna razširjenost kmetijskih izdelkov po regijah") 
 zemljevid2 <- tm_shape(merge(zemljevid, najvec.zivine.regije, by.x="NAME_1", by.y="regija" )) + tm_polygons("povprecje",title="Povprečje") +
   tm_layout(title="Povprečna razširjenost živinorejskih pridelkov")

 
 #nekaj najpogostejših kultur:

 uvoz.pridelki1 <- uvoz.pridelki %>% filter(kmetijska.kultura == c("Breskve in nektarine v intenzivnih sadovnjakih", 
                                                                  "Krompir", "Jabolka v intenzivnih sadovnjakih",
                                                                  "Belo zelje", "Silažna koruza")) 
       
 graf_indeks <- ggplot(data = uvoz.pridelki1 , aes(x=regija, y=kolicina, color=kmetijska.kultura, group = kmetijska.kultura))  + geom_point(aes(frame=leto)) +scale_fill_gradient(low = '#25511C', high='#2BFF00', limits = c(0,30)) + theme(axis.text.x = element_text(
    color="#000000", size=8, angle=75,hjust=0.5,vjust=0.9))
 #graf_indeks <- graf_indeks + xlab('Pokrajna') + ylab('Količina proizvodov t/ha') 
 graf_indeks <- ggplotly(graf_indeks) 
 