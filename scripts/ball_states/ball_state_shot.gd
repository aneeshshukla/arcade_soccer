class_name BallStateShot
extends BallState

const DURATION_SHOT := 1000
const SHOT_SPRITE_SCALE := 0.8
#const SHOT_HEIGHT = 1.0

var time_since_shot := Time.get_ticks_msec()

func _enter_tree() -> void:
	set_ball_animation_from_velocity()
	sprite.scale.y = SHOT_SPRITE_SCALE
	#ball.height = SHOT_HEIGHT
	ball.height_velocity = 2
	time_since_shot = Time.get_ticks_msec()
	

func _process(delta: float) -> void:
	process_gravity(delta, 0.8)
	if Time.get_ticks_msec() - time_since_shot > DURATION_SHOT:
		state_tansition_requested.emit(Ball.State.FREEFORM)
	else:
		ball.move_and_collide(ball.velocity * delta)

func _exit_tree() -> void:
	sprite.scale.y = 1
	#ball.height = 0.0
