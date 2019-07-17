import csv, json
from geojson import Feature, FeatureCollection, Point

def collate_features_from_csvfile(csv_reader, loc):
    #loc is the column number of the location field chosen
    
    features = []
    line_count = 0

    for row in csv_reader:
        if line_count == 0:
            #label1, label2, label3 = row[1], row[2], row[5]
            #print(label1, label2, label3)
            pass
        elif len(row[loc]) > 10: #check location field is not empty of latitude. longitude
            gauge_name, rloi_id, value, units = row[1], int(row[2]), row[3], row[4]
            location, comment, impact, year, month = row[loc], row[7], row[10], row[11], row[12]
            co_ords = location.split(',')
            co_ords = [value for value in co_ords if value !=""]
            long_string, lat_string = tuple(co_ords)
            #print(location, long_string, lat_string)
            longitude, latitude = float(long_string), float(lat_string)
            mailto = (f'<a href="'
                    f'mailto:reports@environmentagency.gov.uk'
                    f'?subject=Flood report at {long_string},{lat_string}'
                    f'">email us</a>')
            twitter = (f'<a href="'
                        f'https://twitter.com/intent/tweet?text='
                        f'Flood report at {long_string},{lat_string}'
                        f'&url=https%3A%2F%2Fwww.guardian.com'
                        f'">Tweet</a>')
            facebook = (f'<a href="'
                        f'https://www.facebook.com/dialog/share?app_id=180444840287'
                        f'&href=https%3A%2F%2Fflood-warning-information.service.gov.uk%2Fwarnings'
                        f'">Facebook</a>')
            features.append(
                Feature(
                    geometry = Point((longitude, latitude)),
                    properties = {
                        'Gauge_name' : gauge_name,
                        #'rloi_id' : rloi_id,
                        'Value' : value,
                        'Units' : units,
                        'Comment' : comment,
                        'Impact' : impact,
                        'Year' : year,
                        'Month' : month,
                        'Email' : mailto,
                        'Twitter' : twitter,
                        'Facebook' : facebook,
                    }
                )
            )
            #print(locations[-1])
        line_count += 1

        return features

with open('data/Flood_impacts_updated.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')

    features = collate_features_from_csvfile(csv_reader, 5) #events at gauge locations
    collection = FeatureCollection(features)
    with open("data/floodgaugemap.geojson", "w") as f:
        f.write('%s' % collection)
    
    features = collate_features_from_csvfile(csv_reader, 6) #events at impact locations
    collection = FeatureCollection(features)
    with open("data/floodimpactmap.geojson", "w") as f:
        f.write('%s' % collection)
