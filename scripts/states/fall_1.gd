extends State

const Algebra = preload("res://scripts/algebra.gd")

func _enter():
	._enter()
	
#	parent.anim.stop(false)
#	parent.anim.play("fall_1")

func _update(delta: float):
	._update(delta)
	
#	if parent.anim.current_animation == "jump02_apex" or \
#			parent.anim.current_animation == "jump02_start":
	if fsm.previous_state.name == "jump_1":
		parent.anim.queue("jump02_fall_cyc")
	else:
		parent.anim.play("jump02_fall_cyc")
	
	parent.momentum.y = Algebra.gravity_next_y_momentum(parent.momentum.y)

func _exit():
	._exit()

func _next():
	if parent.e_grounded_just:
		return fsm.get_node("grounded")
	elif parent.i_jump_just:
		return fsm.get_node("jump_2")
	elif parent.i_attack_just:
		return fsm.get_node("attack")
	elif parent.i_special_just:
		return fsm.get_node("slam")
	else:
		return self
