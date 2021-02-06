library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Kmetijski pridelki in živinoreja"),
  
  tabsetPanel(
    
    tabPanel("Posamezen kmetijski pridelek skozi leta",
             sidebarPanel(
               selectInput(inputId = "pridelek1",
                           label = "Izberi kmetijski pridelek",
                           choices = unique(uvoz.pridelki$kmetijska.kultura)),
               selectInput(inputId = "regija1",
                           label = "Izberi regijo",
                           choices = unique(uvoz.pridelki$regija))
               
             ),
             mainPanel(plotOutput("skupno.pridelki.leta"))
    ),
    tabPanel("Posamezna vrsta živine skozi leta",
             sidebarPanel(
               selectInput(inputId = "zivina2",
                           label = "Izberi vrsto živine",
                           choices = unique(uvoz.zivina$vrsta.zivine)),
               selectInput(inputId = "regija2",
                           label = "Izberi regijo",
                           choices = unique(uvoz.zivina$regija))
               
             ),
             mainPanel(plotOutput("skupno.zivina.leta"))
    ),
    tabPanel("Povprečje kmetijskih pridelkov po regijah",
             DT::dataTableOutput("pridelki")),
    tabPanel("Povprečno število glav živine po regijah",
             DT::dataTableOutput("zivina"))
  )
)
)