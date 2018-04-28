extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dict = {}

func _ready():
 var file = File.new()
 file.open("res://Data/FunkeyCatalog.json", file.READ)
 dict = parse_json(file.get_as_text())

 file.close()
# print something from the dictionnary for testing.