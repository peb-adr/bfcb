# Collection of utiliy functions

# returns a radian rotation in normalized form (i.e. -PI < value <= PI)
static func normalize_rotation(value: float) -> float:
	while value <= -PI:
		value += 2 * PI
	while value > PI:
		value -= 2 * PI
	return value