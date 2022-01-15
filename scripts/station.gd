extends Spatial


export var title := "Station" setget _set_title
export(float, 0.0, 1.0) var health := 1.0 setget _set_health
export var ui_offset := 1.0


func _process(delta: float) -> void:
	var screen_position := get_viewport().get_camera().unproject_position(global_transform.origin + Vector3.UP * ui_offset)
	$HUD/VBoxContainer.rect_position = screen_position


func damage(amount: float) -> void:
	self.health -= amount


func heal(amount: float) -> void:
	self.health += amount


func _set_title(new_title: String) -> void:
	$HUD/VBoxContainer/Label.text = new_title


func _set_health(new_health: float) -> void:
	health = clamp(new_health, 0.0, 1.0)
	$HUD/VBoxContainer/ProgressBar.value = health
