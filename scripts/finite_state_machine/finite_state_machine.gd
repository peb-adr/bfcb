extends Node
class_name FiniteStateMachine

export var start_state: NodePath = "default"

# current state
var current_state: State
# previous state
var previous_state: State

func _ready():
	if not has_node(start_state):
		start_state = get_child(0).get_path()
	
	current_state = InitState.new(get_node(start_state))

func _physics_process(delta):	
	var bob = $".."
#	print("%d %f %s %s" % [bob.frame, bob.momentum.y, current_state.name, bob.control_force])
	
	var next_state = current_state._next()
	
	if next_state != current_state:
		previous_state = current_state
		current_state = next_state
		
		previous_state._exit()
		current_state._enter()
	
	current_state._update(delta)

class InitState extends State:
	var to_state: State
	
	func _init(to: State):
		to_state = to
		name = "init"
	
	func _next():
		return to_state