extends GridContainer

@onready var lvlItemScn : PackedScene = preload("res://UI/TrainingGrounds/level_item.tscn")

func _on_interact_component_activated(_player:Player):
	var lvlBalances = Balances.data.levelsBalances
	for levelName in lvlBalances:
		var lvlData : LevelData = Balances.data.levelsBalances[levelName]
		var inst = lvlItemScn.instantiate().init(levelName, lvlData)
		self.add_child(inst)


