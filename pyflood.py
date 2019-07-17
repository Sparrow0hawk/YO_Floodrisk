import csv, json
from geojson import Feature, FeatureCollection, Point

with open('data/Flood_impacts_updated.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    features = []
    for row in csv_reader:
        if line_count == 0:
            #label1, label2, label3 = row[1], row[2], row[5]
            #print(label1, label2, label3)
            pass
        elif len(row[5]) > 10:
            gauge_name, rloi_id, location = row[1], int(row[2]), row[5]
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
                        'gauge_name' : gauge_name,
                        'rloi_id' : rloi_id,
                        'mailto' : mailto,
                        'twitter' : twitter,
                        'facebook' : facebook,
                    }
                )
            )
            #print(locations[-1])
        line_count += 1

collection = FeatureCollection(features)
with open("data/pyfloodmap.geojson", "w") as f:
    f.write('%s' % collection)