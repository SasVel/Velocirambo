extends MenuComponent


func _on_back_btn_pressed():
	self.visible = false
	closed.emit(self)
