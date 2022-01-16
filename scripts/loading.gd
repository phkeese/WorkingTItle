extends Control


export var game : PackedScene


func do_load() -> void:
	get_tree().change_scene_to(game)
