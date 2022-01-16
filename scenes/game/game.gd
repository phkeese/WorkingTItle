extends Spatial


export var max_angle := 20.0
export var angle := 0.0 setget _set_angle
export var player_weight := 1.0
export var max_distance := 6.0
export var tilt_curve : Curve
export var max_pitch := 20.0
export var height := 100.0 setget _set_height
export var game_time := 0.0 setget _set_game_time



func _ready() -> void:
	game_over()


func _process(delta: float) -> void:
	var center := Vector3.ZERO
	var count := 0
	for player in $Players.get_children():
		var position := player.global_transform.origin as Vector3
		if position.y < -1:
			continue
		center += position * Vector3(1.0, 0.0, 1.0)
		count += 1
	center /= count
	$MeshInstance.global_transform.origin = center + Vector3.UP * 3.0
	
	var tip = clamp(center.z, -max_distance, max_distance) / max_distance
	tip = sign(tip) * tilt_curve.interpolate_baked(abs(tip))
	var angle_delta : float = player_weight * tip * delta
	self.angle += angle_delta
	
	var speed := $Ship.speed() as float
	$CameraContainer.rotation_degrees.z = max_pitch * (1.1 - speed)
	
	self.height -= (0.9 - speed) / 10.0
	self.game_time += delta



func _set_angle(new_angle: float) -> void:
	angle = clamp(new_angle, -max_angle, max_angle)
	$CameraContainer.rotation_degrees = Vector3(-angle, 0.0, 0.0)
	$CameraContainer/Camera.rotation_degrees.z = angle / 5.0


func _set_height(new_height: float) -> void:
	height = clamp(new_height, 0.0, 100.0)
	$HUD/Ingame/PanelContainer/VBoxContainer/Height.value = new_height
	$CameraContainer/Camera/Camera.translation = 20.0 * Vector3.BACK * (100 - new_height) / 100.0
	if is_equal_approx(height, 0.0):
		rpc("game_over")


func _set_game_time(new_time):
	game_time = new_time
	$HUD/Ingame/Scoreboard/Panel/Label.text = "%s m" % floor(new_time)


func _on_Play_pressed():
	rpc("start_game")


remotesync func start_game():
	$HUD/Lobby/PanelContainer.hide()
	
	get_tree().paused = false
	
	if is_network_master():
		self.height = 100.0
		self.angle = 0.0
		for node in get_tree().get_nodes_in_group("consumer"):
			node.reset()
	
	print("start game")


remotesync func game_over():
	$HUD/Lobby/PanelContainer.show()
	$HUD/Lobby/PanelContainer/CenterContainer/VBoxContainer/Score.text = "%s m" % game_time
	
	get_tree().paused = true
	print("end game")


func _on_Restart_pressed():
	pass

