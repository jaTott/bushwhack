extends CharacterBody2D

@export var speed: float = 100.0
@export var npc_color: Color

var move_vector: Vector2 = Vector2.ZERO
var stop_time: float = 0.0
var move_time: float = 0.0

func _ready():
	$Sprite2D.modulate = npc_color
	_choose_new_state()

func _physics_process(delta: float) -> void:
	if stop_time > 0:
		stop_time -= delta
		velocity = Vector2.ZERO
	elif move_time > 0:
		move_time -= delta
		velocity = move_vector * speed
	else:
		_choose_new_state()

	move_and_slide()

	# Rotate sprite like the player
	if velocity.length() > 0:
		$Sprite2D.rotation = lerp_angle($Sprite2D.rotation, velocity.angle(), 0.2)

func _choose_new_state():
	if randf() < 0.3:
		# Stop for a random duration
		stop_time = randf_range(0.5, 2.0)
		move_vector = Vector2.ZERO
	else:
		# Move in a random player-like direction for some time
		var directions = [
			Vector2(1, 0),   # right
			Vector2(-1, 0),  # left
			Vector2(0, 1),   # down
			Vector2(0, -1)   # up
		]
		move_vector = directions.pick_random()
		move_time = randf_range(1.0, 3.0)
