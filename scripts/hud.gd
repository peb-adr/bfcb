extends Node2D

export(Vector2) var control = Vector2.ZERO
export(Vector2) var momentum = Vector2.ZERO
export(String) var state = "none"
export(bool) var bowling_is = false
export(float) var bowling_speed = 0.0


func _process(delta):
#	print("c: " + str(control))
#	print("m: " + str(momentum))
#	print("================")
	$PanelControl/Line.set_point_position(1, control)
	
	$PanelMomentum/Line.set_point_position(1, momentum)
	
	$PanelState/Label.text = state
	
	$PanelBowl/LabelIs.text = str(bowling_is)
	$PanelBowl/LabelSpeed.text = str(bowling_speed)
