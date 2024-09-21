extends Area2D

class_name  Laser
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

@export var speed = 300

func _process(delta):
	position.y -= speed * delta

func _ready():
	audio_stream_player_2d.play()
