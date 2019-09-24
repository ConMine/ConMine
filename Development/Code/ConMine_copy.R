# See above for the definitions of ui and server
source("./ShinyApp/InstallPackages.R")
source("./ShinyApp/helpers.R")
source("./ShinyApp/ImputationPlots.R")
source("./ShinyApp/MapTrade.R")
source("./ShinyApp/MapTrade_network.R")
source("./ShinyApp/DownloadImage.R")


rsconnect::deployApp("~/Documents/UniversityWork/PhD/TigerTeams/ConMine/Code/ShinyApp")
