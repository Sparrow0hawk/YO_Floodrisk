# tester for building responsive leaflet map

library(shiny)
library(leaflet)
library(sp)
library(rgdal)

# import existing geojson
flood_risk <- readOGR(dsn="/Users/alexcoleman/PhD_OneDrive/Code/Python/YO_Floodrisk/data/manipulated_flood_risk.geojson",
                                  layer = "OGRGeoJSON")

# anything going into fluidPage goes into app
ui <- fluidPage(
  titlePanel("Mapping flood impacts"),
    mainPanel(
      leafletOutput("mymap")
    )
)

server <- function(input, output, session) {
  
# function to generate map

  output$mymap <- renderLeaflet({
    leafletOptions(maxZoom = 10)  
    leaflet() %>%
      # set map to centre on west yorkshire TODO change
      setView(lat=53.752288, lng = -1.677899, zoom=8) %>%
      addTiles() %>%
      # select out lon and lat from coords in spatialpointsdataframe
      addMarkers(lat = flood_risk@coords[,2], 
                 lng = flood_risk@coords[,1])
  })

}

shinyApp(ui, server)