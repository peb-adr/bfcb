extends Spatial


func _process(delta):
	var v = Vector2($Spongebob.i_control.x, $Spongebob.i_control.z)
	v = (v + Vector2(1, 1)) * 50
	$HUD.control = v
	
	v = Vector2($Spongebob.momentum_force.x, $Spongebob.momentum_force.z)
	v = v.rotated($Spongebob/CameraTarget.rotation.y)
	v = (v + Vector2(5, 5)) * 10
	$HUD.momentum = v
	
	$HUD.state = $Spongebob/FiniteStateMachine.current_state.name
	
	$HUD.bowling_is = $Spongebob.is_bowling
	$HUD.bowling_speed = $Spongebob.bowling_velocity
