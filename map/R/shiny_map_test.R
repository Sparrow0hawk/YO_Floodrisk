# tester for building responsive leaflet map

library(shiny)
library(here)
library(leaflet)
library(sp)
library(rgdal)


# import existing geojson
flood_risk <- readOGR(dsn="./data/manipulated_flood_risk.geojson",
                                  layer = "OGRGeoJSON")

# anything going into fluidPage goes into app
ui <- fluidPage(theme= './shiny/www/bootstrap.min.css',
                
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

  # add click_on map get popup feature here
  observe({
    leafletProxy("mymap") %>% clearPopups()
    event <- input$mymap_shape_click
    if (is.null(event))
      return()
    
    isolate({
      leafletProxy("map") %>% addPopups(event$lng, event$lat)
    })
  })
}

shinyApp(ui, server)