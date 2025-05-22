extends Node2D


func _ready():
	#for node in get_tree().get_nodes_in_group("hide"):
	#	node.hide()
	$Background.play()
	pass

#func _on_TitlePage_startGame():
#	for node in get_tree().get_nodes_in_group("hide"):
#		node.show() 
#	for node in get_tree().get_nodes_in_group("titlepage"):
#		node.hide() 

func _on_TitlePage_exit():
	get_tree().quit()
