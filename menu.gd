extends Control




func _on_Start_pressed():
	get_tree().change_scene("res://Map1.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Button_pressed():
	get_tree().change_scene("res://Map-0.tscn")
