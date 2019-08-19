# Define UI for app that draws a histogram ----
ui <- fluidPage(
  # App title ----
  titlePanel("ConMine"),
  sidebarLayout(sidebarPanel(selectInput(inputId = "Species_Choice",
                                         label = "Choose a letter:",
                                         choices = names)),
                mainPanel(tabsetPanel(type = "tabs",
                          tabPanel("Species",verbatimTextOutput("test")),
                          tabPanel("Trait data",
                           tabsetPanel(type = "tabs",
                            tabPanel("Real Data"),
                            tabPanel("Imputed Data",
                             selectInput(inputId = "imputed_trait",
                              label = "Choose a imputed trait:",
                               choices = c("Life span","Body size")),
                             plotOutput("Imputed_Plot")))
                                               )
      )                                 
    )             
  )
)
