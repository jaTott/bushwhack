extends Node

@export var player_scene: PackedScene
@export var npc_scene: PackedScene
@export var npc_count: int = 20
@export var colors: Array[Color] = [Color.RED, Color.BLUE, Color.GREEN, Color.YELLOW]
@export var player_names: Array[String] = ["Tott", "Charis", "Dave", "Adrian"]

var players: Array = []
var npcs: Array = []
var contracts: Dictionary = {}  # {player_id: target_id}

func _ready():
	_spawn_players()
	print("GameManager is running!")
	_spawn_npcs()
	#_assign_contracts()

func _spawn_players():
	
	var spawn_points = get_node("../SpawnPoints").get_children()

	for i in range(player_names.size()):
		var player = player_scene.instantiate()
		player.player_color = colors[i]
		player.player_name = player_names[i]
		
		# pick a spawn point
		var spawn_point = spawn_points[i % spawn_points.size()]
		player.global_position = spawn_point.global_position;
		print("player spawned!")
		
		# make only the first player local (controllable)
		player.is_local = (i == 0) # is_local bool is 1 when i == 0 (first iteration of loop)
		
		print(player.is_local)
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
