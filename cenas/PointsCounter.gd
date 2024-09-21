extends Node


class_name PointsCounter

signal increased_points(points:int)
var points = 0
@onready var invader_spawner = $"../InvaderSpawner"

func _ready():
	(invader_spawner as Invader_Spawner).invader_destroyed.connect(on_increased_points)
	
func on_increased_points(points_to_add:int):
	points += points_to_add
	increased_points.emit(points) 
