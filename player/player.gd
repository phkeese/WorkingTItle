extends KinematicBody

var color setget set_color
export var speed := 1.0


func _network_ready(is_source):
	if is_source:
		set_color(Color.from_hsv(rand_range(1, 360), 1, 1))
		translation = Vector3(rand_range(-1,1), 0, rand_range(-1,1))
	# same value on all clients now!
	print(color)


func _physics_process(delta: float) -> void:
	var right := Input.get_action_strength("player_1_right") - Input.get_action_strength("player_1_left")
	var up := Input.get_action_strength("player_1_up") - Input.get_action_strength("player_1_down")
	var movement := Vector3.RIGHT * right + Vector3.FORWARD * up
	move_and_slide(movement * speed, Vector3.UP)

	


func set_color(c: Color):
	color = c
	$char_v1.tint = color
