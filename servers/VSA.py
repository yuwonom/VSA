'''
Developed for Vehicle Situational Awareness Project
Copyright © Queensland University of Technology 2019
Authored by @yuwonom (Michael Yuwono)
'''
import datetime, math
from enum import Enum

#list of topics
TOPIC_TRAFFIC = "VSA/traffic/all"
TOPIC_TRAFFIC_NEARBY_REQ = "VSA/traffic/nearby/reqs"
TOPIC_TRAFFIC_NEARBY_RETURN = "VSA/traffic/nearby/return"
TOPIC_VEHSIM = "VSA/vehSim"
TOPIC_VEHPROP = "VSA/vehProp"
TOPIC_VEHSIM_REQ = "VSA/request/vehSim/reqs"
TOPIC_VEHSIM_RETURN = "VSA/request/vehSim/return"
TOPIC_VEHPROP_REQ = "VSA/request/vehProp/reqs"
TOPIC_VEHPROP_RETURN = "VSA/request/vehProp/return"


class VehicleType(Enum):
	CAR = "car"
	CYCLE = "cycle"
	MOTORBIKE = "motorbike"
	SCOOTER = "scooter"
	PEDESTRIAN = "pedestrian"


class Geolocation(object):
	Latitude = 0
	Longitude = 0

	def __init__(self, latitude, longitude):
		self.Latitude = float(latitude)
		self.Longitude = float(longitude)


class Geometry(object):
	Type = "Point"
	Coordinates = []
 
	def __init__(self, type, coordinates):
		self.Type = type
		self.Coordinates = coordinates


class Vehicle(object):
	UID = ""
	Coordinate = Geolocation(0,0)
	Velocity = 0
	PositionError = 0
	RotationAngle = 0
	Name = ""
	Type = VehicleType.CAR
	Dimensions = (0,0,0,0)

	def UpdateStatus(self, latitude, longitude, velocity, positionError, rotationAngle):
		self.Coordinate = Geolocation(latitude, longitude)
		self.Velocity = velocity
		self.PositionError = positionError
		self.RotationAngle = rotationAngle

	def __init__(self, uid, name, type, dimensions):
		self.UID = uid
		self.Name = name
		self.Type = VehicleType(type)
		self.Dimensions = dimensions


class Feature(object):
	ID = 0
	Geometries = []
	SourceName = ""
	EventType = ""
	EventSubType = ""
	ImpactType = ""
	ImpactSubType = ""
	StartTime = datetime.datetime(2018, 8, 30)
	EndTime = datetime.datetime.now()
	EventPriority = ""
	ActiveDays = []
	RecurrencesDescription = []
	Description = ""
	Information = ""

	def __init__(self, json):
		self.ID = json["properties"]["id"]
		
		self.Geometries = []
		for geometry in json["geometry"]["geometries"]:
			type = geometry["type"]
			coordinates = []
			if type == "Point":
				coordinates.append(Geolocation(geometry["coordinates"][1], geometry["coordinates"][0]))
			elif type == "LineString":
				for coordinate in geometry["coordinates"]:
					coordinates.append(Geolocation(coordinate[1], coordinate[0]))
			newGeometry = Geometry(type, coordinates)
			self.Geometries.append(newGeometry)
		
		if (json["properties"]["source"]["source_name"] is not None):
			self.SourceName = json["properties"]["source"]["source_name"]
		
		if (json["properties"]["event_type"] is not None):
			self.EventType = json["properties"]["event_type"]
		
		if (json["properties"]["event_subtype"] is not None):
			self.SubType = json["properties"]["event_subtype"]

		if (json["properties"]["impact"]["impact_type"] is not None):
			self.ImpactType = json["properties"]["impact"]["impact_type"]
		
		if (json["properties"]["impact"]["impact_subtype"] is not None):
			self.ImpactSubType = json["properties"]["impact"]["impact_subtype"]	
		
		if (json["properties"]["duration"]["start"] is not None):
			self.StartTime = datetime.datetime.strptime(json["properties"]["duration"]["start"], '%Y-%m-%dT%H:%M:%S%z')
			
		if (json["properties"]["duration"]["end"] is not None):
			self.EndTime = datetime.datetime.strptime(json["properties"]["duration"]["end"], '%Y-%m-%dT%H:%M:%S%z')
		
		if (json["properties"]["event_priority"] is not None):
			self.EventPriority = json["properties"]["event_priority"]
			
		self.ActiveDays = []
		for days in (json["properties"]["duration"]["active_days"] or []):
			self.ActiveDays.append(days)
			
		self.RecurrencesDescription = []
		for recur in (json["properties"]["duration"]["recurrences"] or []):
			self.RecurrencesDescription.append(recur["description"])
		
		if (json["properties"]["description"] is not None):
			self.Description = json["properties"]["description"]
		
		if (json["properties"]["information"] is not None):
			self.Information = json["properties"]["information"]


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