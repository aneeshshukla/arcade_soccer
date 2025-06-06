class_name BallStateCarried
extends BallState

const OFFSET_FROM_PLAYER := Vector2(10,4)
const DRIBBLE_FREAQUENCY := 10.0
const DRIBBLE_INTENSITY := 2.5

var dribble_time := 0.0

func _enter_tree() -> void:
	assert(carrier != null)

func _process(delta: float) -> void:
	var vx := 0.0
	dribble_time += delta
	if carrier.velocity != Vector2.ZERO:
		if carrier.velocity.x != 0.0:
			vx = cos(dribble_time * DRIBBLE_FREAQUENCY) * DRIBBLE_INTENSITY
		else:
			vx = 0.0
		ball.animation_player.speed_scale = carrier.heading.x
		ball.animation_player.play('roll')
	else:
		ball.animation_player.pause()
	process_gravity(delta,0.2)
	ball.position = carrier.position + Vector2(vx + carrier.heading.x * OFFSET_FROM_PLAYER.x, OFFSET_FROM_PLAYER.y)
