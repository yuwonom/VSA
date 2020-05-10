'''
Developed for Vehicle Situational Awareness Project
Copyright © Queensland University of Technology 2020
Authored by @yuwonom (Michael Yuwono)
'''
import datetime, math
from enum import Enum

#list of topics
TOPIC_LEVEL_A_VEHSIM = "VSA/basicData/VRU/cycle"
TOPIC_LEVEL_A_VEHPROP = "VSA/vehProp/cycle"
TOPIC_LEVEL_A_REQ = "VSA/requests/all/cycle"
TOPIC_TRAFFIC = "VSA/traffic/all"
TOPIC_TRAFFIC_NEARBY_REQ = "VSA/traffic/nearby/reqs"
TOPIC_TRAFFIC_NEARBY_RETURN = "VSA/traffic/nearby/return"
TOPIC_VEHSIM = "VSA/vehSim"
TOPIC_VEHPROP = "VSA/vehProp"
TOPIC_VEHSIM_REQ = "VSA/request/vehSim/reqs"
TOPIC_VEHSIM_RETURN = "VSA/request/vehSim/return"
TOPIC_VEHPROP_REQ = "VSA/request/vehProp/reqs"
TOPIC_VEHPROP_RETURN = "VSA/request/vehProp/return"
TOPIC_INTERSECTIONS_REQ = "VSA/request/intersections/reqs"
TOPIC_INTERSECTIONS_RETURN = "VSA/request/intersections/return"


class VehicleType(Enum):
	CAR = "car"
	CYCLE = "cycle"
	MOTORBIKE = "motorbike"
	SCOOTER = "scooter"
	PEDESTRIAN = "pedestrian"


class Geolocation(object):
	latitude = 0
	longitude = 0

	def __init__(self, latitude, longitude):
		self.latitude = float(latitude)
		self.longitude = float(longitude)


class Geometry(object):
	type = "Point"
	coordinates = []
 
	def __init__(self, type, coordinates):
		self.type = type
		self.coordinates = coordinates


class Vehicle(object):
	uid = ""
	coordinate = Geolocation(0,0)
	velocity = 0
	position_error = 0
	rotation_angle = 0
	name = ""
	type = VehicleType.CAR
	dimensions = (0,0,0,0)
	intersection_id = ""

	def update_status(self, latitude, longitude, velocity, position_error, rotation_angle, intersection_id = ""):
		self.coordinate = Geolocation(latitude, longitude)
		self.velocity = velocity
		self.position_error = position_error
		self.rotation_angle = rotation_angle
		self.intersection_id = intersection_id

	def __init__(self, uid, name, type, dimensions):
		self.uid = uid
		self.name = name
		self.type = VehicleType(type)
		self.dimensions = dimensions


class Feature(object):
	id = 0
	geometries = []
	source_name = ""
	event_type = ""
	event_subtype = ""
	impact_type = ""
	impact_subtype = ""
	start_time = datetime.datetime(2018, 8, 30)
	end_time = datetime.datetime.now()
	event_priority = ""
	active_days = []
	recurrences_description = []
	description = ""
	information = ""

	def __init__(self, json):
		self.id = json["properties"]["id"]
		
		self.geometries = []
		for geometry in json["geometry"]["geometries"]:
			type = geometry["type"]
			coordinates = []
			if type == "Point":
				coordinates.append(Geolocation(geometry["coordinates"][1], geometry["coordinates"][0]))
			elif type == "LineString":
				for coordinate in geometry["coordinates"]:
					coordinates.append(Geolocation(coordinate[1], coordinate[0]))
			new_geometry = Geometry(type, coordinates)
			self.geometries.append(new_geometry)
		
		if (json["properties"]["source"]["source_name"] is not None):
			self.source_name = json["properties"]["source"]["source_name"]
		
		if (json["properties"]["event_type"] is not None):
			self.event_type = json["properties"]["event_type"]
		
		if (json["properties"]["event_subtype"] is not None):
			self.event_subtype = json["properties"]["event_subtype"]

		if (json["properties"]["impact"]["impact_type"] is not None):
			self.impact_type = json["properties"]["impact"]["impact_type"]
		
		if (json["properties"]["impact"]["impact_subtype"] is not None):
			self.impact_subtype = json["properties"]["impact"]["impact_subtype"]	
		
		if (json["properties"]["duration"]["start"] is not None):
			self.start_time = datetime.datetime.strptime(json["properties"]["duration"]["start"], '%Y-%m-%dT%H:%M:%S%z')
			
		if (json["properties"]["duration"]["end"] is not None):
			self.end_time = datetime.datetime.strptime(json["properties"]["duration"]["end"], '%Y-%m-%dT%H:%M:%S%z')
		
		if (json["properties"]["event_priority"] is not None):
			self.event_priority = json["properties"]["event_priority"]
			
		self.active_days = []
		for days in (json["properties"]["duration"]["active_days"] or []):
			self.active_days.append(days)
			
		self.recurrences_description = []
		for recur in (json["properties"]["duration"]["recurrences"] or []):
			self.recurrences_description.append(recur["description"])
		
		if (json["properties"]["description"] is not None):
			self.description = json["properties"]["description"]
		
		if (json["properties"]["information"] is not None):
			self.information = json["properties"]["information"]


class Intersection(object):
	id = ""
	coordinate = Geolocation(0,0)
	radius = 0.0

	def __init__(self, id, latitude, longitude, radius):
		self.id = id
		self.coordinate = Geolocation(latitude, longitude)
		self.radius = radius


def serialize(obj):
	'''
	JSON serializer for objects not serializable by default json code
	'''
	if isinstance(obj, datetime.datetime):
		serial = obj.isoformat()
		return serial

	return obj.__dict__


def distance(g1, g2):
	'''
	Calculate distance in metres from two geolocation.
	Formula referenced from https://en.wikipedia.org/wiki/Haversine_formula
	'''
	R = 6378.137 #radius of earth in KM
	
	latitude_diff = (g1.Latitude * math.pi / 180.0) - (g2.Latitude * math.pi / 180.0)
	longitude_diff = (g1.Longitude * math.pi / 180.0) - (g2.Longitude * math.pi / 180.0)
	
	a = math.pow(math.sin(latitude_diff / 2), 2) + math.cos(g1.Latitude * math.pi / 180) * math.cos(g2.Latitude * math.pi / 180) * math.pow(math.sin(longitude_diff / 2), 2)
	c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
	d = R * c
	return d * 1000 #convert to meters