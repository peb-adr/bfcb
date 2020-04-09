extends State

const Algebra = preload("res://scripts/algebra.gd")

var phase = 0
var t_cmp = 0

func _enter():
	._enter()
	
	parent.mesh_bubble_wand.visible = true
	parent.lock_control_force = true
	phase = 0
	t_cmp = Const.SB_BBASH_DELAY

func _update(delta: float):
	._update(delta)
	
	if phase == 0 and t > t_cmp:
		phase = 1
		t_cmp += Const.SB_BBASH_CV_TIME
	if phase == 1 and t > t_cmp:
		phase = 2
#		t_cmp += Const.SB_BBASH_TIME
		t_cmp += 0.6
	
	if phase == 0:
		parent.anim.play("bubble_bash01_start")
		parent.momentum.y = 0
	elif phase == 1:
		parent.anim.play("bubble_bash01_attack_cyc")
		parent.momentum.y = Const.SB_BBASH_SPEED
		parent.mesh_bubble_wand.visible = false
	elif phase == 2:
		parent.anim.play("bubble_bash01_strike")
		parent.momentum.y = Algebra.gravity_next_y_momentum(parent.momentum.y)

func _exit():
	._exit()
	
	parent.lock_control_force = false

func _next():
#	if phase == 2 and frame == 42:
	if phase == 2:
		if parent.i_special_just:
			return fsm.get_node("slam") 
		elif t > t_cmp:
			return fsm.get_node("fall_1")
	return self