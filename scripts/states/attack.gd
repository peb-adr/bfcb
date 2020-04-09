extends State

const Algebra = preload("res://scripts/algebra.gd")

func _enter():
	._enter()
	
	parent.lock_look_angle = true
	parent.mesh_bubble_wand.visible = true
	
#	parent.anim.play("attack")
	parent.anim.play("bubble_spin01", 0)

func _update(delta: float):
	._update(delta)
	
	if frame == 2:
		parent.mesh_bubble_wand.visible = true
	if frame == 24:
		parent.mesh_bubble_wand.visible = false
	if frame > 2 and frame < 24:
		parent.momentum.y = Algebra.attack_next_y_momentum(parent.momentum.y)

func _exit():
	._exit()
	
	parent.lock_look_angle = false
	parent.mesh_bubble_wand.visible = false

func _next():
	if frame == 24:
		if fsm.previous_state.name == "jump_1" \
				or fsm.previous_state.name == "fall_1":
			return fsm.get_node("fall_1")
		elif fsm.previous_state.name == "jump_2" \
				or fsm.previous_state.name == "fall_2":
			return fsm.get_node("fall_2")
		else:
			return fsm.get_node("grounded")
	else:
		return self