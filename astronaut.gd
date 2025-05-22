extends KinematicBody2D

export (int) var walkSpeedMin = 10
export (int) var walkSpeedMax = 30
export (int) var runningSpeedMin = 70
export (int) var runningSpeedMax = 100
export (int) var gravity = 20

var lookAt = Vector2(1,0)
var movement = Vector2.ZERO
var UPvector = Vector2(0,-1)


var directionMultiplier

export (int) var health = 400 

signal yell




func _ready():
	#Used for randomly choosing a direction
	var rng = RandomNumberGenerator.new()

	rng.randomize()
	var startDir = rng.randi_range(1, 10)
	rng.randomize()
	var walkS = rng.randi_range(100, 120)
	rng.randomize()
	var RunS = rng.randi_range(50, 80)
	
	$AnimatedSprite.play("run")
	
	if startDir <=7:
		lookAt = Vector2(-1, 0)
		$AnimatedSprite.flip_h = true
		directionMultiplier = -1
		
	if startDir > 7:
		lookAt = Vector2(1, 0)
		$AnimatedSprite.flip_h = false
		directionMultiplier = 1
		
	movement.x = walkS*directionMultiplier
		


func _physics_process(delta):
	
	movement.y += gravity
	movement = move_and_slide(movement, UPvector)
	
	if health <= 0:
		queue_free()
	
	
	
		
	if is_on_wall():
		
		if $AnimatedSprite.flip_h == false:
			$AnimatedSprite.flip_h = true
			
		elif $AnimatedSprite.flip_h == true:
			$AnimatedSprite.flip_h = false
			
		else:
			pass
		
		if directionMultiplier == -1:
			directionMultiplier = 1
			
		elif directionMultiplier == 1:
			directionMultiplier = -1
			
		else:
			pass
			
	if movement.x == 0:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var newSpeed = rng.randi_range(100,120)
		movement.x = newSpeed*directionMultiplier
		
func takeDamage():
	if health == 300:
		$Yell.play()
	health -= 100

	
	



