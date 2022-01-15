extends Spatial


export var title := "Station" setget _set_title
export(float, 0.0, 1.0) var health := 1.0 setget _set_health


func damage(amount: float) -> void:
	self.health -= amount


func heal(amount: float) -> void:
	self.health += amount


func _set_title(new_title: String) -> void:
	$HUD/VBoxContainer/Label.text = new_title


func _set_health(new_health: float) -> void:
	health = clamp(new_health, 0.0, 1.0)
	$HUD/VBoxContainer/ProgressBar.value = health
