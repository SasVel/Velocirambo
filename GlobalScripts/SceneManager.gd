extends Node

@onready var pathsArr = [
	"res://UI/MainMenu/main_menu.tscn",
	"res://UI/LoadingScreen/loading_screen.tscn",
	"res://UI/BootScreen/boot_screen.tscn",
	"res://Scenes/Arena/arena_scene.tscn",
	"res://Scenes/TrainingGrounds/training_grounds.tscn"
]

@onready var loadingScreenScn = preload("res://UI/LoadingScreen/loading_screen.tscn")

enum Scenes {
	MainMenu,
	LoadingScreen,
	BootScreen,
	Arena,
	TrainingGrounds
}

var stageInstance : Node

## Loading bar transitions not working and disabled for now
func load_scene(scn : Scenes, hasLoadingBar = false, displayLoadingBar = false, preloadObjects = false) -> bool:
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
	
	var loadingScreenInst : LoadingScreen
	# Loading Screen Setup
	if hasLoadingBar:
		loadingScreenInst = loadingScreenScn.instantiate()
		Ref.mainUI.add_child(loadingScreenInst)

		await loadingScreenInst.transitionComponent.conceal()
		loadingScreenInst.activate(displayLoadingBar, preloadObjects)
	

	while true:
		var loadProgress = []
		var loadStatus = ResourceLoader.load_threaded_get_status(scenePath, loadProgress)
		match loadStatus:
			0: #THREAD_LOAD_INVALID_RESOURCE
				print("Error: Trying to load an invalid resource")
				break
			1: #THREAD_LOAD_IN_PROGRESS
				if hasLoadingBar: loadingScreenInst.set_loading_percent(loadProgress[0])
			2: #THREAD_LOAD_FAILED
				print("Error: Loading resource failed")
				break
			3: #THREAD_LOAD_LOADED
				scene = ResourceLoader.load_threaded_get(scenePath)
				if hasLoadingBar: loadingScreenInst.deactivate()
				isLoaded = true
				break
	
	if stageInstance: stageInstance.queue_free()
	stageInstance = scene.instantiate()
	
	Ref.main.call_deferred("add_child", stageInstance)

	if hasLoadingBar:
		await loadingScreenInst.transitionComponent.reveal()
		loadingScreenInst.queue_free()

	get_tree().paused = false
	return isLoaded

