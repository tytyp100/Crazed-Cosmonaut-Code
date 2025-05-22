extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("potion")


func gethit():
	queue_free()
