import csv

with open('data/Flood impacts.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    locations = []
    for row in csv_reader:
        if line_count == 0:
            label1, label2, label3 = row[1], row[2], row[5]
            #print(label1, label2, label3)
        elif len(row[5]) > 10:
            gauge_name, rloi_id, location = row[1], row[2], row[5]
            longitude, latitude = location.split(',')[:2]
            locations.append((gauge_name, rloi_id, longitude, latitude))
            #print(locations[-1])
        line_count += 1
