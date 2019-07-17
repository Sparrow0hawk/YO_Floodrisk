import pandas as pd
import folium
import json

def main():
    """
    A script for loading the geojson data into folium and outputting it as a html file
    """

    with open('./data/manipulated_flood_risk.geojson') as f:
        data = json.load(f)

    m = folium.Map(location=[53.752288, -1.677899],
                   tiles='OpenStreetMap',
                   zoom_start=10)

    folium.GeoJson(
          data=data

    ).add_to(m)

    # adds a function to click brings popup with lnglat
    m.add_child(folium.LatLngPopup())

    m.save('./map/output_maps/folium_floodmap.html')

if __name__ == "__main__":
    main()
