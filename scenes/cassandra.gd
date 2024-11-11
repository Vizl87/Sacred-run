extends CharacterBody2D

@export var walk_speed = 300.0
@export var run_speed = 600.0
@export_range(0, 1) var acceleration = 0.1
@export_range(0, 1) var deceleration = 0.1

@export var jump_force = -400.0
@export_range(0, 1) var decelerate_on_jump_release = 0.1

@export var dash_speed = 1000.0
@export var dash_max_distance = 300.0
@export var dash_curve : Curve
@export var dash_cooldown = 1.0

var is_dashing = false
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0 

@export var coyote_time_remaining = 0
@export var coyote_time = 0.2


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_time_remaining -= delta
	else:
		coyote_time_remaining = coyote_time

	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_wall() or coyote_time_remaining > 0):
		velocity.y = jump_force
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= decelerate_on_jump_release
	var speed
	if Input.is_action_pressed("run") and is_on_floor():
		speed = run_speed
	else:
		speed = walk_speed
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)
		
		if not is_on_floor():
			velocity += get_gravity() * delta
			
			
			
				
	
	
		
	#dash activition
	if Input.is_action_just_pressed("dash") and direction and not is_dashing and dash_timer <= 0:
		is_dashing = true
		dash_start_position = position.x
		dash_direction = direction
		dash_timer = dash_cooldown
		
		#performs atual dash
	if is_dashing:
		var current_distance = abs(position.x - dash_start_position)
		if current_distance >= dash_max_distance  or is_on_wall():
			is_dashing = false
		else:
			velocity.x = dash_direction * dash_speed * dash_curve.sample(current_distance / dash_max_distance)
			velocity.y = 0
# reduces the dash timer
	if dash_timer > 0:
		dash_timer -= delta
		
func die() -> void:
	print("Player has died.")
	# You can implement what happens when the player dies, like restarting the game, reloading a level, etc.
	# For example, reset health and position:
 # Reset health
	position = Vector2(0, 0)  # Respawn at some position (e.g., the start of the level)





	move_and_slide()


func _on_kuolema_body_entered(_body: Node2D) -> void:
	die()
