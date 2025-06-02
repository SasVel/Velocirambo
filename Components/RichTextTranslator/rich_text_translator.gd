extends Node

@export var textForTranslation : String
@onready var label : RichTextLabel = self.get_parent()
@onready var originalText

signal translated

func _ready():
	originalText = label.text
	translate.call_deferred()

func translate():
	label.text = originalText.replace("?", tr(textForTranslation));
	translated.emit()

func _notification(what):
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		translate.call_deferred()
