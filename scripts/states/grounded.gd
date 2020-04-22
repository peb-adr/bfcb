extends State

var over_edge = 0.0

func _enter():
	._enter()
	
	over_edge = 0.0
	parent.can_damp = true
	
#	parent.anim.stop(false)
#	parent.anim.play("idle01")
	if fsm.previous_state.name == "fall_1":
		if parent.control_force.length() > Const.SB_MOVE_SPEED[1]:
			parent.anim.play("jump_land_run")
		elif parent.control_force.length() <= Const.SB_MOVE_SPEED[0]:
			parent.anim.play("jump02_land")
	if fsm.previous_state.name == "fall_2":
		if parent.control_force.length() > Const.SB_MOVE_SPEED[1]:
			parent.anim.play("jump_land_run")
		elif parent.control_force.length() <= Const.SB_MOVE_SPEED[0]:
			parent.anim.play("Djump01_land", -1, 2)

func _update(delta: float):
	._update(delta)
	
	var g = parent.e_grounded
	if g:
		over_edge = 0.0
	else:
		over_edge += delta
	
#	if parent.velocity != Vector3.ZERO:
#		parent.anim.play("run04")
	if parent.control_force.length() > Const.SB_MOVE_SPEED[1]:
		if parent.anim.current_animation != "jump_land_run":
#			if parent.diff_angle > 0.1:
#				parent.anim.play("run04_left")
#			if parent.diff_angle < -0.1:
#				parent.anim.play("run04_right")
#			else:
#				parent.anim.play("run04")
			parent.anim.play("run04")
	elif parent.control_force.length() > Const.SB_MOVE_SPEED[0]:
		parent.anim.play("sneak01", -1, parent.control_force.length())
	else:
		if parent.anim.current_animation != "jump02_land" and \
				parent.anim.current_animation != "Djump01_land":
			parent.anim.play("idle01", -1, 0.5)
	parent.momentum.y = 0

func _exit():
	._exit()

func _next():
	if parent.i_jump_just:
		return fsm.get_node("jump_1")
	elif parent.i_attack_just:
		return fsm.get_node("attack")
	elif parent.i_bash_just:
		return fsm.get_node("bash")
#	elif not parent.e_grounded:
#		return fsm.get_node("fall_1")
	elif over_edge > Const.SB_GROUNDED_OVER_EDGE:
		return fsm.get_node("fall_1")
	elif parent.i_special_just:
		parent.bubble_bowl()
		return self
	else:
		return self
