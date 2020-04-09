extends State

const Algebra = preload("res://scripts/algebra.gd")

func _enter():
	._enter()
	
#	parent.anim.stop(false)
#	parent.anim.play("jump_1")
	parent.anim.play("jump02_start", -1, 2)
	parent.anim.queue("jump02_apex")

func _update(delta: float):
	._update(delta)
	
	parent.momentum.y = Algebra.jump_y_momentum(frame)

func _exit():
	._exit()

func _next():
	if parent.e_grounded_just:
		return fsm.get_node("grounded")
	elif frame < 5 and not parent.i_jump:
		return fsm.get_node("fall_1")
	elif frame == 14:
		return fsm.get_node("fall_1")
	elif parent.i_jump_just:
		return fsm.get_node("jump_2")
	elif parent.i_attack_just:
		return fsm.get_node("attack")
	elif parent.i_special_just:
		return fsm.get_node("slam")
	else:
		return self