@tool
extends Area2D

@export var tipoDeCarta : TipoDeCarta:
	set(nuevo_recurso):
		tipoDeCarta = nuevo_recurso
		# Llamamos a la actualización solo si estamos en el editor
		if Engine.is_editor_hint():
			# Usamos call_deferred para esperar a que los nodos estén listos 
			# si es que acabas de abrir la escena.
			call_deferred("actualizar_visuales")

var seleccionada := false

@onready var posicionInicial := global_position
@onready var borde: Sprite2D = $Borde
@onready var tipo: Label = $Tipo
@onready var sprite_2d: TextureRect = $Control/Sprite2D
@onready var carta: MeshInstance2D = $Carta


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Actualizamos al iniciar para que cargue lo que tenga asignado
	actualizar_visuales()
	if not Engine.is_editor_hint():
		Globals.cartaSeleccionada.connect(onCartaSeleccionada)

func actualizar_visuales():
	# Verificamos que los nodos existan (muy importante en modo @tool)
	if not is_inside_tree() or not tipoDeCarta: 
		return
	
	# Aseguramos que los @onready se hayan ejecutado o buscamos los nodos
	if not sprite_2d: sprite_2d = $Control/Sprite2D
	if not tipo: tipo = $Tipo
	if not carta: carta = $Carta

	if tipoDeCarta.sprite:
		sprite_2d.texture = tipoDeCarta.sprite
		sprite_2d.visible = true
		carta.visible = false
		tipo.visible = false
	else:
		# Si no hay imagen, que se vean los textos por defecto
		carta.visible = true
		tipo.visible = true

	match tipoDeCarta.tipo:
		0: tipo.text = "Monedas"
		1: tipo.text = "Hechizos"
		2: tipo.text = "Estructuras"
	

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
		0: Inventario.obtenerMonedas.emit(tipoDeCarta)
		1: Inventario.obtenerHechizos.emit(tipoDeCarta)
		2: Inventario.obtenerEstructuras.emit(tipoDeCarta)
	queue_free()
