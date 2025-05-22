extends KinematicBody2D

var velocity = Vector2(1, 0)
var speed = 1000

func _ready():
	pass 
	
	
func setVector(temp):	
	velocity = temp
	
func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	

func _on_Area2D_body_entered(body):
	
	if body.is_in_group("hit"):
		body.takeDamage()

	queue_free()
