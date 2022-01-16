extends Spatial
signal crashed


onready var _rotor := $Ship/propeller


export var fire_scene : PackedScene


func _ready() -> void:
	var lwing := $"Ship/wing_l_flapping-1hz/AnimationPlayer" as AnimationPlayer
	lwing.get_animation("ArmatureAction").loop = true
	$"Ship/wing_l_flapping-1hz/AnimationPlayer".play("ArmatureAction")


func _on_give(to: Player, item_scene: PackedScene) -> void:
	var item := item_scene.instance()
	to.item = item


func _process(delta: float) -> void:
	var speed :=  $Stations/Engine.speed() as float
	$Ship/propeller/AnimationPlayer.playback_speed = speed
	$"Ship/wing_l_flapping-1hz/AnimationPlayer".playback_speed = speed / 5.0
	$"Ship/wing_l_flapping-1hz2/AnimationPlayer".playback_speed = speed / 5.0
	

func speed() -> float:
	return $Stations/Engine.speed() as float


func _on_Engine_powerdown() -> void:
	$Stations/Engine/AnimationPlayer.play("powerdown")
	

func _on_Engine_powerup() -> void:
	print("powerup")
	$Stations/Engine/AnimationPlayer.play("powerup")


func reset():
	for node in get_tree().get_nodes_in_group("consumers"):
		node.reset()


func spawn_fire():
	if $Fires.get_child_count():
		return
	print("spawn fire")
	var positions := $FirePositions.get_children()
	positions.shuffle()
	var pos = positions[0]
	var fire := fire_scene.instance() as Spatial
	fire.global_transform = pos.global_transform
	$Fires.add_child(fire)
	fire.global_transform = pos.global_transform
	


func _on_Disaster_timeout() -> void:
	if is_network_master():
		spawn_fire()
