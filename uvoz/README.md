# Obdelava, uvoz in čiščenje podatkov.

Tukaj bomo imeli program, ki bo obdelal, uvozil in očistil podatke (druga faza
projekta).

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
             na = '-') %>% pivot_longer(-1, names_to = 'leto.regija', values_to = 'kolicina') %>% 
             separate('leto.regija', into = c('leto', 'regija'), sep="(?<=[0-9]) ") %>%
             rename(kmetijska.kultura = "KMETIJSKE KULTURE") %>% arrange(kmetijska.kultura) %>% arrange(leto)
uvoz.pridelki$leto <- as.integer(uvoz.pridelki$leto)


uvoz.zivina <- read_csv("podatki/zivina.csv", locale = locale(encoding = "Windows-1250"), 
                na = c('N', 'z')) %>% pivot_longer(-(1:2), names_to = 'leto_stevilo.zivali', 
                values_to ='kolicina') %>% separate(leto_stevilo.zivali, into=c('leto', 'stevilo.zivali'), 
                sep = "(?<=[0-9]) ") %>% select(-stevilo.zivali) %>%
    rename(vrsta.zivine = 'VRSTA ŽIVINE', regija = 'STATISTIČNA REGIJA',stevilo.zivali = 'kolicina') %>%
   filter(vrsta.zivine != 'Število glav velike živine [GVŽ]', regija != 'SLOVENIJA') %>% 
   arrange(vrsta.zivine) %>% arrange(leto)
uvoz.zivina <- uvoz.zivina[c(1, 3, 2, 4)]
uvoz.zivina$leto <- as.integer(uvoz.zivina$leto)