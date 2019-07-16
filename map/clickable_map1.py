import pandas as pd
import folium
import json
import glob

def main():
    with open('/Users/alexcoleman/PhD_OneDrive/Code/Python/YO_Floodrisk/data/manipulated_flood_risk.geojson') as f:
        data = json.load(f)

    m = folium.Map(location=[53.752288, -1.677899],
                   tiles='OpenStreetMap',
                   zoom_start=10)

    folium.GeoJson(
          data=data

    ).add_to(m)

    m.add_child(folium.LatLngPopup())

if __name__ == "__main__":
    main()
