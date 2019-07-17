# tester for building responsive leaflet map

library(shiny)
library(here)
library(leaflet)
library(sp)
library(rgdal)

# import existing geojson
flood_risk <- readOGR(dsn="./data/G_locs_lite2.geojson")

# anything going into fluidPage goes into app
ui <- fluidPage(
  tags$head(includeCSS('./map/R/shiny/www/bootstrap.css')),
                
  h1("Mapping flood impacts", align='center'),
  h2('Taking open data from the Environment Agency and building a better reporting platform.', align='center'),
  fluidRow(
  column(2),
  column(8, align='center',
        leafletOutput("mymap", height= '80vh')
        ),
  column(2)
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
                 lng = flood_risk@coords[,1],
                 label = labels,
                 clusterOptions = markerClusterOptions())
  })

  # create labels for each ward based on 2016 results
  labels <- sprintf("
<table style='width:100%'>
  <tr>
    <th>Gauge Name</th>
    <td>%s</td>
    </tr>
    <tr>
    <th>Facebook</th>
    <td>%s</td>
    </tr>
    <tr>
    <th>Mailto</th>
    <td>%s</td>
    </tr>
    <tr>
    <th>Twitter</th>
    <td>%s</td>
    </tr>
    </table>",
                    
    as.character(flood_risk$Gauge),
    HTML(flood_risk$Facebook),
    HTML(flood_risk$Twitter)
  ) %>% lapply(htmltools::HTML)
  
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