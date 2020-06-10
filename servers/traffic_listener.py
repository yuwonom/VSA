'''
Developed for Vehicle Situational Awareness Project
Copyright Queensland University of Technology 2020
Authored by @yuwonom (Michael Yuwono)
'''
import requests, time, json
import paho.mqtt.client as mqtt
import broker, vsa

#properties
NAME = "Queensland Traffic Listener"
VERSION = vsa.VERSION

# ------------------------------------------------------------------------ #

class TrafficListener(object):
	@staticmethod
	def request_events():
		#qldtraffic API
		apiKey = "3e83add325cbb69ac4d8e5bf433d770b"
		host = "api.qldtraffic.qld.gov.au"
		path = "/v1/events"

		URL = "https://" + host + path
		PARAMS = {'apikey': apiKey}

		response = requests.get(url = URL, params = PARAMS)
		return response.json()["features"]

# ------------------------------------------------------------------------ #

def main():
	print("===== " + NAME + " v" + VERSION + " =====")

	#new client
	client = mqtt.Client()

	#connecting to broker
	print("Connecting to broker...")
	client.username_pw_set(broker.USERNAME, broker.PASSWORD)
	client.connect(broker.ADDRESS, broker.PORT)
	print("Connected.")

	request_interval_sec = 60

	#request data
	try:
		while True: 
			print("Sending request...")
			
			json_features = TrafficListener.request_events()
			
			print(str(len(json_features)) + " features received.")
			
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

if __name__ == '__main__':
    main()