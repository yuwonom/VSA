'''
Developed for Vehicle Situational Awareness Project
Copyright Queensland University of Technology 2020
Authored by @yuwonom (Michael Yuwono)
'''
import paho.mqtt.client as mqtt
import vsa, broker

#properties
NAME = "VSA Request Simulator"
VERSION = vsa.VERSION

# ------------------------------------------------------------------------ #

def main():
	print("===== " + NAME + " v" + VERSION + " =====")

	#new client
	client = mqtt.Client()
	client.username_pw_set(broker.USERNAME, broker.PASSWORD)
	client.connect(broker.ADDRESS, broker.PORT)
	print("Connected to broker.")

	main_topic = vsa.TOPIC_LEVEL_A_REQ + "/1"

	try:
		while True:
			print("publishing to topic ==> " + main_topic)
			message = input("Enter your message: ")
			client.publish(main_topic, message)
			print("message successfully published")
		
	except KeyboardInterrupt:
		client.disconnect()

if __name__ == '__main__':
    main()