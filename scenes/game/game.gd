extends Spatial


export var max_angle := 20.0
export var angle := 0.0 setget _set_angle
export var player_weight := 1.0
export var max_distance := 6.0
export var tilt_curve : Curve
export var max_pitch := 20.0
export var height := 100.0 setget _set_height


func _process(delta: float) -> void:
	var center := Vector3.ZERO
	for player in $Players.get_children():
		center += player.global_transform.origin * Vector3(1.0, 0.0, 1.0)
	center /= $Players.get_child_count()
	$MeshInstance.global_transform.origin = center + Vector3.UP * 3.0
	
	var tip = clamp(center.z, -max_distance, max_distance) / max_distance
	tip = sign(tip) * tilt_curve.interpolate_baked(abs(tip))
	var angle_delta : float = player_weight * tip * delta
	self.angle += angle_delta
	
	var speed := $Ship.speed() as float
	$CameraContainer.rotation_degrees.z = max_pitch * (1.0 - speed)
	
	self.height -= (1.0 - speed) / 10.0


func _set_angle(new_angle: float) -> void:
	angle = clamp(new_angle, -max_angle, max_angle)
	$CameraContainer.rotation_degrees = Vector3(-angle, 0.0, 0.0)
	$CameraContainer/Camera.rotation_degrees.z = angle / 5.0


func _set_height(new_height: float) -> void:
	height = clamp(new_height, 0.0, 100.0)
	$HUD/PanelContainer/VBoxContainer/Height.value = new_height
