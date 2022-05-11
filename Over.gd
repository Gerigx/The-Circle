extends Control




func _on_Retry_pressed():
	get_tree().change_scene("res://Map1.tscn")


func _on_Quit_pressed():
	get_tree().quit()
