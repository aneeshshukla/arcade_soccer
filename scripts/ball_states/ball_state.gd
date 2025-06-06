class_name BallState
extends Node

const GRAVITY := 5.0

signal  state_tansition_requested(new_state: Ball.State)

var ball : Ball = null
var carrier : Player = null
var player_detection_area : Area2D = null
var animation_player : AnimationPlayer = null
var sprite : Sprite2D = null

func setup(context_ball: Ball, context_player_detection_area: Area2D, context_carrier: Player, context_animation_player: AnimationPlayer, context_sprite: Sprite2D) -> void:
	ball = context_ball
	player_detection_area = context_player_detection_area
	carrier = context_carrier
	animation_player = context_animation_player
	sprite = context_sprite

func set_ball_animation_from_velocity() -> void:
	if ball.velocity == Vector2.ZERO:
		animation_player.pause()
	else:
		ball.animation_player.speed_scale = 1 if ball.velocity.x >= 0 else -1
		animation_player.play('roll')

func process_gravity(delta : float, bounciness: float = 0.0) -> void:
	if ball.height > 0 or ball.height_velocity > 0:
		ball.height_velocity -= GRAVITY * delta
		ball.height += ball.height_velocity
		if ball.height < 0:
			ball.height = 0
			if bounciness > 0 and ball.height_velocity < 0:
				ball.height_velocity *= -bounciness
				ball.velocity *= bounciness
