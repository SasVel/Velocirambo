extends Node
class_name UIHelper

##Enum for dynamic UI elements. They can be spawned with elementsArr and should
##be deleted after their use is over.
enum Elements {
	YesNoMessage,
	AnnouncePopup,
	Settings
}

enum Modes {
	Free,
	Menu,
	Interact,
	Battle
}

@onready var _currMode : Modes
@onready var _lastMode : Modes

func change_mode(val : Modes):
	_lastMode = _currMode
	_currMode = val
	match val:
		Modes.Free:
			if GameInfo.data.usingController: Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
			else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

			Ref.mainUI.interactUI.visible = false
			Ref.mainUI.battleUI.visible = false
		Modes.Menu:
			if GameInfo.data.usingController: Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
			else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			
		Modes.Interact:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			Ref.mainUI.interactUI.visible = true
			Ref.mainUI.battleUI.visible = false
		Modes.Battle:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			Ref.mainUI.battleUI.visible = true
			Ref.mainUI.interactUI.visible = false

func change_to_last_mode():
	change_mode(_lastMode)

var elementsArr = [
	preload("res://UI/Components/YesNoMessage/yes_no_message.tscn"),
	preload("res://UI/AnnounceLabelUI/announce_label_ui.tscn"),
	preload("res://UI/Settings/settings.tscn")
]

func show_yes_no_msg(caller : Control, message : String = "Are you sure?"):
	var msg : YesNoMessage = elementsArr[0].instantiate().init(message)
	caller.add_child(msg)
	
	var res = await msg.answer
	msg.queue_free()
	caller.set_focus()
	return res

func show_announce_label(caller : Node, title : String, desc : String):
	var label : AnnounceUI = elementsArr[1].instantiate().init(title, desc)
	caller.add_child(label)
	caller.move_child(label, 0)
	
	await label.activate()
	label.queue_free()
	return label

func inst_component(type : Elements) -> Node:
	return elementsArr[type].instantiate()

##Used to display components from elementsArr
func display_component(caller : Node, type : Elements, setFocus : bool = true) -> Node:
	var elementInst = inst_component(type)
	caller.add_child(elementInst)
	if elementInst is MenuComponent && setFocus:
		elementInst.set_focus()
	return elementInst

func close_component(caller : Node):
	caller.closed.emit()
	caller.queue_free()
