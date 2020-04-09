# Collection of concrete algebraic functions

static func gravity_next_y_momentum(value: float) -> float:
	return max(-15.0, value - 0.5)

# Calculates y momentum when jumping (usable range: 0 <= frame <= 15)
static func jump_y_momentum(frame: int) -> float:
	if frame < 0:
		return NAN
	
	if frame < 5:
		return -0.0834854035 * frame + 5.7101538283
	else:
		return -0.01738549 * pow(frame, 2) + 0.07274388 * frame + 5.36394763

static func attack_next_y_momentum(value: float) -> float:
	return value * 0.7654321

# Calculates control dampening when beginning to slam (usable range: 0 <= frame <= 8)
static func slam_control_damp(frame: int) -> float:
	if frame > 8:
		return 0.0
	return 1.0
	return 1 - frame * 0.125

# Calculates the relative weight of value in range [l, u].
# 0 <= return <= 1
static func value_weight_in_range(value: float, l: float, u: float):
	if value < l or value > u:
		return -1.0
	
	return (value - l) / (u - l)

# Calculates a value weighted in range [l, u]
# 0 <= weight <= 1
static func weigh_value_in_range(weight: float, l: float, u: float):
	if weight < 0 or weight > 1:
		return
	
	return weight * (u - l) + l






