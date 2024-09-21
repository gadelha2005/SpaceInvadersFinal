extends Node2D

class_name Invader_Spawner 

signal  invader_destroyed(points: int)
signal game_won
signal  game_lost

const ROWS = 5
const COLUMNS = 11
const HORIZONTAL_SPACING = 32
const VERTICAL_SPACING = 32
const INVADER_HEIGHT = 24
const START_Y = -50
const INVADERS_POSITION_X_INCREMENT = 10
const INVADERS_POSITION_Y_INCREMENT = 20

var movement_direction = 1
var invader_scene = preload("res://cenas/invader.tscn")
@onready var timer = $Timer
@onready var shot_timer = $shotTimer
var invader_shot_scene = preload("res://cenas/invader_shot.tscn")
var invader_destroy_count = 0
var invader_total_count = ROWS * COLUMNS

func _ready():
	var invader_1_res = preload("res://Resources/invader_1.tres")
	var invader_2_res = preload("res://Resources/invader_2.tres")
	var invader_3_res = preload("res://Resources/invader_3.tres")
	
	var invader_config
	
	for row in ROWS:
		if row == 0:
			invader_config = invader_1_res
		elif row == 1 || row == 2:
			invader_config = invader_2_res
		elif row == 3 || row == 4:
			invader_config = invader_3_res
			
		var row_width = (COLUMNS * invader_config.width * 3) + ((COLUMNS - 1) * HORIZONTAL_SPACING)
		var start_x = (position.x - row_width)/2
		
		for col in COLUMNS:
			var x = start_x + (col * invader_config.width * 3) + (col * HORIZONTAL_SPACING)
			var y = START_Y + (row * INVADER_HEIGHT) + (row * VERTICAL_SPACING) 
			var spawner_position = Vector2(x,y)
			invader_spawner(invader_config,spawner_position)
			
func invader_spawner(invader_config , spawner_position:Vector2):
	var invader = invader_scene.instantiate() as Invader
	invader.config = invader_config
	invader.global_position = spawner_position
	invader.invader_destroyed.connect(_on_invader_destroyed)
	add_child(invader)



func _on_timer_timeout():
	position.x += INVADERS_POSITION_X_INCREMENT * movement_direction
	


func _on_left_wall_area_entered(area):
	if(movement_direction == -1):
		position.y += INVADERS_POSITION_Y_INCREMENT
		movement_direction *= -1





func _on_right_wall_area_entered(area):
	if(movement_direction == 1):
		position.y += INVADERS_POSITION_Y_INCREMENT
		movement_direction *= -1




	
	



func _on_shot_timer_timeout():
	var random_child_position = get_children().filter(func (child ): return child is Invader).map(func (invader): return invader.global_position).pick_random()

	var invader_shot = invader_shot_scene.instantiate() as InvaderShot
	invader_shot.global_position = random_child_position
	get_tree().root.add_child(invader_shot)

func _on_invader_destroyed(points:int):
	invader_destroyed.emit(points)
	invader_destroy_count += 1
	if invader_destroy_count == invader_total_count:
		game_won.emit()
		shot_timer.stop()
		timer.stop()
	


func _on_bottom_wall_area_entered(area):
	game_lost.emit()
	timer.stop()
	movement_direction = 0
