extends Spatial
signal interacted_with(by, item)


export var title := "Station" setget _set_title
export(float, 0.0, 1.0) var health := 1.0 setget _set_health
export var ui_offset := 1.0


var _in_range := {}


func _ready() -> void:
	self.health = health


func _process(delta: float) -> void:
	var screen_position := get_viewport().get_camera().unproject_position(global_transform.origin + Vector3.UP * ui_offset)
	var vbox := $HUD/VBoxContainer as Control
	vbox.rect_position = screen_position - vbox.rect_size / 2.0


func _set_title(new_title: String) -> void:
	$HUD/VBoxContainer/Label.text = new_title


func _set_health(new_health: float) -> void:
	health = clamp(new_health, 0.0, 1.0)
	$HUD/VBoxContainer/ProgressBar.value = health


func _on_Area_body_entered(body: Node) -> void:
	if body.is_in_group("myplayers"):
		_in_range[body] = body
		body.connect("interacted", self, "_on_interacted")


func _on_Area_body_exited(body: Node) -> void:
	if body.is_in_group("myplayers"):
		_in_range[body] = null
		body.disconnect("interacted", self, "_on_interacted")


func _on_interacted(by: Node, item: Node) -> void:
	emit_signal("interacted_with", by, item)
