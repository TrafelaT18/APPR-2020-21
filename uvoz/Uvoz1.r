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
uvoz.pridelki <- read_csv("podatki/povprecni_pridelek.csv", locale = locale(encoding = 'Windows-1250'),
                          na = '-') %>% rename(kmetijska.kultura = "KMETIJSKE KULTURE", leto = 'LETO',
                        regija = 'STATISTIČNA REGIJA', kolicina = 4) 
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

