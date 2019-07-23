# Yorkshire Floodrisk Project: Hack for Impact Yorkshire

***Example final prototype -->*** https://upstream.shinyapps.io/upsteam_prototype/

Repository for all work from Hack for Impact : Yorkshire July 2019.

Working with the environment agency on flood risk/ flooding impact.

Links to data:

https://datamillnorth.org/dataset/flood-impacts

Gauge API call
https://environment.data.gov.uk/flood-monitoring/id/stations

## Environment Agency Impact Data
The Environment Agency provided a sample dataset of compiled flood impacts. These impacts have been compiled from several sources such as historic events and modelled/simulated flooding. 

All records were tied to a specific fluvial gauge. Some of these have an additional spatial component at the site of the impact. E.G. flooded carpark.

This dataset is still in an alpha development phase within the EA and is moving towards a private Beta, with public testing via invites. Please get in touch with @alecjtaylor to request access to the Beta. 

Upon release the dataset will be avliable via data.gov.uk site : https://environment.data.gov.uk/flood-monitoring/doc/reference

It will also be displayed via the River Levels on the Internet service : https://flood-warning-information.service.gov.uk/river-and-sea-levels

## Final work write up

After an excellent two days we managed to produce a mapped output based on the csv data provided by the Environment agency, with proof of concept for how the users of the mapping could share information from the map using social media or directly contribute new information back to the Environment Agency.

There were several streams within the team working in parallel on spreadsheet data, python scripting, and R work.
This repo holds all work done during the project.

## Data manipulation
Work converting the csv into a geojson format with suitable html sections for links to facebook, twitter, email. This work can be found in the csv_to_geojson folder with credit to @Salam697.

## Notes on Data folder

The initial data provided was the "Flood impacts.csv" file. This csv was adapted a number of times (TODO @alecjtaylor if you could briefly summarise?).
The "manipulated_flood_risk.csv" is formed from the "Flood risk.csv" using jupyter notebook lon_lat_handling.ipynb to extract longditude and latitude from the combined column in the source csv.
The G_locs_lite2.geojson was produced using the https://odileeds.github.io/CSV2GeoJSON/ .
The pyfloodmap/floodgaugemap/floodimpactmap.geojson files are all outputs from the csv_to_geojson work:
 - pyfloodmap was produced from the initial "Flood impacts.csv" file using the pyflood.py script
 - floodgaugemap.geojson and floodimpactmap.geojson represent different partitions of the data within "Flood_impacts_updated.csv", as requested by the data owners, using the floodgauge.py and floodimpact.py scripts respectively.

## Map production

Initial work began in python using the folium library to plot the data onto an interactive leaflet map. The outcome of this work is summarised in the "clickable_map1.py" with its output "folium_floodmap.html" in /map/output_maps.

We migrated into using R to build a shiny application due to greater experience and customisability in the Shiny:Leaflet package.

All R work is found in /map/R folder. A preliminary shiny testing R code is found here (coded in a combined UI/server form). Along with an example R script that outputs a leaflet map as a pure html document (saved into top project directory) this includes clickable markers but lacks additional functionality built into Shiny application.

A more mature version of the Shiny app is found in the shiny directory within /map/R/. With map_points.R performing most of the heavy lifting (recommended you initialise the YO_Floodrisk.Rproj before running that file). This includes markers with clickable functionality along with an example of clicking anywhere on the map to generate a popup that offers forms of instant reporting (via twitter, mailto or facebook).

## Final

Big thank you to the group who worked on this at Hack for Impact: Yorkshire July 2019! Some are contributors to this repo others are not but still certainly did contribute!

Any questions or further follow up can be directed on here as a pull request or catch me at a.coleman1@leeds.ac.uk
