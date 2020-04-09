extends State

const Algebra = preload("res://scripts/algebra.gd")

func _enter():
	._enter()
	
#	parent.anim.stop(false)
#	parent.anim.play("fall_2")
	if fsm.previous_state.name == "attack":
		parent.anim.play("jump02_fall_cyc")
	else:
		parent.anim.queue("Djump01_lift_cyc")

func _update(delta: float):
	._update(delta)
	
	parent.momentum.y = Algebra.gravity_next_y_momentum(parent.momentum.y)

func _exit():
	._exit()

func _next():
	if parent.e_grounded_just:
		return fsm.get_node("grounded")
	elif parent.i_attack_just:
		return fsm.get_node("attack")
	elif parent.i_special_just:
		return fsm.get_node("slam")
	else:
		return self