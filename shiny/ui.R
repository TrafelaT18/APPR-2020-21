

library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Kmetijstvo in živinoreja"),
  
  tabsetPanel(
    tabPanel("Povprečje kmetijskih pridelkov po regijah",
             DT::dataTableOutput("pridelki")),
    
    tabPanel("Posamezen izdelek skozi leta",
             sidebarPanel(
               selectInput(inputId = "pridelek",
                           label = "Izberi kmetijski pridelek",
                           choices = unique(uvoz.pridelki$kmetijska.kultura))),
             mainPanel(plotOutput("pridelek")))
  )
))

