@tool
extends Area2D

@export var tipoDeCarta : TipoDeCarta

var seguirMouse := false
var posicionCorrecta := false
var seleccionada := false

@onready var posicionInicial := global_position
@onready var borde: MeshInstance2D = $Borde
@onready var tipo: Label = $Tipo
@onready var sprite_2d: TextureRect = $Control/Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.cartaSeleccionada.connect(onCartaSeleccionada)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	actualizarEditor() # --> Esto Solo es para actualizar en vivo en el editor
	
	if seguirMouse:
		global_position = get_global_mouse_position()

func actualizarEditor():
	match tipoDeCarta.tipo:
		0: tipo.text = "Monedas"
		1: tipo.text = "Hechizos"
		2: tipo.text = "Estructuras"
	
	if tipoDeCarta.sprite:
		sprite_2d.texture = tipoDeCarta.sprite
		sprite_2d.visible = true

func _on_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)


func _on_mouse_exited() -> void:
	scale = Vector2(1, 1)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if event.is_action_pressed("click"):
		#seguirMouse = !seguirMouse
		#if seguirMouse and posicionCorrecta:
			#queue_free()
		#else:
			#global_position = posicionInicial
	if event.is_action_pressed("click"):
		if seleccionada:
			activar()
		Globals.cartaSeleccionada.emit(self)

func seleccionar():
	seleccionada = true
	borde.visible = true
	
func deseleccionar():
	seleccionada = false
	borde.visible = false
	
func onCartaSeleccionada(cartaTocada):
	if cartaTocada and cartaTocada != self:
		deseleccionar()
	cartaTocada.seleccionar()
	
func activar():
	match tipoDeCarta.tipo:
		0: Globals.obtenerMonedas.emit(tipoDeCarta.cantidad)
		1: Globals.obtenerHechizos.emit(tipoDeCarta.daño, tipoDeCarta.sprite)
		2: Globals.obtenerEstructuras.emit()
