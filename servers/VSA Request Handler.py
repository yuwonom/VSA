'''
Developed for Vehicle Situational Awareness Project
Copyright © Queensland University of Technology 2020
Authored by @yuwonom (Michael Yuwono)
'''
from threading import Thread
import sys, time, math, json
import paho.mqtt.client as mqtt
import VSA, Broker

#properties
NAME = "VSA Request Handler"
VERSION = "2.1.0"

# ------------------------------------------------------------------------ #

def map_to_string(key, value):
	return "\"" + key + "\":\"" + str(value) + "\""

def on_connect(client, userdata, flags, rc):
	if rc == 0:
		client.connected_flag = True
		print("Connected.")
	else:
		print("Connection failed.")

def on_disconnect(client, userdata, rc=0):
	client.loop_stop()
	client.connected_flag = False
	print(NAME + " stopped.")
	print("Disconnected result code: " + str(rc))
	
def on_message(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"))
	print("Message published to topic: " + msg.topic)
	print("- with payload: " + payload)

def topic_level_a_vehsim_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"))
	items = payload.split(',')
	uid = items[0]
	latitude = float(items[1])
	longitude = float(items[2])
	velocity = float(items[3])
	accuracy = float(items[4])
	direction = float(items[5])
	intersection_id = msg.topic.split('/')[-1]

	global vehicles

	if uid not in vehicles:
		pass

	vehicles[uid].update_status(latitude, longitude, velocity, accuracy, direction, intersection_id)
	intersections.add(intersection_id)
	
def topic_level_a_vehprop_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"))
	items = payload.split(',')
	uid = items[0]
	name = items[1]
	type = items[2]
	left = float(items[3])
	top = float(items[4])
	right = float(items[5])
	bottom = float(items[6])
	dimensions = (left, top, right, bottom)

	global vehicles

	if uid in vehicles:
		del vehicles[uid]

	vehicle = VSA.Vehicle(uid, name, type, dimensions)
	vehicles[uid] = vehicle

def topic_level_a_req_callback():
	def publish_messages():
		global intersections, vehicles

		for intersection in intersections:
			vehsim_list = []

			detected_vehicles = [veh for veh in list(vehicles.values()) if veh.intersection_id == intersection]
			for vehicle in detected_vehicles:
				data_id = map_to_string("id", vehicle.uid)
				data_lng = map_to_string("lng", vehicle.coordinate.longitude)
				data_lat = map_to_string("lat", vehicle.coordinate.latitude)
				data_vel = map_to_string("vel", vehicle.velocity)
				data_ang = map_to_string("ang", vehicle.rotation_angle)
				data_acc = map_to_string("acc", vehicle.position_error)
				data_type = map_to_string("type", vehicle.type.value)
				combined = ",".join([data_id, data_lng, data_lat, data_vel, data_ang, data_acc, data_type])
				vehsim_list.append("{" + combined + "}")

			vehsim_json = "[" + ",".join(vehsim_list) + "]"
			client.publish(VSA.TOPIC_LEVEL_A_REQ + "/" + intersection, vehsim_json)

	while client.connected_flag:
		publish_messages()
		time.sleep(0.1)
	
def topic_traffic_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"))
	json_features = json.loads(payload)

	global features
	features = []
	
	for data in json_features:
		feature = VSA.Feature(data)
		features.append(feature)
	
	print("Features updated.")
	
def topic_traffic_nearby_req_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"))
	items = payload.split(',')
	veh_id = items[0]
	latitude = float(items[1])
	longitude = float(items[2])
	radius = float(items[3])
	
	global features
	
	user_geolocation = VSA.Geolocation(latitude, longitude)
	features_res = []
	features_tmp = features

	for feature in features_tmp:
		include = False
		for geometry in feature.geometries:
			for coordinate in geometry.coordinates:
				if (VSA.distance(user_geolocation, coordinate) <= radius):
					include = True
					break
			if (include):
				break
		if (include):
			features_res.append(feature)
	
	print(str(len(features_res)) + " events found.")
	client.publish(VSA.TOPIC_TRAFFIC_NEARBY_RETURN + "/" + veh_id, json.dumps(features_res, default = VSA.serialize))
	
def topic_vehsim_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"))
	items = payload.split(',')
	uid = items[0]
	latitude = float(items[1])
	longitude = float(items[2])
	velocity = float(items[3])
	accuracy = float(items[4])
	direction = float(items[5])

	global vehicles

	if uid not in vehicles:
		pass

	vehicles[uid].update_status(latitude, longitude, velocity, accuracy, direction)
	
def topic_vehprop_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"))
	items = payload.split(',')
	uid = items[0]
	name = items[1]
	type = items[2]
	left = float(items[3])
	top = float(items[4])
	right = float(items[5])
	bottom = float(items[6])
	dimensions = (left, top, right, bottom)

	global vehicles

	if uid in vehicles:
		del vehicles[uid]

	vehicle = VSA.Vehicle(uid, name, type, dimensions)
	vehicles[uid] = vehicle

def topic_vehsim_req_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"))
	items = payload.split(',')
	veh_id = items[0]
	radius = float(items[1])

	global vehicles

	data = vehicles.copy()
	if veh_id in data:
		del data[veh_id]

	vehsim_list = []
	for id in data:
		data_id = map_to_string("id", id)
		data_lng = map_to_string("lng", data[id].coordinate.longitude)
		data_lat = map_to_string("lat", data[id].coordinate.latitude)
		data_vel = map_to_string("vel", data[id].velocity)
		data_ang = map_to_string("ang", data[id].rotation_angle)
		data_acc = map_to_string("acc", data[id].position_error)
		combined = ",".join([data_id, data_lng, data_lat, data_vel, data_ang, data_acc])
		vehsim_list.append("{" + combined + "}")

	vehsim_json = "[" + ",".join(vehsim_list) + "]"
	client.publish(VSA.TOPIC_VEHSIM_RETURN + "/" + veh_id, vehsim_json)
	
def topic_vehprop_req_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"))
	items = payload.split(',')
	veh_id = msg.topic.split('/')[-1]

	global vehicles

	data = {}
	for nearby_id in items:
		if (nearby_id in vehicles):
			data[nearby_id] = vehicles[nearby_id]

	vehprop_list = []
	for id in data:
		dims = data[id].dimensions
		data_id = map_to_string("id", id)
		data_name = map_to_string("name", data[id].name)
		data_type = map_to_string("type", data[id].type.value)
		data_dim = map_to_string("dimensions", ",".join([str(dims[0]), str(dims[1]), str(dims[2]), str(dims[3])]))
		combined = ",".join([data_id, data_name, data_type, data_dim])
		vehprop_list.append("{" + combined + "}")

	vehprop_json = "[" + ",".join(vehprop_list) + "]"
	client.publish(VSA.TOPIC_VEHPROP_RETURN + "/" + veh_id, vehprop_json)

# ------------------------------------------------------------------------ #	
	
print("===== " + NAME + " v" + VERSION + " =====")

#global variables
vehicles = {}
intersections = set()
features = []

#new client
client = mqtt.Client()
client.connected_flag = False
client.on_connect = on_connect
client.on_disconnect = on_disconnect
#client.on_message = on_message
client.message_callback_add(VSA.TOPIC_LEVEL_A_VEHSIM + "/#", topic_level_a_vehsim_callback)
client.message_callback_add(VSA.TOPIC_LEVEL_A_VEHPROP + "/#", topic_level_a_vehprop_callback)
client.message_callback_add(VSA.TOPIC_TRAFFIC + "/#", topic_traffic_callback)
client.message_callback_add(VSA.TOPIC_TRAFFIC_NEARBY_REQ + "/#", topic_traffic_nearby_req_callback)
client.message_callback_add(VSA.TOPIC_VEHSIM + "/#", topic_vehsim_callback)
client.message_callback_add(VSA.TOPIC_VEHPROP + "/#", topic_vehprop_callback)
client.message_callback_add(VSA.TOPIC_VEHSIM_REQ + "/#", topic_vehsim_req_callback)
client.message_callback_add(VSA.TOPIC_VEHPROP_REQ + "/#", topic_vehprop_req_callback)

#connecting to broker
print("Connecting to broker...")
client.username_pw_set(Broker.USERNAME, Broker.PASSWORD)
client.connect(Broker.ADDRESS, Broker.PORT)
client.loop_start()
while not client.connected_flag:
	time.sleep(1)

#subscribing VSA/#
client.subscribe("VSA/#")
print("Subscribing to every topic under " + "VSA/#")

#register threads
level_a_req_thread = Thread(target=topic_level_a_req_callback)
level_a_req_thread.start()

try:
	while client.connected_flag:
		time.sleep(1)
	client.disconnect()
	
except KeyboardInterrupt:
	client.disconnect()