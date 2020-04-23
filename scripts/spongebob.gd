extends KinematicBody
class_name Spongebob

const Algebra = preload("res://scripts/algebra.gd")
const Util = preload("res://scripts/util.gd")

#onready var anim: AnimationPlayer = $Collision/bob_textured_animated/AnimationPlayer
onready var anim: AnimationPlayer = $Collision/MeshAnimated/AnimationPlayer
onready var mesh: MeshInstance = $Collision/MeshAnimated/Skeleton/Mesh
onready var mesh_bubble_wand: MeshInstance = $Collision/MeshAnimated/Skeleton/MeshBubbleWand

#export var WALK_SPEED = 5.0
#export var TURN_SPEED = 5.0

var frame = 0

# inputs
var i_control = Vector3.ZERO
var i_control_local = Vector3.ZERO
var i_jump: bool = false setget ,get_i_jump
var i_jump_just: bool = false setget ,get_i_jump_just
var i_attack: bool = false setget ,get_i_attack
var i_attack_just: bool = false setget ,get_i_attack_just
var i_special: bool = false setget ,get_i_special
var i_special_just: bool = false setget ,get_i_special_just
var i_bash: bool = false setget ,get_i_bash
var i_bash_just: bool = false setget ,get_i_bash_just

# events
var e_grounded: bool = true setget ,get_e_grounded
var e_grounded_just: bool = true setget ,get_e_grounded_just

# movement
var momentum = Vector3.ZERO
var momentum_force = Vector3.ZERO
var control_force = Vector3.ZERO
var turn_speed = Const.SB_TURN_SPEED
var velocity = Vector3.ZERO
var can_damp = true
var is_bowling = false
var bowling_velocity = 0.0

# angles
var look_angle = 0.0
var control_angle = 0.0
var diff_angle = 0.0
#var tmp = 0

# locks
var lock_look_angle: bool = false
var lock_control_force: bool = false

# DEBUG
var debug_move_speed = 0.0
var debug_y_momentum = 0.0


func _physics_process(delta):
#	print("physics_process: %f" % delta)
#	print("frame %d" % frame)
	frame += 1
	read_input()
	
	
#	if is_bowling:
#		bubble_bowl()
	
	
	# calculate new velocity
	calc_momentum_force()
	calc_control_force()
	velocity = control_force + momentum_force
	
	# calculate new look angle based on control
	calc_look_angle()
	
	# apply physics
	move_and_slide(velocity, Vector3.UP)
	$Collision.rotation.y = look_angle
	
#	print("================")

func read_input():
	# control (left stick)
	var down = Input.get_action_strength("move_backward")
	var up = Input.get_action_strength("move_forward")
	var left = Input.get_action_strength("move_left")
	var right = Input.get_action_strength("move_right")
	i_control.z = down - up
	i_control.x = right - left
	# convert from camera coordinates
	i_control_local = i_control.rotated(Vector3.UP, $CameraTarget.rotation.y)
	# clamp length at 1 (esp. for when using arrow keys)
	if i_control.length() > 1:
		i_control = i_control.normalized()
	if i_control_local.length() > 1:
			i_control_local = i_control_local.normalized()
	
	# speedwalk and moonjump for easy testing
	debug_move_speed = Input.get_action_strength("debug2") * 40
	debug_y_momentum = Input.get_action_strength("debug1") * 10
	
#	print("i_control {v} \t\t length {l}".format({"v": i_control, "l": i_control.length()}))

func calc_momentum_force():
	if is_bowling:
		var v = Vector3.FORWARD.rotated(Vector3.UP, look_angle) * bowling_velocity
		momentum.x = v.x
		momentum.z = v.z
	momentum_force = momentum
	if debug_y_momentum > 0:
		momentum_force.y = debug_y_momentum

func calc_control_force():
#	if lock_control_force:
#		control_force = Vector3.ZERO
#		return
	
	var direction
	var factor
	
	if $FiniteStateMachine.current_state.name == "grounded" and \
			not lock_look_angle and not is_bowling:
		# look direction
		direction = Vector3.FORWARD.rotated(Vector3.UP, look_angle)
	else:
		# control direction
		direction = i_control_local
	direction = direction.normalized()
	
	
	if lock_control_force:
		factor = 0
	else:
		if i_control_local.length() < Const.SB_MOVE_SPEED_STICK_MAP[0]:
			factor = 0
		elif i_control_local.length() < Const.SB_MOVE_SPEED_STICK_MAP[1]:
			var weight = Algebra.value_weight_in_range(
					i_control_local.length(),
					Const.SB_MOVE_SPEED_STICK_MAP[0],
					Const.SB_MOVE_SPEED_STICK_MAP[1])
			factor = Algebra.weigh_value_in_range(
					weight,
					Const.SB_MOVE_SPEED[0],
					Const.SB_MOVE_SPEED[1])
		else:
			var weight = Algebra.value_weight_in_range(
					min(i_control_local.length(), 1),
					Const.SB_MOVE_SPEED_STICK_MAP[1],
					Const.SB_MOVE_SPEED_STICK_MAP[2])
			factor = Algebra.weigh_value_in_range(
					weight,
					Const.SB_MOVE_SPEED[1],
					Const.SB_MOVE_SPEED[2])
	
	factor += debug_move_speed
	control_force = factor * direction

func calc_look_angle():
	if lock_look_angle:
		return
	if i_control_local == Vector3.ZERO:
		return
	
	control_angle = acos(-i_control_local.normalized().z)
	if i_control_local.x > 0.0:
		control_angle *= (-1)
	
	diff_angle = control_angle - look_angle
	diff_angle = Util.normalize_rotation(diff_angle)
	diff_angle = clamp(diff_angle, -turn_speed, turn_speed)
	diff_angle *= 0.15
	
	# 0.1 * (3.141592653589793 - f(n-1)) + f(n-1)
	
	look_angle = Util.normalize_rotation(look_angle + diff_angle)
#	print("%d %f" % [tmp, look_angle])
#	tmp += 1

func bubble_bowl():
	print(is_bowling)
	if not is_bowling:
		is_bowling = true
		turn_speed = Const.SB_BBOWL_TURN_SPEED
#		lock_control_force = true
		bowling_velocity = max(velocity.length(), Const.SB_MOVE_SPEED[0])
	else:
#		bowling_velocity *= 0.95
#		if bowling_velocity < 0.01:
#			is_bowling = false
#			turn_speed = Const.SB_TURN_SPEED
#			lock_control_force = false
		is_bowling = false
		turn_speed = Const.SB_TURN_SPEED
		momentum.x = 0
		momentum.z = 0

func get_i_jump() -> bool:
	i_jump = Input.is_action_pressed("jump")
	return i_jump

func get_i_jump_just() -> bool:
	i_jump_just = Input.is_action_just_pressed("jump")
	return i_jump_just

func get_i_attack() -> bool:
	i_attack = Input.is_action_pressed("attack")
	return i_attack

func get_i_attack_just() -> bool:
	i_attack_just = Input.is_action_just_pressed("attack")
	return i_attack_just

func get_i_special() -> bool:
	i_special = Input.is_action_pressed("special")
	return i_special

func get_i_special_just() -> bool:
	i_special_just = Input.is_action_just_pressed("special")
	return i_special_just

func get_i_bash() -> bool:
	i_bash = Input.is_action_pressed("bash")
	return i_bash

func get_i_bash_just() -> bool:
	i_bash_just = Input.is_action_just_pressed("bash")
	return i_bash_just

func get_e_grounded() -> bool:
#	print("%f | %s" % [frame, value])
	move_and_slide(Vector3(0.0, Const.SB_GROUNDED_FORCE_SOFT, 0.0), Vector3.UP, true)
#	move_and_collide(Vector3(0.0, Const.SB_GROUNDED_FORCE_HARD, 0.0))
	e_grounded = is_on_floor()
#	return 
#	print(e_grounded)
	return e_grounded

func get_e_grounded_just() -> bool:
	e_grounded_just = is_on_floor()
	return e_grounded_just
















