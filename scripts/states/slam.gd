extends State

const Algebra = preload("res://scripts/algebra.gd")

var phase = 0

func _enter():
	._enter()
	
	parent.mesh_bubble_wand.visible = true
	phase = 0

func _update(delta: float):
	._update(delta)
	
	if phase == 0 and frame == 44:
		phase = 1
	if phase == 1 and parent.e_grounded_just:
		phase = 2
		frame = 0
	
	if phase == 0:
		parent.anim.play("bubble_bounce01_start")
		parent.momentum.y = 0
		if frame == 8:
			parent.lock_control_force = true
	elif phase == 1:
		parent.anim.play("bubble_bounce01_attack_cyc")
		parent.momentum.y = -Const.SB_BBOUNCE_SPEED
	elif phase == 2:
		parent.anim.play("bubble_bounce01_strike")
		parent.momentum.y = 0

func _exit():
	._exit()
	
	parent.mesh_bubble_wand.visible = false
	parent.lock_control_force = false

func _next():
	if phase == 2 and frame == 42:
		return fsm.get_node("grounded")
	else:
		return self