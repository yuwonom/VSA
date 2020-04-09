'''
Developed for Vehicle Situational Awareness Project
Copyright © Queensland University of Technology 2020
Authored by @yuwonom (Michael Yuwono)
'''
import requests, time, json
import paho.mqtt.client as mqtt
import VSA, Broker

#properties
NAME = "Queensland Traffic Listener"
VERSION = "2.0.2"

#qldtraffic API
apiKey = "3e83add325cbb69ac4d8e5bf433d770b"
host = "api.qldtraffic.qld.gov.au"
path = "/v1/events"

URL = "https://" + host + path
PARAMS = {'apikey': apiKey}

# ------------------------------------------------------------------------ #

print("===== " + NAME + " v" + VERSION + " =====")

#new client
client = mqtt.Client()

#connecting to broker
print("Connecting to broker...")
client.username_pw_set(Broker.USERNAME, Broker.PASSWORD)
client.connect(Broker.ADDRESS, Broker.PORT)
print("Connected.")

request_interval_sec = 60

#request data
try:
	while True: 
		print("Sending request...")
		
		r = requests.get(url = URL, params = PARAMS)
		json_features = r.json()["features"]
		
		print(str(len(json_features)) + " features received.")
		
		message = json.dumps(json_features, default = VSA.serialize)
		client.publish(VSA.TOPIC_TRAFFIC, message)
		
		# interval
		counter = request_interval_sec
		while True:
			print("\rRefreshing in " + str(counter), end = "", flush = True)
			if counter == 0:
				print("\r", sep = "", end = "", flush = True)
				break
			counter = counter - 1
			time.sleep(1)
			
except KeyboardInterrupt:
    print("\n" + NAME + " stopped.")