extends StaticBody2D

export (int) var crateHealth = 100
var newpos = position
signal BREAK 

func _ready():
	$AnimatedSprite.play("default")

func takeDamage():
	crateHealth -= 100
	
	$crateDamage.play()
	
	if crateHealth <= 0:
		
		
		$AnimatedSprite.play("break")
		$destroyed.start()
		$CollisionShape2D.queue_free()
		
		emit_signal("BREAK")
		yield($destroyed, "timeout")
		
		
		#var nodeInstance = preload("res://HPotion.tscn")
		#var po = nodeInstance.instance()
		#po.position = Vector2(0,0)
		
		self.queue_free()

func _on_destroyed_timeout():
	pass 
