server <- function(input, output) {
  
  #Species Name
  output$species_name <- renderText({input$Species_Choice})

  #species Notes
  output$taxa_notes <- renderText({
    df <- marked_text %>%
      filter(SpeciesID == gsub(" ","_",input$Species_Choice),Country == input$Country_Choice)
    
    if(is.na(df$taxonomic_notes[1])){
      return("No taxanomic notes avalible")  
    }else{
      return(df$taxonomic_notes[1])
    } 
  })
  output$range_notes <- renderText({
    df <- marked_text %>%
      filter(SpeciesID == gsub(" ","_",input$Species_Choice),Country == input$Country_Choice)
    
    if(is.na(df$range_notes[1])){
      return("No range notes avalible")  
    }else{
      return(df$range_notes[1])
    } 
  })
  
  #picture
  output$picture<-renderText({
    pic <- getwikipic(input$Species_Choice)
    if(!is.na(pic)){
      return(c('<img src="',pic,'">'))
    }else{
      return("No picture avalible :(")
    }
    })
  
  
  
  ##LIFE HISTORY TRAITS
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
      return("No red-list notes avalible")  
    }else{
      return(df$red_list_notes[1])
    } 
  })
  
  output$population_notes <- renderText({
    df <- marked_text %>%
      filter(SpeciesID == gsub(" ","_",input$Species_Choice),
             Country == input$Country_Choice)
    
    if(is.na(df$population_notes[1])){
      return("No population notes avalible")  
    }else{
      return(df$population_notes[1])
    } 
  })
  
  output$conservation_notes <- renderText({
    df <- marked_text %>%
      filter(SpeciesID == gsub(" ","_",input$Species_Choice),
             Country == input$Country_Choice)
    
    if(is.na(df$conservation_notes[1])){
      return("No conservation notes avalible")  
    }else{
      return(df$conservation_notes[1])
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
      return("No trade notes avalible")  
    }else{
      return(df$use_trate_notes[1])
    } 
  })
  
  
  }