import csv, json
from geojson import Feature, FeatureCollection, Point

with open('data/Flood impacts.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    features = []
    for row in csv_reader:
        if line_count == 0:
            #label1, label2, label3 = row[1], row[2], row[5]
            #print(label1, label2, label3)
            pass
        elif len(row[5]) > 10:
            gauge_name, rloi_id, location = row[1], row[2], row[5]
            longitude, latitude = location.split(',')[:2]
            features.append(
                Feature(
                    geometry = Point((longitude, latitude))
                    properties = {
                        'gauge_name' = gauge_name
                        'rloi_id' = rloi_id
                    }
                )
            )
            #print(locations[-1])
        line_count += 1

collection = FeatureCollection(features)
#with open("GeoObs.json", "w") as f:
    #f.write('%s' % collection)