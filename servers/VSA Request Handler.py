'''
Developed for Vehicle Situational Awareness Project
Copyright © Queensland University of Technology 2019
Authored by @yuwonom (Michael Yuwono)
'''
import sys, time, math, json
import paho.mqtt.client as mqtt
import VSA, Broker

#properties
NAME = "VSA Request Handler";
VERSION = "2.0.1";

# ------------------------------------------------------------------------ #

def on_connect(client, userdata, flags, rc):
	if rc == 0:
		client.connected_flag = True;
		print("Connected.");
	else:
		print("Connection failed.");

def on_disconnect(client, userdata, rc=0):
	client.loop_stop();
	client.connected_flag = False;
	print(NAME + " stopped.");
	print("Disconnected result code: " + str(rc));
	
def on_message(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"));
	print("Message published to topic: " + msg.topic);
	
def topic_traffic_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"));
	json_features = json.loads(payload);

	global features;
	features = [];
	
	for data in json_features:
		feature = VSA.Feature(data);
		features.append(feature);
	
	print("Features updated.");
	
def topic_traffic_nearby_req_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"));
	items = payload.split(',');
	vehID = items[0];
	latitude = float(items[1]);
	longitude = float(items[2]);
	radius = float(items[3]);
	
	global features;
	
	user_geolocation = VSA.Geolocation(latitude, longitude);
	features_res = [];
	features_tmp = features;
	
	last_radius = 0;
	last_lat = 0;
	last_lng = 0;
	for feature in features_tmp:
		include = False;
		for geometry in feature.Geometries:
			for coordinate in geometry.Coordinates:
				if (VSA.distance(user_geolocation, coordinate) <= radius):
					include = True;
					break;
			if (include):
				break;
		if (include):
			features_res.append(feature);
	
	print(str(len(features_res)) + " events found.");
	client.publish(VSA.TOPIC_TRAFFIC_NEARBY_RETURN + "/" + vehID, json.dumps(features_res, default = VSA.serialize));
	
def topic_vehsim_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"));
	items = payload.split(',');
	uid = items[0];
	latitude = float(items[1]);
	longitude = float(items[2]);
	velocity = float(items[3]);
	accuracy = float(items[4]);
	direction = float(items[5]);

	global vehicles;

	if uid not in vehicles:
		pass;

	vehicles[uid].UpdateStatus(latitude, longitude, velocity, accuracy, direction);
	
def topic_vehprop_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"));
	items = payload.split(',');
	uid = items[0];
	name = items[1];
	description = items[2];
	left = float(items[3]);
	top = float(items[4]);
	right = float(items[5]);
	bottom = float(items[6]);
	dimensions = (left, top, right, bottom);

	global vehicles;

	if uid in vehicles:
		del vehicles[uid];

	vehicle = VSA.Vehicle(uid, name, description, dimensions);
	vehicles[uid] = vehicle;

def topic_vehsim_req_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"));
	items = payload.split(',');
	vehID = items[0];
	radius = float(items[1]);

	global vehicles;

	data = vehicles.copy();
	del data[vehID];

	client.publish(VSA.TOPIC_VEHSIM_RETURN + "/" + vehID, json.dumps(data, default = VSA.serialize));
	
def topic_vehprop_req_callback(mqttc, obj, msg):
	payload = str(msg.payload.decode("utf-8"));
	items = payload.split(',');
	vehID = msg.topic.split('/')[-1];

	global vehicles;

	data = [];
	for nearbyID in items:
		if (nearbyID not in vehicles):
			continue;
		data.append(vehicles[nearbyID]);

	client.publish(VSA.TOPIC_VEHPROP_RETURN + "/" + vehID, json.dumps(data, default = VSA.serialize));

# ------------------------------------------------------------------------ #	
	
print("===== " + NAME + " v" + VERSION + " =====");

#global variables
vehicles = {};
features = [];

#new client
client = mqtt.Client();
client.connected_flag = False;
client.on_connect = on_connect;
client.on_disconnect = on_disconnect;
client.on_message = on_message;
client.message_callback_add(VSA.TOPIC_TRAFFIC + "/#", topic_traffic_callback);
client.message_callback_add(VSA.TOPIC_TRAFFIC_NEARBY_REQ + "/#", topic_traffic_nearby_req_callback);
client.message_callback_add(VSA.TOPIC_VEHSIM + "/#", topic_vehsim_callback);
client.message_callback_add(VSA.TOPIC_VEHPROP + "/#", topic_vehprop_callback);
client.message_callback_add(VSA.TOPIC_VEHSIM_REQ + "/#", topic_vehsim_req_callback);
client.message_callback_add(VSA.TOPIC_VEHPROP_REQ + "/#", topic_vehprop_req_callback);

#connecting to broker
print("Connecting to broker...");
client.username_pw_set(Broker.USERNAME, Broker.PASSWORD);
client.connect(Broker.ADDRESS, Broker.PORT);
client.loop_start();
while not client.connected_flag:
	time.sleep(1);

#subscribing VSA/#
client.subscribe("VSA/#");
print("Subscribing to every topic under " + "VSA/#");

try:
	while client.connected_flag:
		time.sleep(1);
	client.disconnect();
	
except KeyboardInterrupt:
	client.disconnect();