extends Control

export var control_rect = Vector2(540,540)
var currentrect = Vector2(540,540)
var aspect = [540,800,800]
var windowrect = [1,2,3,4]
var rct = Vector2(1,1)
var rctold = Vector2(1,1)

###Rewrite
var Aspect = [Vector2(4,3),Vector2(16,9),Vector2(16,10)]
var WindowHeight = 0
var windows = 0
var aspectnum = 0

func _ready():
	set_process_input(true)
	#if OS.get_name() == "HTML5":
		#OS.set_window_maximized(true)
	set_process(true)
	update()
	if get_parent().has_node("Viewport/CanvasLayer/Dialogue"):
		get_parent().get_node("Viewport/CanvasLayer/Dialogue").rect_position = Vector2(control_rect.x/2, control_rect.y-56)
		
	
func _draw():
	WindowHeight = 600
	"""if WindowHeight >= 1000:
		get_node("/root/Container/Viewport/scaler").set_scale(Vector2(2,2))
	elif WindowHeight >= 700:
		get_node("/root/Container/Viewport/scaler").set_scale(Vector2(1.5,1.5))
	else:
		get_node("/root/Container/Viewport/scaler").set_scale(Vector2(1,1))"""
	windows = (WindowHeight*Aspect[aspectnum].x)/Aspect[aspectnum].y
	get_parent().get_node("Viewport").size = Vector2(windows,WindowHeight)
	var p1_tex = get_parent().get_node("Viewport").get_texture()
	draw_texture_rect(p1_tex, Rect2(Vector2(0,0),Vector2(Vector2(windows,-WindowHeight))), false);
	self.rect_min_size = Vector2(windows,-WindowHeight)
	get_parent().get_node("CanvasLayer/Control").rect_position = self.rect_position
	get_parent().get_node("Viewport").set_global_canvas_transform(Transform2D(Vector2(1,0),Vector2(0,1),-self.rect_position))
	
	
func _process(delta):
	update()
	get_parent().get_node("Panel").rect_size = OS.window_size
	"""
	var aspectbar = get_parent().get_node("CanvasLayer/Control/Panel/VSlider").value
	var scalebar = get_parent().get_node("CanvasLayer/Control/Panel2/VSlider2").value
	rct = Vector2(windowrect[scalebar],windowrect[scalebar])
	control_rect = Vector2(aspect[aspectbar],600)
	if currentrect != control_rect or rctold != rct:
		if OS.window_size.y > control_rect.y*rct.y && OS.window_size.x > control_rect.x*rct.x:
			update()
			rctold = rct
			print("Changing!")
		elif OS.window_size.y <= control_rect.y*rct.y && OS.window_size.x <= control_rect.x*rct.x:
			get_parent().get_node("CanvasLayer/Control/Panel2/VSlider2").value = 0
			get_parent().get_node("CanvasLayer/Control/Panel/VSlider").value = 0
	if get_parent().has_node("Viewport/CanvasLayer/Dialogue"):
		get_parent().get_node("Viewport/CanvasLayer/Dialogue").rect_position = Vector2(control_rect.x/2, control_rect.y-56)
	
	if OS.window_size >= currentrect*rct or rctold != rct:
		if OS.window_size.y >= control_rect.y*rct.y && OS.window_size.x >= control_rect.x*rct.x:
			self.rect_scale = rctold
			self.rect_min_size = currentrect/2*rctold
			print("Changing!")
	self.rect_position = OS.window_size/2 - currentrect*rctold/2
	"""
	self.rect_position = OS.window_size/2 - Vector2(windows,WindowHeight)/2
	get_parent().get_node("CanvasLayer/Control").rect_position = self.rect_position
	
func _input(event):
	get_parent().get_node("Viewport").input(event)

#(Height*AspectW)/AspectH
	
	