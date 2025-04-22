extends Node

var isSteamRunning : bool = false

enum Ach {
	START_GAME,
	GET_A_NUGGIE,
	GRAB_A_BEER,
	WISHLIST_CLICK,
	ANKY_BOSS_DEFEAT,
	KILL_SELF_BARREL,
	KILL_BOSS_BARREL,
	HIT_20_SPIKES
}

func _init():
	OS.set_environment("SteamAppID", EnvData.APP_ID)
	OS.set_environment("SteamGameID", EnvData.APP_ID)

func _ready():
	Steam.steamInit()
	if !Steam.isSteamRunning():
		push_error("ERROR: Steam not running!")
		return
	print("Steam is running!")
	isSteamRunning = Steam.isSteamRunning()

func unlock_ach(ach : Ach):
	if !isSteamRunning: return
	
	var achStr = Ach.keys()[ach]
	var status = Steam.getAchievement(achStr)
	if status["achieved"]: return
	
	Steam.setAchievement(achStr)
	Steam.storeStats()

func clear_ach(ach : Ach):
	if !isSteamRunning: return
	Steam.clearAchievement(Ach.keys()[ach])
