library(dplyr)
library(tidyr)
library(readr)
library(tibble)
library(ggplot2)
library(tibble)
library(tmap)
library(maptools)
library(rgeos)
library(rgdal)

library(tibble)
uvoz.pridelki <- read_csv("podatki/pridelek.csv", locale = locale(encoding = 'Windows-1250'),
                     na = '-') %>% pivot_longer(-1, names_to = 'leto.regija', 
                            values_to = 'kolicina') %>%  separate('leto.regija', into = c('leto', 'regija'), 
                              sep="(?<=[0-9]) ") %>% rename(kmetijska.kultura = "KMETIJSKE KULTURE") %>% 
  arrange(kmetijska.kultura) %>% arrange(leto)
uvoz.pridelki$leto <- as.integer(uvoz.pridelki$leto)

#kolko je posamezne kmetijske kulture bilo v posamezni regiji v povprečju skozi leta
povprecja.pridelkov.regije <- uvoz.pridelki %>% group_by(kmetijska.kultura, regija) %>%
  summarise(povprecje =  mean(kolicina, na.rm = TRUE))
#kolko je povprečno pridelka v Sloveniji v 10 letih
povprecje.pridelkov.slovenija <- povprecja.pridelkov.regije %>% group_by(kmetijska.kultura) %>% 
  summarise(povprecje = mean(povprecje, na.rm = TRUE))
#koliko v posemaznem letu povprečno v SLO
povprecje.pridelkov.leta <- uvoz.pridelki %>% group_by(kmetijska.kultura, leto) %>% 
  summarise(povprecje = mean(kolicina, na.rm = TRUE))
#kje je največ pridelanih pridelkov skozi leta
najvec.pridelkov.regije <- povprecja.pridelkov.regije %>% group_by(regija) %>% 
  summarise(povprecje = mean(povprecje, na.rm = TRUE))


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

#kolko je povprečno zivine v Sloveniji v teh letih
povprecje.zivine.slovenija <- povprecje.zivine.regije %>% group_by(vrsta.zivine) %>% 
  summarise(povprecje = mean(povprecje, na.rm = TRUE))

#koliko je v posamezne letu zivine povprečno
povprecje.zivine.leta <- uvoz.zivina %>% group_by(vrsta.zivine, leto) %>% 
  summarise(povprecje = mean(stevilo.zivali, na.rm = TRUE))

#kje je najvec zivine skozi leta
najvec.zivine.regije <- povprecje.zivine.regije %>% group_by(regija) %>% 
  summarise(povprecje = mean(povprecje, na.rm = TRUE))
