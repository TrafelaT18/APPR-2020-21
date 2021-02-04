
uvoz.pridelki <- read_csv("podatki/pridelek.csv", locale = locale(encoding = 'Windows-1250'),na = '-') %>% 
                            pivot_longer(-1, names_to = 'leto.regija', 
                            values_to = 'kolicina') %>%  separate('leto.regija', into = c('leto', 'regija'), 
                              sep="(?<=[0-9]) ") %>% rename(kmetijska.kultura = "KMETIJSKE KULTURE") %>% 
                          arrange(kmetijska.kultura) %>% arrange(leto)
uvoz.pridelki$leto <- as.integer(uvoz.pridelki$leto)

#kolko je posamezne kmetijske kulture bilo v posamezni regiji v povprečju skozi leta
povprecja.pridelkov.regije <- uvoz.pridelki %>% group_by(kmetijska.kultura, regija) %>%
  summarise(povprecje =  mean(kolicina, na.rm = TRUE))
#graf za najbolj pogostih po regijah
graf.pridelki.regije <- povprecja.pridelkov.regije %>% ggplot(aes(x = regija, y = povprecje)) +
  geom_point() + facet_wrap(~kmetijska.kultura, ncol = 6) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
graf.pridelki.regije

#kolko je povprečno pridelka v Sloveniji v 10 letih
povprecje.pridelkov.slovenija <- povprecja.pridelkov.regije %>% group_by(kmetijska.kultura) %>% 
  summarise(povprecje = mean(povprecje, na.rm = TRUE)) %>% arrange(povprecje)
#diagram
graf.povprecje.pridelkov.slovenija <- ggplot(aes(x = kmetijska.kultura, y = povprecje, group=1), 
         data = povprecje.pridelkov.slovenija) + geom_col() + coord_flip() + 
  ggtitle("Povprečje kmetijskih kultur") 
graf.povprecje.pridelkov.slovenija


#koliko v posemaznem letu povprečno v SLO
povprecje.pridelkov.leta <- uvoz.pridelki %>% group_by(kmetijska.kultura, leto) %>%
  summarise(povprecje = mean(kolicina, na.rm = TRUE))
#graf kako skozi leta spreminjala količina pridelkov v sloveniji

graf.pridelki.leta <- povprecje.pridelkov.leta %>% ggplot(aes(x = leto, y = povprecje)) +
  geom_step() + facet_wrap(~kmetijska.kultura, ncol = 6) + scale_x_continuous(breaks = seq(2010, 2019, 1)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))
graf.pridelki.leta

#kje je največ pridelanih pridelkov skozi leta
najvec.pridelkov.regije <- povprecja.pridelkov.regije %>% group_by(regija) %>% 
  summarise(povprecje = mean(povprecje, na.rm = TRUE))

#pridelki v slo skozi leta
pridelki.leta <- povprecje.pridelkov.leta %>% group_by(leto) %>% 
  summarise(povprecje=mean(povprecje, na.rm=TRUE))




uvoz.zivina <- read_csv("podatki/zivina.csv", locale = locale(encoding = "Windows-1250"), 
                na = c('N', 'z')) %>% pivot_longer(-(1:2), names_to = 'leto_stevilo.zivali', values_to = 'kolicina') %>%
  separate(leto_stevilo.zivali, into=c('leto', 'stevilo.zivali'), sep = "(?<=[0-9]) ") %>% select(-stevilo.zivali) %>%
    rename(vrsta.zivine = 'VRSTA ŽIVINE', regija = 'STATISTIČNA REGIJA',stevilo.zivali = 'kolicina') %>%
   filter(vrsta.zivine != 'Število glav velike živine [GVŽ]', regija != 'SLOVENIJA') %>% arrange(vrsta.zivine) %>% arrange(leto)
uvoz.zivina <- uvoz.zivina[c(1, 3, 2, 4)]
uvoz.zivina$leto <- as.integer(uvoz.zivina$leto)


#kolko je bilo zivine v teh letih v povprecju po regijah
povprecje.zivine.regije <- uvoz.zivina %>% group_by(vrsta.zivine, regija) %>% 
  summarise(povprecje = mean(stevilo.zivali, na.rm = TRUE))
#graf za najbolj pogostih po regijah
graf.zivina.regije <- povprecje.zivine.regije %>% ggplot(aes(x = regija, y = povprecje)) +
  geom_point() + facet_wrap(~vrsta.zivine, ncol = 6) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
graf.zivina.regije


#kolko je povprečno zivine v Sloveniji v teh letih
povprecje.zivine.slovenija <- povprecje.zivine.regije %>% group_by(vrsta.zivine) %>% 
  summarise(povprecje = mean(povprecje, na.rm = TRUE))
#diagram
graf.povprecje.zivine.slovenija <- ggplot(aes(x = vrsta.zivine, y = povprecje, group=1), 
                      data = povprecje.zivine.slovenija) + geom_col() + ggtitle("Povprečje živine")
graf.povprecje.zivine.slovenija

#koliko je v posamezne letu zivine povprečno
povprecje.zivine.leta <- uvoz.zivina %>% group_by(vrsta.zivine, leto) %>% 
  summarise(povprecje = mean(stevilo.zivali, na.rm = TRUE))
#graf kako skozi leta spreminjala količina zivine v sloveniji
graf.zivina.leta <- povprecje.zivine.leta %>% ggplot(aes(x = leto, y = povprecje)) +
  geom_step() + facet_wrap(~vrsta.zivine, ncol = 6) + scale_x_continuous(breaks = seq(2003, 2016, 2)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))
graf.zivina.leta

#kje je najvec zivine skozi leta
najvec.zivine.regije <- povprecje.zivine.regije %>% group_by(regija) %>% 
  summarise(povprecje = mean(povprecje, na.rm = TRUE))

#zivina v slo skozi leta
zivina.leta <- povprecje.zivine.leta %>% group_by(leto) %>% summarise(povprecje=mean(povprecje, na.rm=TRUE))

#zdrženi tabeli za povprečje živine in pridelkov po regijah
zdruzen.zivina <- povprecje.zivine.regije %>% rename(kmetijski.pridelek = vrsta.zivine)
zdruzen.pridelek <- povprecja.pridelkov.regije %>% rename(kmetijski.pridelek = kmetijska.kultura)
povprecje.regije <- rbind(zdruzen.pridelek, zdruzen.zivina) 

pridelki <- uvoz.pridelki
zivina <- uvoz.zivina




