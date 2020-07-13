'''
Developed for Vehicle Situational Awareness Project
Copyright Queensland University of Technology 2020
Authored by @yuwonom (Michael Yuwono)
'''
from threading import Thread
import sys, time, math, json
import paho.mqtt.client as mqtt
import vsa, broker, traffic_listener

#properties
NAME = "VSA Request Handler"
VERSION = vsa.VERSION

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

	vehicle = vsa.Vehicle(uid, name, type, dimensions)
	vehicles[uid] = vehicle

def topic_level_a_req_callback():
	def publish_messages():
		global intersections, vehicles

		for intersection in intersections:
			vehsim_list = []

			detected_vehicles = [veh for veh in list(vehicles.values()) if veh.intersection_id == intersection.id]
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
			client.publish(vsa.TOPIC_LEVEL_A_REQ + "/" + intersection.id, vehsim_json)

	while client.connected_flag:
		publish_messages()
		time.sleep(0.1)
	
def topic_events_callback():
	def update_events():
		json_events = traffic_listener.TrafficListener.request_events()

		global events
		events = []

		for data in json_events:
			event = vsa.Event(data)
			events.append(event)
		
		print("Features updated.")

	while client.connected_flag:
		update_events()
		time.sleep(60)
	
def topic_events_nearby_req_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"))
	items = payload.split(',')
	veh_id = items[0]
	latitude = float(items[1])
	longitude = float(items[2])
	radius = float(items[3])
	
	global events
	
	user_geolocation = vsa.Geolocation(latitude, longitude)
	events_res = []
	events_tmp = events

	for event in events_tmp:
		include = False
		for geometry in event.geometries:
			for coordinate in geometry.coordinates:
				if (vsa.distance(user_geolocation, coordinate) <= radius):
					include = True
					break
			if (include):
				break
		if (include):
			events_res.append(event)
	
	print(str(len(events_res)) + " events found.")
	client.publish(vsa.TOPIC_LEVEL_B_EVENTS_RETURN + "/" + veh_id, json.dumps(events_res, default = vsa.serialize))
	
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

	vehicle = vsa.Vehicle(uid, name, type, dimensions)
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
	client.publish(vsa.TOPIC_VEHSIM_RETURN + "/" + veh_id, vehsim_json)
	
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
	client.publish(vsa.TOPIC_VEHPROP_RETURN + "/" + veh_id, vehprop_json)

def topic_intersections_req_callback(mqttc, obj, msg):
	veh_id = msg.topic.split('/')[-1]
	client.publish(vsa.TOPIC_INTERSECTIONS_RETURN + "/" + veh_id, json.dumps(intersections, default = vsa.serialize))

def topic_disconnect_callback(mqttc, obj, msg):
	veh_id = str(msg.payload.decode("utf-8"))
	
	global vehicles

	if veh_id in vehicles:
		del vehicles[veh_id]

# ------------------------------------------------------------------------ #

#global variables
vehicles = {}
events = []
intersections = [
	vsa.Intersection("1",-27.471962,153.027476,15),
	vsa.Intersection("2",-27.473975,153.026548,50),
	vsa.Intersection("3",-27.479467,153.006698,100)
]
client = mqtt.Client()

# ------------------------------------------------------------------------ #

def main():
	print("===== " + NAME + " v" + VERSION + " =====")

	#setup mqtt client
	client.connected_flag = False
	client.on_connect = on_connect
	client.on_disconnect = on_disconnect
	# client.on_message = on_message
	client.message_callback_add(vsa.TOPIC_LEVEL_A_VEHSIM + "/#", topic_level_a_vehsim_callback)
	client.message_callback_add(vsa.TOPIC_LEVEL_A_VEHPROP + "/#", topic_level_a_vehprop_callback)
	client.message_callback_add(vsa.TOPIC_EVENTS_NEARBY_REQ + "/#", topic_events_nearby_req_callback)
	client.message_callback_add(vsa.TOPIC_VEHSIM + "/#", topic_vehsim_callback)
	client.message_callback_add(vsa.TOPIC_VEHPROP + "/#", topic_vehprop_callback)
	client.message_callback_add(vsa.TOPIC_VEHSIM_REQ + "/#", topic_vehsim_req_callback)
	client.message_callback_add(vsa.TOPIC_VEHPROP_REQ + "/#", topic_vehprop_req_callback)
	client.message_callback_add(vsa.TOPIC_INTERSECTIONS_REQ + "/#", topic_intersections_req_callback)
	client.message_callback_add(vsa.TOPIC_DISCONNECT + "/#", topic_disconnect_callback)

	#connecting to broker
	print("Connecting to broker...")
	client.username_pw_set(broker.USERNAME, broker.PASSWORD)
	client.connect(broker.ADDRESS, broker.PORT)
	client.loop_start()
	while not client.connected_flag:
		time.sleep(1)

	#subscribing VSA/#
	client.subscribe("VSA/#")
	print("Subscribing to every topic under " + "VSA/#")

	#register threads
	level_a_req_thread = Thread(target=topic_level_a_req_callback)
	events_thread = Thread(target=topic_events_callback)
	level_a_req_thread.start()
	events_thread.start()

	try:
		while client.connected_flag:
			time.sleep(1)
		client.disconnect()
		
	except KeyboardInterrupt:
		client.disconnect()

if __name__ == '__main__':
    main()