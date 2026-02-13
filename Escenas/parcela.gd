extends PanelContainer

var ocupada := false
var estructuraPosicionada = false
var estructura : Node2D = null
@onready var escena_estructura : PackedScene = load("res://Escenas/estructura.tscn")

func _ready():
	pass
	
func construir_estructura():
	if ocupada: return
	
	ocupada = true
	estructura = escena_estructura.instantiate()
	var sprite : Sprite2D= estructura.get_node("Sprite2D")
	sprite.texture = Globals.construccion.spriteEstructura
	# Le pasamos el recurso al edificio ANTES de añadirlo
	#estructura.datos_unidad = recurso_unidad
	
	# Lo añadimos al Marker2D para que quede perfectamente centrado
	$Marker2D.add_child(estructura)

func destruir_estructura():
	if is_instance_valid(estructura):
		estructura.queue_free()
	estructura = null
	ocupada = false

func _on_area_2d_mouse_entered() -> void:
	if Globals.modoContruccion and not estructuraPosicionada:
		construir_estructura()


func _on_area_2d_mouse_exited() -> void:
	if Globals.modoContruccion and not estructuraPosicionada:
		destruir_estructura()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("click"):
		estructuraPosicionada = true
		Globals.estructuraColocada.emit()
		Globals.avisoModoConstruccion.emit()
