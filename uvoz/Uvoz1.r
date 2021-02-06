uvoz.pridelki <- read_csv("podatki/pridelek.csv", locale = locale(encoding = 'Windows-1250'),na = '-') %>% 
  pivot_longer(-1, names_to = 'leto.regija', 
               values_to = 'kolicina') %>%  separate('leto.regija', into = c('leto', 'regija'), 
                                                     sep="(?<=[0-9]) ") %>% rename(kmetijska.kultura = "KMETIJSKE KULTURE") %>% 
  arrange(kmetijska.kultura) %>% arrange(leto) 
uvoz.pridelki$leto <- as.integer(uvoz.pridelki$leto)


#povprečje posameznih kmetijskih kultur po ragijaj
povprecja.pridelkov.regije <- uvoz.pridelki %>%
  group_by(kmetijska.kultura, regija) %>%
  summarise(povprecje =  mean(kolicina, na.rm = TRUE)) 

#kolko je povprečno pridelka v Sloveniji v 10 letih
povprecje.pridelkov.slovenija <- povprecja.pridelkov.regije %>% group_by(kmetijska.kultura) %>% 
  summarise(povprecje = sum(povprecje, na.rm = TRUE)) %>% arrange(povprecje)




#pridelki po letih v slo skupno
pridelki.leta <- uvoz.pridelki %>% group_by(kmetijska.kultura, leto) %>%
  summarise(kolicina = sum(kolicina, na.rm = TRUE))


#V katerih ragijah je povprečno največ skupno pridelanih pridelkov 
najvec.pridelkov.regije <- povprecja.pridelkov.regije %>% group_by(regija) %>% 
  summarise(povprecje = sum(povprecje, na.rm = TRUE))

#povprečje pridelkov v slo v vsakem letu
skupno.pridelki.leta <- pridelki.leta %>% group_by(leto) %>% 
  summarise(kolicina=sum(kolicina, na.rm=TRUE))


uvoz.zivina <- read_csv("podatki/zivina.csv", locale = locale(encoding = "Windows-1250"), 
                        na = c('N', 'z')) %>% pivot_longer(-(1:2), names_to = 'leto_stevilo.zivali', values_to = 'kolicina') %>%
  separate(leto_stevilo.zivali, into=c('leto', 'stevilo.zivali'), sep = "(?<=[0-9]) ") %>% select(-stevilo.zivali) %>%
  rename(vrsta.zivine = 'VRSTA ŽIVINE', regija = 'STATISTIČNA REGIJA',stevilo.zivali = 'kolicina') %>%
  filter(vrsta.zivine != 'Število glav velike živine [GVŽ]', regija != 'SLOVENIJA') %>% arrange(vrsta.zivine) %>% arrange(leto)
uvoz.zivina <- uvoz.zivina[c(1, 3, 2, 4)]
uvoz.zivina$leto <- as.integer(uvoz.zivina$leto)


#Povprečno število živine po regijah po regijah
povprecje.zivine.regije <- uvoz.zivina %>% group_by(vrsta.zivine, regija) %>% 
  summarise(povprecje = mean(stevilo.zivali, na.rm = TRUE))
povprecje.zivine.regije$povprecje <- round(povprecje.zivine.regije$povprecje, 2)



#kolko je povprečno posamezne zivine v Sloveniji 
povprecje.zivine.slovenija <- povprecje.zivine.regije %>% group_by(vrsta.zivine) %>% 
  summarise(povprecje = sum(povprecje, na.rm = TRUE))


#koliko je povprečno vsake živine v vsakem letu 
zivina.leta <- uvoz.zivina %>% group_by(vrsta.zivine, leto) %>% 
  summarise(kolicina = sum(stevilo.zivali, na.rm = TRUE))


#v kateri regiji je povprečno največ živine
najvec.zivine.regije <- povprecje.zivine.regije %>% group_by(regija) %>% 
  summarise(povprecje = sum(povprecje, na.rm = TRUE))

#povprečno število skupne živine v vsakem letu v Sloveniji
skupno.zivina.leta <- zivina.leta %>% group_by(leto) %>% summarise(kolicina=sum(kolicina, na.rm=TRUE))



