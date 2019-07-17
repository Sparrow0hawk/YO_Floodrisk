# tester for building responsive leaflet map
library(htmlwidgets)
library(shiny)
library(here)
library(leaflet)
library(sp)
library(rgdal)

# import existing geojson
flood_risk <- readOGR(dsn="./data/pyfloodmap.geojson")

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
    leaflet(elementId = 'mymap') %>%
      # set map to centre on west yorkshire TODO change
      setView(lat=53.752288, lng = -1.677899, zoom=8) %>%
      addTiles() %>%
      # select out lon and lat from coords in spatialpointsdataframe
      addMarkers(lat = flood_risk@coords[,2], 
                 lng = flood_risk@coords[,1],
                 popup = mapply(function(gauge,
                                         comment,
                                         impact,
                                         month,
                                         year,
                                         value,
                                         unit,
                                         facebook, 
                                         twitter, 
                                         email) {
                   HTML(sprintf("<strong>Gauge Name:</strong> %s<br> <strong>Comment</strong>: %s <br><strong>Impact</strong>: %s <br><strong>Timeframe</strong>: %s %s <br><strong>Measurement value</strong>: %s %s <br>Share to %s <br> Share to %s <br> Or %s", htmltools::htmlEscape(gauge), htmltools::htmlEscape(comment), htmltools::htmlEscape(impact), htmltools::htmlEscape(month), htmltools::htmlEscape(year), htmltools::htmlEscape(value), htmltools::htmlEscape(unit), facebook, twitter, email))},
                   flood_risk$Gauge_name, 
                   flood_risk$Comment, 
                   flood_risk$Impact, 
                   flood_risk$Month,
                   flood_risk$Year,
                   flood_risk$Value, 
                   flood_risk$Units, 
                   flood_risk$Facebook, 
                   flood_risk$Twitter, 
                   flood_risk$Email, SIMPLIFY = F),
                 clusterOptions = markerClusterOptions())
  })

  
  # add click_on map get popup feature here
  observeEvent(input$mymap_click,{
    click_event <- data.frame(input$mymap_click)
    
    print(click_event$lat)
    print(typeof(as.integer(click_event$lat)))
    
    leafletProxy('mymap') %>%
      addPopups(data = click_event, 
              popup = HTML('Report a flood here <br>',click_event$lat,' ',click_event$lng, '<br> Insert links here.')
      )
    })
}



shinyApp(ui, server)