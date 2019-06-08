'''
Developed for Vehicle Situational Awareness Project
Copyright © Queensland University of Technology 2019
Authored by @yuwonom (Michael Yuwono)
'''
import paho.mqtt.client as mqtt
import VSA, Broker

#properties
NAME = "VSA Request Simulator";
VERSION = "2.0.1";

# ------------------------------------------------------------------------ #

print("===== " + NAME + " v" + VERSION + " =====");

#new client
client = mqtt.Client();
client.username_pw_set(Broker.USERNAME, Broker.PASSWORD);
client.connect(Broker.ADDRESS, Broker.PORT);
print("Connected to broker.");

main_topic = VSA.TOPIC_TRAFFIC_NEARBY_REQ + "/1";

try:
	while True:
		print("publishing to topic ==> " + main_topic);
		message = input("Enter your message: ");
		client.publish(main_topic, message);
		print("message successfully published");
	
except KeyboardInterrupt:
	client.disconnect();