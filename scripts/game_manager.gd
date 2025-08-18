extends Node

@export var player_scene: PackedScene
@export var npc_scene: PackedScene
@export var npc_count: int = 20
@export var colors: Array[Color] = [Color.RED, Color.BLUE, Color.GREEN, Color.YELLOW]

var players: Array = []
var npcs: Array = []
var contracts: Dictionary = {}  # {player_id: target_id}

func _ready():
	print("GameManager is running!")

	_spawn_players()
	_spawn_npcs()
	_assign_contracts()

func _spawn_players():
	for i in range(colors.size()):
		var player = player_scene.instantiate()
		player.player_color = colors[i]
		add_child(player)
		players.append(player)

func _spawn_npcs():
	for i in range(npc_count):
		var npc = npc_scene.instantiate()
		npc.npc_color = colors.pick_random()
		add_child(npc)
		npcs.append(npc)

func _assign_contracts():
	var player_ids = players.duplicate()
	player_ids.shuffle()
	for i in range(player_ids.size()):
		var hunter = player_ids[i]
		var target = player_ids[(i + 1) % player_ids.size()]
		contracts[hunter] = target
