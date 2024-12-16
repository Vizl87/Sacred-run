extends Area2D

@export var cassandra: CharacterBody2D 
 



@export var ansa: AnimatedSprite2D
@onready var dumdum = $dumdum




func _ready() -> void:
	ansa.connect("animation_finished", Callable(self, "_on_AnimatedSprite_animation_finished"))
	
# Called when the node enters the scene tree for the first time.
func _on_spike_entered(area: Area2D) -> void:
	ansa.show()
	dumdum.hide()
	if area.name == "cassandra":
		ansa.play("spike")
		cassandra.currenthealth -= 1
		
func _on_AnimatedSprite_animation_finished():
	ansa.frame = 10
	ansa.stop()
	ansa.hide()
	dumdum.show()
