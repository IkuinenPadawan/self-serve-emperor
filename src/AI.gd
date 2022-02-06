extends Node2D

signal state_changed(new_state)

enum State {
	ROAM,
	PESTER
}

onready var player_detection_zone = $PlayerDetectionZone
onready var roam_timer = $RoamTimer

var current_state: int = -1 setget set_state
var player = null
var actor = null

# ROAM STATE
var origin: Vector2 = Vector2.ZERO
var roam_location: Vector2 = Vector2.ZERO
var roam_location_reached := false
var actor_velocity := Vector2.ZERO

func _ready() -> void:
	set_state(State.ROAM)

func _physics_process(delta: float) -> void:
	match current_state:
		State.ROAM:
			if not roam_location_reached:
				actor.move_and_slide(actor_velocity)
				actor.rotation = lerp(actor.rotation, actor.global_position.direction_to(roam_location).angle(), 0.1)
				if actor.global_position.distance_to(roam_location) < 5:
					roam_location_reached = true
					actor_velocity = Vector2.ZERO
					roam_timer.start()
		State.PESTER:
			pass

func set_state(new_state: int):
	if new_state == current_state:
		return
		
	if new_state == State.ROAM:
		origin = global_position
		roam_timer.start()
		roam_location_reached = true
		
	current_state = new_state
	emit_signal("state_changed", current_state)


func _on_PlayerDetectionZone_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		set_state(State.PESTER)
		player = body


func _on_PlayerDetectionZone_body_exited(body: Node) -> void:
	if player and body == player:
		set_state(State.ROAM)
		player = null


func _on_RoamTimer_timeout() -> void:
	var roam_range = 500
	var random_x = rand_range(-roam_range, roam_range)
	var random_y = rand_range(-roam_range, roam_range)
	roam_location = Vector2(random_x, random_y) + origin
	roam_location_reached = false
	actor_velocity = actor.global_position.direction_to(roam_location) * 100
	
func initialize(actor: KinematicBody2D):
	self.actor = actor
