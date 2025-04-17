extends Node
class_name UIHelper

##Enum for dynamic UI elements. They can be spawned with elementsArr and should
##be deleted after their use is over.
enum Elements {
	YesNoMessage,
	AnnouncePopup
}

var elementsArr = [
	preload("res://UI/Components/YesNoMessage/yes_no_message.tscn"),
	preload("res://UI/AnnounceLabelUI/announce_label_ui.tscn")
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
