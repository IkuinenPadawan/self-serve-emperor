extends KinematicBody2D

export var score: = 100
onready var ai = $AI

func _ready() -> void:
	ai.initialize(self)

func _on_PlayerDetector_body_entered(body):
	if(body.get_name() == "Player"):
		PlayerData.score -= score
		$Talk.play()
