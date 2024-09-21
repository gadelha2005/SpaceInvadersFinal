extends Node2D


@onready var spawn_timer = $SpawnTimer
var ufo_shot_scene = preload("res://cenas/invader_shot.tscn")


func _ready():
	spawn_timer.setup_timer()
	

func _on_spawn_timer_timeout():
	var ufo_shot = ufo_shot_scene.instantiate()
	var ufo_shot_sprite = ufo_shot.get_node("Sprite2D") as Sprite2D
	ufo_shot.global_position = global_position
	get_tree().root.add_child(ufo_shot)
	spawn_timer.setup_timer()
