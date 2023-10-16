extends Node
class_name ScoreSaveManager

const SCORE_SAVE_FILE := "user://score.save"

var top_score: int = 0


func load_current_high_score() -> void:
	if not FileAccess.file_exists(SCORE_SAVE_FILE):
		return
	
	var save_game = FileAccess.open(SCORE_SAVE_FILE, FileAccess.READ)
	top_score = save_game.get_var()


func save_score_if_higher(current_score: int) -> void:
	if current_score > top_score:
		top_score = current_score
		
		var save_game = FileAccess.open(SCORE_SAVE_FILE, FileAccess.WRITE)
		
		save_game.store_var(current_score)
