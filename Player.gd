extends KinematicBody2D

var speed = 220
var screensize
var startposx = 200
var startposy = 200
var canmove = true
var canShoot = true
const positiveX = Vector2(1, 0)
const negativeX = Vector2(-1, 0)
var flipped = false

const gravity = 20
const maxFallSpeed =  200
const UPvector = Vector2(0, -1)
const jump = 600

const bulletPath = preload('res://Bullet.tscn')

var pHealth = 100;

#Vector used for player
var movement = Vector2.ZERO

func _ready():
	screensize = get_viewport_rect().size 
	$AnimatedSprite.play("default")
	
#creating bullet instance
func shoot():
	var bullet = bulletPath.instance()
	get_parent().add_child(bullet)
	
	if flipped == true:
		bullet.position = $Node2D/Position2D2.global_position - Vector2(130, 110)
	
	if flipped == false:
		bullet.position = $Node2D/Position2D.global_position - Vector2(130, 110)
	
	if flipped == true:
		bullet.get_node("AnimatedSprite").flip_h = true
		bullet.setVector(negativeX)
		
	if flipped == false:
		pass


func _physics_process(delta):
	
	if $AnimatedSprite.flip_h == true:
		flipped = true
		
	if $AnimatedSprite.flip_h == false:
		flipped = false
	
	if canmove == true:
		movement.y += gravity
	
		#if pHealth <= 0:
			#$Player.hide()
		
		#Player controls
		if Input.is_action_pressed("ui_right"):
			movement.x = speed
			$AnimatedSprite.flip_h = false
			if is_on_floor() == true:
				$AnimatedSprite.play("run")
			
		elif Input.is_action_pressed("ui_left"):
			movement.x = -speed
			$AnimatedSprite.flip_h = true
			if is_on_floor() == true:
				$AnimatedSprite.play("run")
				
		else:
			movement.x = 0
			
			
		if Input.is_action_just_released("ui_right"):
			$AnimatedSprite.play("default")	
			
		if Input.is_action_just_released("ui_left"):
			$AnimatedSprite.play("default")	
			
		
		if Input.is_action_just_pressed("ui_shoot"):
			
			if canShoot == true:
					
				canShoot = false
				shoot()
				$shootTimer.start()
				$AnimatedSprite.play("shoot")
				yield($shootTimer, "timeout")
		
			
		if Input.is_action_just_pressed("ui_punch"):
			
			if $AnimatedSprite.flip_h == false:
				$Area2D/punch_range_right.disabled = false
				
			if $AnimatedSprite.flip_h == true:
				$Area2D2/punch_range_left.disabled = false
				
			$AnimatedSprite.play("punch")
			$punchSound.play()
			
			
			
		if Input.is_action_just_released("ui_punch"):
			$AnimatedSprite.play("default")
			
			
			$Area2D/punch_range_right.disabled = true
			$Area2D2/punch_range_left.disabled = true
				
			
			
		#sets new position of the player
		if is_on_floor():
			if Input.is_action_just_pressed("ui_jump"):
				jump()
				
		movement = move_and_slide(movement, UPvector)

func jumpRecoil(jumpPower):
	$AnimatedSprite.play("jump")
	movement.y = -jumpPower

func jump():
	$AnimatedSprite.play("jump")
	movement.y = -jump
	$jumpSound.play() #Sound Effect from https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=6462

func _on_HealthReduce_timeout():
	pHealth -= 2
	$Camera2D/ProgressBar.value = pHealth
	if pHealth <= 0:
		get_tree().change_scene("res://TitlePage.tscn")

#func _on_TitlePage_startGame():
#	canmove = true

func _on_StaticBody2D_BREAK():
		if pHealth < 80:
			pHealth += 20
		else:
			pHealth = 100

func _on_StaticBody2D2_BREAK():
		if pHealth < 80:
			pHealth += 20
		else:
			pHealth = 100

func _on_hisbody_body_entered(body):
	if body.is_in_group("astronaut"):
		pHealth -= 20
		jumpRecoil(300)
		
	if body.is_in_group("laser"):
		pHealth -= 20
		$laser.play()
		jumpRecoil(550)
		
		
	if pHealth <= 0:
		get_tree().change_scene("res://TitlePage.tscn")


func _on_flagpole_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://TitlePage.tscn")
	
	
func _on_shootTimer_timeout():
	canShoot = true
