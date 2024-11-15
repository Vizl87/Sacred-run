extends CharacterBody2D

@export var walk_speed = 300.0
@export var run_speed = 600.0
@export_range(0, 1) var acceleration = 0.1
@export_range(0, 1) var deceleration = 0.1

@export var jump_force = -550.0
@export_range(0, 1) var decelerate_on_jump_release = 0.5

@export var dash_speed = 1000.0
@export var dash_max_distance = 300.0
@export var dash_curve : Curve
@export var dash_cooldown = 1

@export var maxhealth = 3
@onready var currenthealth: int = maxhealth

@export var health_anim: Panel
var is_dashing = false
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0
# Maximum health
@onready var health = 3  # Starting health
@export var collectible: int = 0
@onready var kyllä: int = collectible
# Coyote time variables
@export var coyote_time = 0.2
@export var coyote_time_remaining = 0.0  # Grace period for jumping after leaving the ground
 # Tracks how long the player has been off the platform
var kuolema = 0
func _physics_process(delta: float) -> void:
	
	health_anim._on_health_changed()
	
	# Add gravity when not on the floor
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_time_remaining -= delta
	else:
		coyote_time_remaining = coyote_time
		
		
	# Handle jump deceleration when the jump key is released
	if Input.is_action_just_pressed("jump") and (is_on_wall() or coyote_time_remaining > 0):
		velocity.y = jump_force
	# Handle horizontal movement (walking/running)
	var speed
	if Input.is_action_pressed("run") and is_on_floor():
		speed = run_speed
	else:
		speed = walk_speed

	var direction := Input.get_axis("left", "right")
	if direction != 0:
		# Move player with acceleration
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		# Flip the sprite based on movement direction
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		# Decelerate when no direction is pressed
		velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)
		




	# Add gravity if the player is airborne
	if not is_on_floor() or Input.is_action_just_pressed("ui_accept"):
		velocity += get_gravity() * delta
	

	# Dash activation
	if Input.is_action_just_pressed("dash") and direction != 0 and not is_dashing and dash_timer <= 0:
		is_dashing = true
		dash_start_position = position.x
		dash_direction = direction
		dash_timer = 0.5

	# Perform dash movement
	if is_dashing:
		var current_distance = abs(position.x - dash_start_position)
		if current_distance >= dash_max_distance or is_on_wall():
			is_dashing = false
		else:
			velocity.x = dash_direction * dash_speed * dash_curve.sample(current_distance / dash_max_distance)
			velocity.y = 0  # Prevent vertical movement during dash
	else:
		pass

	# Reduce the dash cooldown timer
	if dash_timer > 0:
		dash_timer -= delta
	if dash_timer == 0:
		is_dashing = false
	
	

	
	if currenthealth == 0:
		die()
		
		
		currenthealth = maxhealth

		
		
	if Input.is_action_just_pressed("emp"):
		$"../Piiloansa".hide()
		$"../Piiloansa/neliö".disabled = true
		await get_tree().create_timer(7.0).timeout
		$"../Piiloansa".show()
		$"../Piiloansa/neliö".disabled = false
		 


		
#main mekaniikka joka saa ansat menee  pois käytöstä 7 sekunniksi
	if Input.is_action_just_pressed("heal"):
		currenthealth += 1



		

		

		
 
	# Final movement
	move_and_slide()




	


# Function to handle death
var played = false
#todo hoida collectable homma loppuun
func die() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().reload_current_scene()
	
func print_collectible():
	print(collectible)
	if currenthealth == 0:
		get_tree().reload_current_scene()
		collectible = 0
		
		

		
		
	
	
	
	# You can implement what happens when the player dies, like restarting the game, reloading a level, etc.
	# For example, reset health and position:
 # Reset health
	position = Vector2(695, 34)  # Respawn at some position (e.g., the start of the level)
	

func _on_kuolema_body_entered(_body: Node2D) -> void:
	die()
	print("damm you have gotten FAT")
	currenthealth = maxhealth
	
	
	#velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)
#piiloansa perkele!

 # Start the timer to delay seeking to the last frame slightly
func _on__spike_area__body_entered(body: Node2D) -> void:
	
	if body.name == "cassandra":
		currenthealth -= 1
		health_anim.animation_finished = false
		$"../Piiloansa/neliö/Ansa".play()
func _on_AnimatedSprite_animation_finished():
	if $"../Piiloansa/neliö/Ansa" .current_animation == "Ansa":
		$"../Piiloansa/neliö/Ansa".frame = 10

		
		
		
		
	
	
	
	

		
		

		
