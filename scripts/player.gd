extends CharacterBody2D

@export var speed: float = 200.0
@export var player_color: Color

func _ready():
	$Sprite2D.modulate = player_color

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = input_vector.normalized() * speed
	move_and_slide()
