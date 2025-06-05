extends Node

##Manager of game data. Signals when data is loaded.

var saveFilePath = "user://GameData/"
var saveFileName = "GameData.tres"

signal loaded_data

signal game_won
signal game_lost
signal reset

var data : GameData

func _ready():
	verify_save_dir(saveFilePath)
	if !ResourceLoader.exists(saveFilePath + saveFileName):
		create_new_data()
	else: push_error("Invalid save file path.")
	
	load_data()

func verify_save_dir(path : String):
	DirAccess.make_dir_absolute(path)

func load_data():
	data = ResourceLoader.load(saveFilePath + saveFileName).duplicate(true)
	if data.version == null || data.version != Const.gameDataVersion: 
		create_new_data()
	loaded_data.emit()

func save_data():
	ResourceSaver.save(data, saveFilePath + saveFileName)

func create_new_data():
	data = GameData.new()
	data.configure()
	save_data()
