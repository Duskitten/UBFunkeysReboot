extends KinematicBody2D

export var Player = false
export var clickPath = false
export var funkeyPath = ""
export var CanBeKey = ""
export var HasWorlds = []
var Test = 0
var V1 = []
var FinalString = ""
var dict = {}
var loadedAsset = null
var anim_new = ""
var Anim = "D"
var MovementType = "Idle_"
var NewFunk
var NewTexture = ""
var speed = 100
var Idleswap = false
var Swapping = false
onready var Animplayer = $Player
onready var Whtplayer = $WhiteScreenPlayer

func _ready():
	
	set_physics_process(true)
	set_process(true)
	var file = File.new()
	file.open("res://Data/FunkeyCatalog.json", file.READ)
	dict = parse_json(file.get_as_text())
	file.close()
##Set Up random Generation of FunkeyTypes Using Max Type
	if Player:
		print($New.get_texture())
		_swapFunkey("00000004")
		$Button.hide()
		$NinePatchRect.hide()
	elif !Player:
# print something from the dictionnary for testing.
		print(dict.keys()[dict.size()-1])
		var MaxSize = dict.keys()[dict.size()-1]
		
		randomize()
		V1 = [randi() % 15,randi() % 15,randi() % 15,randi() % 15,randi() % 15,randi() % 15,randi() % 15,randi() % 15]
		for i in V1.size():
			var ChangedNumber = 0
			if MaxSize[i] == "A":
				ChangedNumber = 10
			elif MaxSize[i] == "B":
				ChangedNumber = 11
			elif MaxSize[i] == "C":
				ChangedNumber = 12
			elif MaxSize[i] == "D":
				ChangedNumber = 13
			elif MaxSize[i] == "E":
				ChangedNumber = 14
			elif MaxSize[i] == "F":
				ChangedNumber = 15
			else: 
				ChangedNumber = MaxSize[i].to_int()
			if V1[i] >= ChangedNumber:
				V1[i] = ChangedNumber
			print(V1[i])
			if V1[i] == 10:
				V1[i] = "A"
			elif V1[i] == 11:
				V1[i] = "B"
			elif V1[i] == 12:
				V1[i] = "C"
			elif V1[i] == 13:
				V1[i] = "D"
			elif V1[i] == 14:
				V1[i] = "E"
			elif V1[i] == 15:
				V1[i] = "F"
			
		FinalString = PoolStringArray(V1).join("")
		var NewFunk = File.new()
		var fnk = "res://Sprites/Funkeys/"+dict[FinalString]["Url"]+".png"
		
		if NewFunk.file_exists(fnk):
			loadedAsset = load(fnk)
			$Original.set_texture(loadedAsset)
		elif !NewFunk.file_exists(fnk):
			print("She Dont exist Mang")
	
		print(dict[FinalString]["Url"])

func _physics_process(delta):
	var movement = Vector2(0,0)
	
	if Player:
		if !clickPath:
			if Input.is_action_pressed("ui_up"):
				movement.y -= 1
			if Input.is_action_pressed("ui_down"):
				movement.y += 1
				
			if Input.is_action_pressed("ui_left"):
				movement.x -= 1
			if Input.is_action_pressed("ui_right"):
				movement.x += 1
			
			if Input.is_action_pressed("ui_select"):
				Animplayer.set_speed_scale(3)
				if Player:
					Whtplayer.set_speed_scale(3)
				if !movement == Vector2(0,0):
					speed = 150
					MovementType = "Walk_"
					Idleswap = false
					$IdleTimer/AnimTimer.stop()
				else:
					if !Idleswap:
						MovementType = "Idle_"
						$IdleTimer.start()
						Idleswap = true
			elif !Input.is_action_pressed("ui_select"):
				Animplayer.set_speed_scale(2)
				if Player:
					Whtplayer.set_speed_scale(2)
				if !movement == Vector2(0,0):
					speed = 50
					MovementType = "Walk_"
					Idleswap = false
					$IdleTimer/AnimTimer.stop()
				else:
					if !Idleswap:
						MovementType = "Idle_"
						$IdleTimer.start()
						Idleswap = true
					
	if !Idleswap:
		if movement == Vector2(0,1):
			Anim = "D"
		elif movement == Vector2(1,0):
			Anim = "R"
		elif movement == Vector2(1,1):
			Anim = "DR"
		elif movement == Vector2(-1,1):
			Anim = "DL"
		elif movement == Vector2(0,-1):
			Anim = "U"
		elif movement == Vector2(-1,0):
			Anim = "L"
		elif movement == Vector2(-1,-1):
			Anim = "UL"
		elif movement == Vector2(1,-1):
			Anim = "UR"
			
	if MovementType+Anim != "Idle_B" or MovementType+Anim != "Idle1" or MovementType+Anim != "Idle2" or MovementType+Anim != "Idle3":  
		if anim_new != MovementType+Anim:
			anim_new = MovementType+Anim
			Animplayer.play(MovementType+Anim)
			if Player:
				Whtplayer.play(MovementType+Anim)
		
	self.move_and_slide(movement*speed)


func _process(delta):
	self.z_index = self.position.y-20


func _swapFunkey(FunkeyID):
	var file = File.new()
	print("res://Sprites/Funkeys/"+dict[FunkeyID]["Url"]+".png")
	if !Swapping:
		Swapping = true
		var fnk = "res://Sprites/Funkeys/"+dict[FunkeyID]["Url"]+".png"
		HasWorlds = dict[FunkeyID]["Destinations"]
		NewTexture = fnk
		$New.set_texture(load(NewTexture))
		$Swap.play("Swap")



func _on_Swap_animation_finished(anim_name):
	if Player:
		if anim_name == "Swap":
			$Original.set_texture(load(NewTexture))
			$Swap.play("Reset")
			Swapping = false
		

func _on_IdleTimer_timeout():
	$IdleTimer.stop()
	if Idleswap:
		if !MovementType+Anim == "Idle_B":
			if $IdleTimer/SpinTimer.is_stopped():
				$IdleTimer/SpinTimer.start()
			
			


func _on_SpinTimer_timeout():
	if !MovementType+Anim == "Idle_B":
		if Anim == "U":
			Anim = "UL"
		elif Anim == "UL":
			Anim = "L"
		elif Anim == "L":
			Anim = "DL"
		elif Anim == "DL":
			Anim = "D" 
		elif Anim == "D":
			Anim = "B"
			$IdleTimer/SpinTimer.stop()
			$IdleTimer/AnimTimer.start()
		elif Anim == "UR":
			Anim = "R"
		elif Anim == "R":
			Anim = "DR"
		elif Anim == "DR":
			Anim = "D"
				
		print("End OF Cycle")


func _on_AnimTimer_timeout():
	randomize()
	var IdleNum = randi() % 3+1
	MovementType = "Idle"
	Anim = String(IdleNum)
	print(MovementType+Anim)
	Animplayer.play(MovementType+Anim)
	if Player:
		Whtplayer.play(MovementType+Anim)
