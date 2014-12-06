#cleanCSV.py
"""

How to run:
    python cleanCSV.py sourcefile

"""

import re
import sys
import csv
import stateAbbrev
import unicodedata
import time
from googlegeocoder import GoogleGeocoder

#argv1 is the .csv of provider information
sourcefile=sys.argv[1]

rows = []

#parses csv and decodes utf-8
fp = open(sourcefile, 'rb')
reader = csv.reader(fp)
for utf8_row in reader:
    unicode_row = [x.decode('utf8') for x in utf8_row]
    rows.append(utf8_row)


#Provider object with necessary fields 
class Provider(object):
	idNum = ""
	name = ""
	name_2 = ""
	address_1 = ""
	address_2 = ""
	city = ""
	state = ""
	zipcode = ""
	phone_number = ""
	web_site = ""
	latitude = ""
	longitude = ""	

	#Provider constructor
	def __init__(self, idNum, name, name_2, address_1, address_2, city, state, zipcode, phone_number, web_site, latitude, longitude):
		self.idNum = idNum
		self.name = name
		self.name_2 = name_2
		self.address_1 = address_1
		self.address_2 = address_2
		self.city = city
		self.state = state
		self.zipcode = zipcode
		self.phone_number = phone_number
		self.web_site = web_site
		self.latitude = latitude
		self.longitude = longitude

#creates new provider through constructor
def make_provider(idNum, name, name_2, address_1, address_2, city, state, zipcode, phone_number, web_site, latitude, longitude):
	provider = Provider(idNum, name, name_2, address_1, address_2, city, state, zipcode, phone_number, web_site, latitude, longitude)
	return provider

def print_provider(provider):
	return provider.idNum + "," + provider.name + "," + provider.name_2 + "," + provider.address_1 + "," + provider.address_2 + "," + provider.city + "," + provider.state+ "," + provider.zipcode + "," + provider.phone_number + "," + provider.web_site+ "," + provider.latitude + "," +  provider.longitude + "\n"




# list of all providers
allProviders = []	

#iterates through rows
#creates new Provider objects and appends to list 
for line in rows:
	allProviders.append(make_provider(line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9], "NULL", "NULL"))

#removes first header Provider
allProviders.pop(0)

#iterates through states
#uses dictionary to convert to Abbrev
for provider in allProviders:
	for x in stateAbbrev.states:
		if provider.state in stateAbbrev.states[x]:
			provider.state = x


#Google Geocoder finds lat & long
geocoder = GoogleGeocoder()
geospacial = ""
for provider in allProviders:
	address = provider.address_1 + " "+ provider.city + " " +  provider.state 
	#print address
	time.sleep(2)
	search = geocoder.get(address)
	geospacial = (search[0].geometry.location.lat, search[0].geometry.location.lng)
	geospacial = str(geospacial)
	geospacial = re.sub(r'[()]+', '', geospacial)
	geospacial = geospacial.split(',')
	provider.latitude = geospacial[0].strip()
	provider.longitude = geospacial[1].strip()
	#print provider.latitude
	#print provider.longitude


takeIn = ""

#replaces null values with string for sql
for x in allProviders:
	if (len(x.address_2) == 0):
		x.address_2 = "NULL"
	if (len(x.web_site) == 0):
		x.web_site = "NULL"
	if (len(x.name_2) == 0):
		x.name_2 = "NULL"
	#also adds final Provider object to string
	takeIn += print_provider(x)

#print takeIn


saveFile = open('providers.csv','w')
saveFile.write(takeIn)
saveFile.close()
fp.close()      



    



