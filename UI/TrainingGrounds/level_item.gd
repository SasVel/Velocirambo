extends Button

@export var checkBox : Control

var levelName : String
var desc : String

var isCompleted : bool = false
var isSelectable : bool = false

func init(type : BalanceData.Levels, data : LevelData):
	levelName = data.name
	desc = data.desc
	isCompleted = GameInfo.data.levelsCompleted[type]

func _ready():
	checkBox.visible = isCompleted