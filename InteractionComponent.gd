extends Area2D

export var interaction_parent : NodePath

signal on_interactable_changed(newInteractable)

var interaction_target : Node

func _process(delta):
	# Check whether the player is trying to interact
	if (interaction_target != null and Input.is_action_just_pressed("interact")):
		# If so, we'll call interaction_interact() if our target supports it
		if (interaction_target.has_method("interaction_interact")):
			interaction_target.interaction_interact(self)

func _on_InteractionComponent_body_entered(body):
	var canInteract := false
	
	if (body.has_method("interaction_can_interact")):
		# Interactables tell us whether we are allowed to interact with them
		canInteract = body.interaction_can_interact(get_node(interaction_parent))
		
	if not canInteract:
		return
		
	# Store the thing we'll be interacting with, so we can trigger it from _process
	interaction_target = body
	emit_signal("on_interactable_changed", interaction_target)
	
func _on_InteractionComponent_body_exited(body):
	if (body == interaction_target):
		interaction_target = null
		emit_signal("on_interactable_changed", null)
