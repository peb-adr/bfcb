extends Node
class_name State

onready var fsm = get_parent()
#onready var parent: Node = get_parent().get_parent()
onready var parent: Spongebob = get_parent().get_parent()

var frame = INF
var t = INF

func _enter():
	frame = -1
	t = -1
	pass

func _update(delta: float):
	frame += 1
	t += delta
	if frame == 0:
		t = 0
	pass

func _exit():
	frame = INF
	t = INF
	pass

func _next() -> State:
	return self