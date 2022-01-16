extends Spatial
signal powerdown
signal powerup

export var decay_time := 10.0
export var fire_station : NodePath
export var boiler_station : NodePath
var is_powered := true setget _set_powered


func _ready() -> void:
	is_powered = true


func _process(delta: float) -> void:
	var fire = get_node(fire_station)
	var steam = get_node(boiler_station)
	self.is_powered = not (is_equal_approx(fire.get_health(), 0.0) or is_equal_approx(steam.get_health(), 0.0))
	var change := delta / decay_time
	if not is_powered:
		change *= -1
	$Station.health += change

func speed() -> float:
	return $Station.health


func _set_powered(new_state: bool):
	if is_powered == new_state:
		return
	else:
		is_powered = new_state
		if is_powered:
			emit_signal("powerup")
		else:
			emit_signal("powerdown")
