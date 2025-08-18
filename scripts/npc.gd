extends CharacterBody2D

@export var speed: float = 100.0
@export var npc_color: Color

var wander_dir: Vector2 = Vector2.ZERO

func _ready():
	$Sprite2D.modulate = npc_color
	_pick_new_direction()

func _physics_process(delta: float) -> void:
	velocity = wander_dir * speed
	move_and_slide()

	# Occasionally change direction
	if randf() < 0.01:
		_pick_new_direction()

func _pick_new_direction():
	wander_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
