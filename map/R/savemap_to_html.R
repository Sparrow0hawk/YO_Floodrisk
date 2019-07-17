# saving the map file to html

library(htmlwidgets)
library(shiny)
library(leaflet)
library(sp)
library(rgdal)

# import existing geojson
flood_risk <- readOGR(dsn="./data/pyfloodmap.geojson")


map <- leaflet() %>%
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

# due to a bug in saveWidget we have to save the file in the top project dir
# more info https://stackoverflow.com/questions/41399795/savewidget-from-htmlwidget-in-r-cannot-save-html-file-in-another-folder
saveWidget(map, 'yofloodmap.html')
