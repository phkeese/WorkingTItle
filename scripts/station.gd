extends Area


func _on_Station_body_entered(body: Node) -> void:
	print("enter %s" % body)


func _on_Station_body_exited(body: Node) -> void:
	print("exit %s" % body)
