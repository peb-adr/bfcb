extends Spatial

export var TURN_SPEED = 5

var i_control = Vector3.ZERO

func _process(delta):
	read_input()
	
	if i_control == Vector3.ZERO:
		return
	rotation.y += i_control.x * TURN_SPEED * delta
#	var new_angle = camera_angle + i_control_camera.x * CAMERA_TURN_SPEED
#	camera_angle = lerp(camera_angle, new_angle, 0.1)


func read_input():
	# control camera (right stick)
	var down = Input.get_action_strength("camera_down")
	var up = Input.get_action_strength("camera_up")
	var left = Input.get_action_strength("camera_left")
	var right = Input.get_action_strength("camera_right")
#	print("u=%f d=%f r=%f l=%f" % [up, down, right, left])
	i_control.y = up - down
	i_control.x = right - left
#	print("x=%f y=%f" % [i_control.x, i_control.y])
#	i_control = i_control.normalized()