'''
Developed for Vehicle Situational Awareness Project
Copyright Queensland University of Technology 2020
Authored by @yuwonom (Michael Yuwono)
'''
import paho.mqtt.client as mqtt
import random, time
import vsa, broker

#properties
NAME = "VSA Scalability Tester"
VERSION = "2.1.1"

# ------------------------------------------------------------------------ #

print("===== " + NAME + " v" + VERSION + " =====")

#constants
NODES_LENGTH = 100
STARTING_LAT = -27.477716
STARTING_LON = 153.005583
COORD_VARIATION = 0.0001

#global variables
vehicles = []

#new client
client = mqtt.Client()
client.username_pw_set(broker.USERNAME, broker.PASSWORD)
client.connect(broker.ADDRESS, broker.PORT)
print("Connected to broker.")

#initialise vehicles
for index in range(0, NODES_LENGTH):
    uid = str(index + 1)
    name = "vehicle-" + str(index)
    type = "cycle"
    dimensions = (1,1,1,1)
    latitude = STARTING_LAT + (index * COORD_VARIATION)
    longitude = STARTING_LON + (random.random() * COORD_VARIATION)
    velocity = 0
    position_error = random.random() * 100
    rotation_angle = random.random() * 100

    vehicle = vsa.Vehicle(uid, name, type, dimensions)
    vehicle.update_status(latitude, longitude, velocity, position_error, rotation_angle)
    vehicles.append(vehicle)

    topic = vsa.TOPIC_LEVEL_A_VEHPROP
    message = ','.join([uid, name, type, ','.join(list(map(str, list(dimensions))))])
    client.publish(topic, message)

#update status
try:
    while True:
        for index in range(0, NODES_LENGTH):
            vehicle = vehicles[index]
            latitude = vehicle.coordinate.latitude - COORD_VARIATION
            longitude = vehicle.coordinate.longitude + (random.random() * COORD_VARIATION * 2) - COORD_VARIATION
            vehicle.update_status(latitude, longitude, vehicle.velocity, vehicle.position_error, vehicle.rotation_angle)

            topic = vsa.TOPIC_LEVEL_A_VEHSIM + "/3"
            message = ','.join([
                str(vehicle.uid),
                str(vehicle.coordinate.latitude),
                str(vehicle.coordinate.longitude),
                str(vehicle.velocity),
                str(vehicle.position_error),
                str(vehicle.rotation_angle)])
            client.publish(topic, message)

        time.sleep(0.1)
	
except KeyboardInterrupt:
    client.disconnect()