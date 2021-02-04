

library(shiny)

shinyServer(function(input, output) {
  output$pridelki <- DT::renderDataTable({
    povprecja.pridelkov.regije 
  })
  output$zivina <- DT::renderDataTable({
    povprecje.zivine.regije
  
  })
  
  output$pridelki.leta <- renderPlot(
    uvoz.pridelki %>% filter(regija == input$regija1, kmetijska.kultura == input$pridelek1) 
    %>% ggplot(aes(x = leto, y = kolicina)) + geom_point(), 
    height = 400, width = 500
    
  )
  output$zivina.leta <- renderPlot(
    uvoz.zivina %>% filter(regija == input$regija2, vrsta.zivine == input$zivina2) %>%
      ggplot(aes(x = leto, y = stevilo.zivali)) + geom_point(),
    height = 400, width = 500
  )
  
})