extends RigidBody2D

export var score: = 100

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return true

func interaction_interact(interactionComponentParent : Node) -> void:
	PlayerData.score += score 
	queue_free()
