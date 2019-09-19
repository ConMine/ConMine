##Source other files
source("InstallPackages.R")
source("helpers.R")
source("ImputationPlots.R")
source("MapTrade.R")
source("MapTradeNetwork.R")
source("DownloadImage.R")

##Server
server <- function(input, output) {
  
  #####
  #SPECIES INFORMATION
  #####
  
  #Species Name + synonym
  output$species_name <- renderText({input$Species_Choice})
  output$synonym <- renderText({
    df <- other_data %>%
      filter(Species == gsub(" ","_",input$Species_Choice))
    
    syn <- df$synonyms.value[-which(df$synonyms.value == "value")]
    
    if(!is_empty(syn)){
      return(paste(syn,sep = "<br>"))
    }
  })    
  
  #Redlist information
  output$redlist <- renderTable({
    #get redlist catagories
    df <- other_data %>%
      filter(Species == gsub(" ","_",input$Species_Choice),Database == "iucn")%>%
      select(contains("historical_categories"),
             contains("red_list_category"),
             -historical_categories.value,
             Database) %>%
      gather("title","value") %>%
      separate(title,c("title","N"),"value") %>%
      filter(!is.na(value), title != "Database") %>%
      mutate(N = as.numeric(N),
             N =  N + N %% 2,
             N = ifelse(grepl("red_list",title), 0 , N ) )
    
    cites <- data.frame(matrix(NA,ncol = 2, nrow = nrow(df)/2))
    
    if(nrow(cites) > 0){
      for(i in 1:(nrow(df)/2)){
        pair <- subset(df,df$N == unique(df$N)[i])
        cites[i,1] <- pair$value[which(!is.na(suppressWarnings(as.numeric(pair$value))))]
        cites[i,2] <- pair$value[which(is.na(suppressWarnings(as.numeric(pair$value))))]
      }
      
      colnames(cites) <- c("Year","Red List Category")
      return(cites[order(cites$Year),])
      
    } else {
      return(data.frame("Red List" = "No Red-listing"))
    }
  })  
  
  #species Notes
  output$taxa_notes <- renderText({
    df <- marked_text %>%
      filter(SpeciesID == gsub(" ","_",input$Species_Choice),Country == input$Country_Choice)
    
    if(is.na(df$taxonomic_notes[1])){
      return("No taxanomic notes available.")  
    }else{
      return(df$taxonomic_notes[1])
    } 
  })
  
  output$range_notes <- renderText({
    df <- marked_text %>%
      filter(SpeciesID == gsub(" ","_",input$Species_Choice),Country == input$Country_Choice)
    
    if(is.na(df$range_notes[1])){
      return("No range notes available.")  
    }else{
      return(df$range_notes[1])
    } 
  })
  
  output$range_trend <- renderText({
    df <- other_data %>%
      filter(Species == gsub(" ","_",input$Species_Choice),Database == "iucn")
    
    if(nrow(df) > 0){
      
      if(df$range_trend.value != "value" & !is.na(df$range_trend.value) ){
        return(df$range_trend.value[1])
      } else {
        return("No range trend information available.")
      }
      
    } else {
      return("No range trend information available.")
    }
  })
  
  output$habitat <- renderTable({
    df <- other_data %>%
      filter(Species == gsub(" ","_",input$Species_Choice),Database == "iucn") %>%
      select(contains("habitats"))
    
  })
  
  #picture
  output$picture<-renderText({
    pic <- getwikipic(input$Species_Choice)
    if(!is.na(pic)){
      return(c('<img src="',pic,'">'))
    }else{
      return("No picture available :(")
    }
  })
  
  
  ##LIFE HISTORY TRAITS
  output$trait_data <- renderTable({
    df <- Real_data %>%
      filter(Species == gsub(" ","_",input$Species_Choice),Database == "iucn")
    
  })
  
  #Imputed data plotting
  output$Imputed_Plot <- renderPlot({
    plot_imputation(gsub(" ","_",input$Species_Choice),
                    Imputed_data,
                    Imputed_report,
                    input$imputed_trait)
  })
  
  
  #threats and conservaiton
  output$redlist_notes <- renderText({
    df <- marked_text %>%
      filter(SpeciesID == gsub(" ","_",input$Species_Choice),
             Country == input$Country_Choice)
    
    if(is.na(df$red_list_notes[1])){
      return("No red-list notes available.")  
    }else{
      return(df$red_list_notes[1])
    } 
  })
  
  output$population_notes <- renderText({
    df <- marked_text %>%
      filter(SpeciesID == gsub(" ","_",input$Species_Choice),
             Country == input$Country_Choice)
    if(nrow(df) > 0){
      if(is.na(df$population_notes[1])){
        return("No population notes avalible")  
      }else{
        return(df$population_notes[1])
      } 
    } else {
      return("No population notes available.")  
    }
  })
  
  output$conservation_notes <- renderText({
    df <- marked_text %>%
      filter(SpeciesID == gsub(" ","_",input$Species_Choice),
             Country == input$Country_Choice)
    
    if(is.na(df$conservation_notes[1])){
      return("No conservation notes available.")  
    }else{
      return(df$conservation_notes[1])
    } 
  })
  
  output$population_trend <- renderText({
    df <- other_data %>%
      filter(Species == gsub(" ","_",input$Species_Choice),Database == "iucn") %>%
      select(population_trend.value)
    
    if(nrow(df) > 0){
      if(!is.na(df$population_trend.value)){
        return("No population trend notes available")  
      }else{
        return(df$population_trend.value)
      } 
    }else{
      return("No population trend notes available")  
    }
    
  })
  
  
  #Trade
  #plot trade
  output$Trade_Plot <- renderPlot({
    plot_trademap(input$Species_Choice,
                  countrycode(input$Country_Choice,"country.name","iso2c"),
                  input$year_slider_val)
  })
  
  output$Trade_timeseries <- renderPlot({
    plot_trademap_time(input$Species_Choice)
  })
  
  output$Trade_Network <- renderPlot({
    tradeflow(input$Species_Choice,input$year_slider_val)
  })
  
  output$year_slider <- renderUI({
    #get the year range to display
    year_range <- get_year_range(input$Species_Choice)
    
    if(all(!is.na(year_range))){
      #if year range is not null
      return(sliderInput("year_slider_val", "Year:",
                         year_range[1],year_range[2],year_range[1],
                         step = 1,sep = "",
                         animate = animationOptions(interval = 1000)))
    }
  })
  
  output$trade_notes <- renderText({
    df <- marked_text %>%
      filter(SpeciesID == gsub(" ","_",input$Species_Choice),
             Country == input$Country_Choice)
    
    if(is.na(df$use_trate_notes[1])){
      return("No trade notes available.")  
    }else{
      return(df$use_trate_notes[1])
    } 
  })
  
}

##UI
# Define UI for app that draws a histogram ----
ui <- fluidPage(
  titlePanel("ConMine"),
  sidebarLayout(sidebarPanel(selectInput(inputId = "Species_Choice",
                                         label = "Choose a species:",
                                         choices = names),
                             
                             selectInput(inputId = "Country_Choice",
                                         label = "Choose a country:",
                                         choices = countries)),
                
                mainPanel(tabsetPanel(type = "tabs",
                                      #welcome
                                      tabPanel("Welcome",
                                               h1("Welcome to ConMine!"),br(),
                                               p("ConMine is a dashboard created to assist in the reporting of Non-Detrimental Findings (NDFs). It uses data collected from IUCN, CITES, EOL, and ANAGE to help you plot and understand the trade of a specific species."),br(),
                                               p("To use the app please select a species and/or country from the drop down column on the left:"), br(),
                                               p("For help/support please email:")),
                                      
                                      #Species Tab  
                                      tabPanel("Species Information",
                                               fluidRow(column(6,
                                                               h1(textOutput("species_name")),
                                                               h4(textOutput("synonym")),br(),br(),
                                                               h3("Taxanomic Notes"), htmlOutput("taxa_notes"),br(),br(),
                                                               h3("Range Notes"), htmlOutput("range_notes"),br(),br(),
                                                               h3("Range Trend"), htmlOutput("range_trend"),br()),
                                                        column(4,htmlOutput("picture"),br(),
                                                               tableOutput("redlist")
                                                        )
                                               )
                                      ),
                                      
                                      #Trait Tab 
                                      tabPanel("Traits",
                                               tabsetPanel(type = "tabs",
                                                           tabPanel("Imputed Data",
                                                                    selectInput(inputId = "imputed_trait",
                                                                                label = "Choose a imputed trait:",
                                                                                choices = c("Life span","Body size")),
                                                                    plotOutput("Imputed_Plot")))),
                                      
                                      #Threats and Consservation
                                      tabPanel("Threats and Conservation",
                                               h3("Red List Notes"),   htmlOutput("redlist_notes"),br(),
                                               h3("Population Notes"), htmlOutput("population_notes"),br(),
                                               h3("Population Trend"), htmlOutput("population_trend"),br(),
                                               h3("Conservation Notes"), htmlOutput("conservation_notes") 
                                      ),
                                      
                                      #Trade
                                      tabPanel("Trade",
                                               h3("Trade Notes"), htmlOutput("trade_notes"),br(),br(),
                                               tabsetPanel(type = "tabs",
                                                           tabPanel("Worldwide Trade",plotOutput("Trade_Plot")),
                                                           tabPanel("Trade Timeseries",plotOutput("Trade_timeseries")),
                                                           tabPanel("Trade Networks",plotOutput("Trade_Network"))),
                                               uiOutput("year_slider")
                                      )
                )                                 
                )             
  )
)


shinyApp(ui = ui, server = server)

