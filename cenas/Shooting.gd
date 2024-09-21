extends Node2D

@export var laser_scene = preload("res://cenas/laser.tscn")
var can_player_shoot = true
var shots_fired = 0

func _input(event):
	if Input.is_action_just_pressed("shoot") && can_player_shoot:
		var laser = laser_scene.instantiate() as Laser
		laser.global_position =  get_parent().global_position - Vector2(0,20)
		get_tree().root.add_child(laser)
		shots_fired += 1
		if shots_fired >= 2:
			can_player_shoot = false
			shots_fired = 0
		laser.tree_exited.connect(_tree_exited)

func _tree_exited():
	can_player_shoot = true
