extends CharacterBody2D

@export var speed: float = 100.0
@export var player_color: Color
@export var player_name: String

var is_local: bool = false # only true for the character controlled
func _ready():
	$Sprite2D.modulate = player_color
	$Label.set_text(player_name)
	
	# only the local player should have an active camera
	#$Camera2D.enabled = is_local

func _physics_process(delta: float) -> void:
	if not is_local:
		return # only control the local player
		
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = input_vector.normalized() * speed
	move_and_slide()
	#print("working")
	#rotate character
	if input_vector.length() > 0:
		$Sprite2D.rotation = input_vector.angle()
