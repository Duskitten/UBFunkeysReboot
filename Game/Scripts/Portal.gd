extends StaticBody2D

export var ToPortal = ""
export var ToWorld = 0

var worlds = ["Funkeystown","KelpyBasin","MagmaGorge","LuputtaStation","FunkikiIsland","SpeedTrack","NightmareRift","DayDreamOasis","ParadoxGreen"]


func _ready():
	ToPortal = get_parent().name
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_body_entered(body):
	if body.Player:
		if body.HasWorlds.has(worlds[ToWorld]):
			get_node("/root/Container/World").add_child(load("res://Scenes/"+worlds[ToWorld]+".tscn").instance())
			get_node("/root/Container/World/"+ToPortal).queue_free()
		print("Player Worlds : ",body.HasWorlds,", To World : ",worlds[ToWorld],", From World : ",ToPortal)
