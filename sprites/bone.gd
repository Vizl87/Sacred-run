# Coin.gd
extends Area2D


var collectible = 0



# Signal to notify when this collectible is picked up
signal collected

#func _ready():

	# Connect to the body_entered signal to detect when the player collides with this collectible
func _on_body_entered(body: Node2D) -> void:
	if body.name == "cassandra":
		emit_signal("collected")
		collectible += 1
		$"../AnimatedSprite2D".hide()
		print(collectible)
	# Check if the body that collided with the collectible is the player
	  # Make sure the Player node has the name "Player"
		# Emit the 'collected' signal to inform other scripts (e.g., the player or HUD) of the collection
		

		
		queue_free()  #
	  # Ensure it's visible
