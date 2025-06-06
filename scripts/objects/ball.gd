class_name Ball
extends AnimatableBody2D

enum State {CARRIED, FREEFORM, SHOT}

@onready var player_detection_area: Area2D = $PlayerDetectionArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ball_sprite: Sprite2D = %BallSprite

@export var FRICTION_AIR : float = 35.0
@export var FRICTION_GROUND : float = 250.0

var carrier : Player = null
var current_state : BallState = null
var state_factory = BallStateFactory.new()
var velocity := Vector2.ZERO
var height : float = 0.0
var height_velocity := 0.0

func _ready() -> void:
	switch_state(State.FREEFORM)

func  _process(_delta: float) -> void:
	ball_sprite.position = Vector2.UP * height

func switch_state(state: Ball.State) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, player_detection_area, carrier, animation_player, ball_sprite)
	current_state.state_tansition_requested.connect(switch_state.bind())
	current_state.name = 'BallStateMachine'
	call_deferred("add_child", current_state)
	

func shoot(shot_velocity : Vector2) -> void:
	velocity = shot_velocity
	carrier = null
	switch_state(Ball.State.SHOT)

func pass_to(destination: Vector2, h_velocity = .8) -> void:
	height_velocity = h_velocity
	var direction := position.direction_to(destination)
	var distance := position.distance_to(destination)
	var intensity = sqrt(distance*FRICTION_GROUND + (distance**2)+FRICTION_GROUND/1.6 + 0.4*(FRICTION_GROUND**2)*distance)/10
	print(intensity)
	velocity = intensity * direction
	carrier = null
	switch_state(Ball.State.FREEFORM)
