extends Area2D

var seguirMouse := false
var posicionCorrecta := false
@onready var posicionInicial := global_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if seguirMouse:
		global_position = get_global_mouse_position()


func _on_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)


func _on_mouse_exited() -> void:
	scale = Vector2(1, 1)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		seguirMouse = !seguirMouse
		if seguirMouse and posicionCorrecta:
			queue_free()
		else:
			global_position = posicionInicial
