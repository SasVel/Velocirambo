extends Node

@onready var pathsArr = [
	"res://UI/MainMenu/main_menu.tscn",
	"res://UI/LoadingScreen/loading_screen.tscn",
	"res://UI/BootScreen/boot_screen.tscn",
	"res://Scenes/Arena/arena_scene.tscn"
]

enum Scenes {
	MainMenu,
	LoadingScreen,
	BootScreen,
	Arena,
	TrainingGrounds
}

var stageInstance : Node

func load_scene(scn : Scenes, _loadingScreen = null) -> bool:
	get_tree().paused = true
	
	var scene
	var isLoaded = false
	var scenePath = pathsArr[scn]
	#Check if resource exists
	if ResourceLoader.exists(scenePath):
		scene = ResourceLoader.load_threaded_request(scenePath)
	else:
		print("Error: trying to load a non-existent file.")
		return isLoaded
	
	while true:
		var loadProgress = []
		var loadStatus = ResourceLoader.load_threaded_get_status(scenePath, loadProgress)
		match loadStatus:
			0: #THREAD_LOAD_INVALID_RESOURCE
				print("Error: Trying to load an invalid resource")
				break
			1: #THREAD_LOAD_IN_PROGRESS
				if _loadingScreen: _loadingScreen.set_loading_percent(loadProgress[0])
			2: #THREAD_LOAD_FAILED
				print("Error: Loading resource failed")
				break
			3: #THREAD_LOAD_LOADED
				scene = ResourceLoader.load_threaded_get(scenePath)
				isLoaded = true
				break
	
	if stageInstance: stageInstance.queue_free()
	stageInstance = scene.instantiate()
	
	self.call_deferred("add_child", stageInstance)
	
	get_tree().paused = false
	return isLoaded

