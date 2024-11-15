extends Area2D

@export var health:  Control
@export var currenthealth  = 3
@export var health_anim: Panel
# Called when the node enters the scene tree for the first time.
func _on__spike_area__body_entered(body: Node2D) -> void:
	
	if body.name == "cassandra":
		currenthealth -= 1
		health_anim.animation_finished = false
		$"../Piiloansa/neliö/Ansa".play()
func _on_AnimatedSprite_animation_finished():
	if $"../Piiloansa/neliö/Ansa" .current_animation == "Ansa":
		$"../Piiloansa/neliö/Ansa".frame = 10
