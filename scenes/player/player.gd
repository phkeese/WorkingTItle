class_name Player
extends KinematicBody
signal interacted(player, item)

export var speed := 1.0
export var gravity := 9.81


var color setget set_color
var item : Spatial setget _set_item


func _network_ready(is_source):
	if is_source:
		set_color(Color.from_hsv(rand_range(1, 360), 1, 1))
		translation = Vector3(rand_range(-1,1), 0, rand_range(-1,1))
	# same value on all clients now!
	print(color)


func _physics_process(delta: float) -> void:
	var right := Input.get_action_strength("player_1_right") - Input.get_action_strength("player_1_left")
	var up := Input.get_action_strength("player_1_up") - Input.get_action_strength("player_1_down")
	var movement := Vector3.RIGHT * right + Vector3.FORWARD * up + Vector3.DOWN * gravity
	move_and_slide(movement * speed, Vector3.UP, true)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("player_1_interact"):
		rpc("interacted")


remotesync func interacted() -> void:
	if get_tree().is_network_server():
		emit_signal("interacted", self, item)


func set_color(c: Color):
	color = c
	$char_v1.tint = color


func _set_item(new_item: Spatial) -> void:
	if item:
		pass
	elif new_item:
		item = new_item
		item.global_transform = $Hands.global_transform
		add_child(item)
		item.global_transform = $Hands.global_transform		


remotesync func remove_item() -> void:
	if item:
		item.get_node("Sync").remove()
		item = null
