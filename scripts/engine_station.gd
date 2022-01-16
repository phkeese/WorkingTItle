extends Spatial


export var decay_time := 10.0
export var fire_station : NodePath
export var boiler_station : NodePath


func _process(delta: float) -> void:
	var change := delta / decay_time
	if not has_requirements():
		change *= -1
	$Station.health += change


func has_requirements() -> bool:
	var fire = get_node(fire_station)
	var steam = get_node(boiler_station)
	return not (is_equal_approx(fire.get_health(), 0.0) or is_equal_approx(steam.get_health(), 0.0))
	

func speed() -> float:
	return $Station.health
