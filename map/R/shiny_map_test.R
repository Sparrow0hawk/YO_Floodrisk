# tester for building responsive leaflet map

library(shiny)
library(leaflet)
library(sp)
library(rgdal)

# import existing geojson
flood_risk <- readOGR(dsn="/Users/alexcoleman/PhD_OneDrive/Code/Python/YO_Floodrisk/data/manipulated_flood_risk.geojson",
                                  layer = "OGRGeoJSON")

flood_risk <- spTransform(flood_risk, CRS("+proj=longlat +ellps=GRS80"))

# anything going into fluidPage goes into app
ui <- fluidPage(
  titlePanel("Test"),
    mainPanel(
      leafletOutput("mymap")
    )
)

server <- function(input, output, session) {
  

  output$mymap <- renderLeaflet({
    leafletOptions(maxZoom = 10)  
    leaflet() %>%
      setView(lng=53.752288, lat = -1.677899, zoom=4) %>%
      addTiles() %>%
      addMarkers(lng = as.numeric(flood_risk@data$Longitude), 
                 lat = as.numeric(flood_risk@data$Latitude))
  })

}

shinyApp(ui, server)