# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  
  ##LIFE HISTORY TRAITS
  
  #Imputed data plotting
  output$Imputed_Plot <- renderPlot({plot_imputation(gsub(" ","_",input$Species_Choice),
                                                Imputed_data,
                                                Imputed_report,
                                                input$imputed_trait)})
    
  output$test <- renderText({"Hi"})
}