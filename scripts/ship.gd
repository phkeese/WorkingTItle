extends Spatial


onready var _rotor := $Ship/propeller


func _on_give(to: Player, item_scene: PackedScene) -> void:
	var item := item_scene.instance()
	to.item = item


func _process(delta: float) -> void:
	$Ship/propeller/AnimationPlayer.playback_speed = $Stations/Engine.speed()
