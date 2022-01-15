extends Spatial


export var max_interactions := 10
export var interactions := 0 setget _set_interactions


onready var _station := $Station


func interact(player: Node):
	interactions += 1


func _set_interactions(new: int) -> void:
	interactions = clamp(new, 0, max_interactions)
	_station.health += 1 / max_interactions
