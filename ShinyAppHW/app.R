rsconnect::deployApp(
  appDir = "~/Desktop/Repositories/Bosworth/ClassApp",
  appName = "bosworth",
  account = "kyle-bosworth",
  server = "shinyapps.io",
  appFiles = c("app.R", "bigfoot.csv"),
  appPrimaryDoc = "app.R"
)


library(shiny)
library(shinythemes)
library(leaflet)
library(readr)
library(here)

bigfootdf <- read.csv(here("ShinyAppHW", "data", "bigfoot.csv"))

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = shinytheme( "cerulean"), # line allows me to choose a theme for app
  titlePanel("Bigfoot Sightings by Moon Phase:"), # title
  sidebarLayout(
    sidebarPanel(
      selectInput("moon_phase", "select Moon Phase:", choices = unique(bigfootdf$moon_phase))
  ),
  mainPanel(
    plotOutput("sightings_plot"),
    leafletOutput("sightings_map")
        )
    ))
# Define server logic required to draw a histogram
server <- function(input, output) {

    output$sightings_plot <- renderPlot({
      filterdata <- bigfootdf[bigfootdf$moon_phase == input$moon_phase, ]
      
      #needed to add in more filters bc will not publish, possible that i may have missing values in the filtered data
      if(nrow(filterdata) > 0 && !all(is.na(filterdata$latitude)) && !all(is.na(filterdata$longitude))) {
      
      
      plot(filterdata$latitude, filterdata$longitude, main = "Bigfoot Sightings by Moon Phase",
           xlab = "Longitude", 
           ylab = "Latitude",
           pch = 19,
           col = "red")
           
           } else {
        plot(0,0, type = "n",
             main = "There is no data for selected moon phase",
             xlab = "longitude",
             ylab = "Latitude")
           }
             })
      
      #Map output
      output$sightings_map <- renderLeaflet({
        filterdata <- bigfootdf[bigfootdf$moon_phase == input$moon_phase, ]
        
        #removing NAs from coordiantes
        filterNAdata <- filterdata [!is.na(filterdata$latitude) &
                                      !is.na(filterdata$longitude) &
                                      filterdata$latitude >= -90 &
                                      filterdata$latitude <=90 &
                                      filterdata$longitude >= -180 &
                                      filterdata$longitude <= 180, ]
        
        leaflet() %>%
          addTiles() %>%
          addMarkers(lng = filterNAdata$longitude, 
                     lat = filterNAdata$latitude,
                     popup = filterNAdata$title)
      })
}
 
# Run the application 
shinyApp(ui = ui, server = server)
