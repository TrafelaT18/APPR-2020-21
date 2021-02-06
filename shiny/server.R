library(shiny)

shinyServer(function(input, output) {
  output$pridelki <- DT::renderDataTable({
    povprecja.pridelkov.regije %>% rename('Kmetijska kultura' = kmetijska.kultura) %>% 
      rename('Povprečje' = povprecje) %>% rename('Regija' = regija)
  })
  output$zivina <- DT::renderDataTable({
    povprecje.zivine.regije %>% rename('Vrsta živine' = vrsta.zivine) %>% rename('Povprečje' = povprecje) %>% rename('Regija' = regija)
    
  })
  
  output$skupno.pridelki.leta <- renderPlot(
    uvoz.pridelki %>% filter(regija == input$regija1, kmetijska.kultura == input$pridelek1) 
    %>% ggplot(aes(x = leto, y = kolicina)) + geom_point(size=3) + scale_x_continuous(breaks = seq(2010, 2019, 1)) + 
      theme(plot.title = element_text(hjust = 0.5)) + 
      ggtitle(paste('Količina pridelka -', input$pridelek1, ', \n v regiji', input$regija1)) + ylab('Količina v t/ha') + 
      xlab('Leto'),
    height = 400, width = 500
    
  )
  output$skupno.zivina.leta <- renderPlot(
    uvoz.zivina %>% filter(regija == input$regija2, vrsta.zivine == input$zivina2) %>%
      ggplot(aes(x = leto, y = stevilo.zivali)) + geom_point(size=3) +
      scale_x_continuous(minor_breaks = seq(2003, 2016, 1), breaks = c(2003, 2005, 2007, 2010, 2013, 2016)) +
      ggtitle(paste('Število glav živali -', input$zivina2, ', v regiji', input$regija2)) + xlab('Leto') + ylab('Število živali'),
    height = 400, width = 500
  )
  
})