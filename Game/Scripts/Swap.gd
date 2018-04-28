extends Button

var A = false
export var Num = "00000000"
func _ready():
	set_process(true)

func _process(delta):
	if self.is_pressed() && !A:
		get_node("/root/Container/Player")._swapFunkey(Num)
		A = true
	if !self.is_pressed() && A:
		A = false
	