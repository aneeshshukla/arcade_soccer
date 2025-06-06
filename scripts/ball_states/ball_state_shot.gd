class_name BallStateShot
extends BallState

const DURATION_SHOT := 1000
const SHOT_SPRITE_SCALE := 0.8
const SHOT_HEIGHT = 5.0

var time_since_shot := Time.get_ticks_msec()

func _enter_tree() -> void:
	ball.animation_player.speed_scale = 1 if ball.velocity.x >= 0 else -1
	ball.animation_player.play('roll')
	sprite.scale.y = SHOT_SPRITE_SCALE
	ball.height = SHOT_HEIGHT
	time_since_shot = Time.get_ticks_msec()

func _process(delta: float) -> void:
	if Time.get_ticks_msec() - time_since_shot > DURATION_SHOT:
		state_tansition_requested.emit(Ball.State.FREEFORM)
	else:
		ball.move_and_collide(ball.velocity * delta)

func _exit_tree() -> void:
	sprite.scale.y = 1
	ball.height = 0.0
