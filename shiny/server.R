library(shiny)

shinyServer(function(input, output) {
  output$druzine <- DT::renderDataTable({
    druzine %>% pivot_wider(names_from="velikost.druzine", values_from="stevilo.druzin") %>%
      rename(`Občina`=obcina)
  })
  
  output$pokrajine <- renderUI(
    selectInput("pokrajina", label="Izberi pokrajino",
                choices=c("Vse", levels(obcine$pokrajina)))
  )
  output$naselja <- renderPlot({
    main <- "Pogostost števila naselij"
    if (!is.null(input$pokrajina) && input$pokrajina %in% levels(obcine$pokrajina)) {
      t <- obcine %>% filter(pokrajina == input$pokrajina)
      main <- paste(main, "v regiji", input$pokrajina)
    } else {
    t <- obcine
    }
    ggplot(t, aes(x=naselja)) + geom_histogram() +
      ggtitle(main) + xlab("Število naselij") + ylab("Število občin")
  })
})



shinyServer(function(input, output) {
  output$pridelki <- DT::renderDataTable({
    povprecja.pridelkov.regije 
  })
  
  output$pokrajine <- renderUI(
    selectInput("regija", label="Izberi regijo",
                choices=c("Vse", uvoz.pridelki$regija)),
    selectInput("pridelek", label="Izberi pridelek",
                choices=c("Vse", uvoz.pridelki$kmetijska.kultura))
  )
  output$regija <- renderPlot({
    main <- "Pogostost števila naselij"
    if (!is.null(input$regija) && input$regija %in% levels(uvoz.pridelki$regija)) {
      t <- uvoz.pridelki %>% filter(regija == input$regija)
      main <- paste(main, "v regiji", input$regija)
    } else {
      t <- uvoz.pridelki
    }
    
    ggplot(t, aes(x=regija)) + geom_point() +
      ggtitle(main) + xlab("Število naselij") + ylab("Število občin")
  })
})