extends Area2D

signal hit

@export var speed = 400 # Plyaer speed
var screen_size # Size of the gmae window


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

	screen_size = get_viewport_rect().size
	print(screen_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # Player movement vector

	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
			
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		# $ is a shorthand for get_node() so $AnimatedSprite2D.play() is the same as get_node("AnimatedSprite2D").play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	# Clamping a value means restricting it to a given range
	position = position.clamp(Vector2.ZERO, screen_size) # This will prevent player from leaving the screen 
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(body:Node2D):
	hide()

	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true) # disable the player's collision so that we don't trigger the hit signal more than once.
	pass # Replace with function body.
