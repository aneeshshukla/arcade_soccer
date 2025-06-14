class_name PlayerStateFactory

var states : Dictionary

func _init() -> void:
	states = {
		Player.State.MOVING: PlayerStateMoving,
		Player.State.TACKLING: PlayerStateTackling,
		Player.State.RECOVERING: PlayerStateRecovering,
		Player.State.PREPPING_SHOT: PlayerStatePreppingShot,
		Player.State.SHOOTING: PlayerStateShooting,
		Player.State.PASSING: PlayerStatePassing
	}

func get_fresh_state(state: Player.State) -> PlayerState:
	assert(states.has(state), "state doesn't exist!")
	return states.get(state).new()
	
