extends Object
class_name Const

# Speed values for characte. First value is minimum speed character can move,
# any less than that and character turns in place. First to second is the
# walking (sneaking) range, second to third is running range.
const SB_MOVE_SPEED = [0.6, 4.0, 5.0]

# These 3 numbers are the corresponding stick deflections for the speeds.
const SB_MOVE_SPEED_STICK_MAP = [0.1, 0.8, 1.0]

const SB_TURN_SPEED = 5.0
const SB_BBOWL_TURN_SPEED = 0.25

# Down velocity when grounded to see if SB is still grounded / can start falling
const SB_GROUNDED_FORCE_SOFT = -5
const SB_GROUNDED_FORCE_HARD = -0.0

const SB_GROUNDED_OVER_EDGE = 0.3

# Down velocity during bubble bounce
const SB_BBOUNCE_SPEED = 15

# Bubble Bash parameters:
#   Time is time to peak height (from launch), Delay is time before launch happens,
#   CVTime is duration of constant-velocity period, before gravity sets in.
#	As far as the animation goes, the transition to "Attack" animation
#	occurs as soon as "Start" animation finishes.  transition to "Strike"
#	occurs when contact is detected, otherwise transitions to normal fall when
#	peak height is reached.
const SB_BBASH_DELAY = 0.25
const SB_BBASH_CV_TIME = 0.215
const SB_BBASH_TIME = 0.315
const SB_BBASH_SPEED = 10.9523811
#const SB_BBASH_HEIGHT = 3.3


const CAMERA_TURN_SPEED = 2.5
