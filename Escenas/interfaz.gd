extends CanvasLayer

@onready var monedas: Label = $"Control/Grupo Monedas/Monedas"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventario.obtenerMonedas.connect(obtenerMonedas)
	Inventario.obtenerHechizos.connect(obtenerHechizos)
	Inventario.obtenerEstructuras.connect(obtenerEstructuras)
	Globals.avisoModoConstruccion.connect(avisoModoConstruccion)
	Globals.estructuraColocada.connect(estructuraColocada)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_siguiente_oleada_pressed() -> void:
	Globals.siguienteOleada.emit()

func obtenerMonedas(carta):
	Inventario.intentar_agregar_item(carta)
	monedas.text = str(Inventario.monedas)

@onready var hechizos : Array[TextureButton] = [
	$"Control/Inventario Poderes/Hechizo1",
	$"Control/Inventario Poderes/Hechizo2"
]

func obtenerHechizos(carta):
	Inventario.intentar_agregar_item(carta)
	for i in Inventario.hechizos.size():
		var hechizoActual = Inventario.hechizos.get(i)
		if hechizoActual:
			var hechizoNuevo = hechizos.get(i)
			hechizoNuevo.visible = true
			hechizoNuevo.texture_normal = hechizoActual.icono

@onready var estructuras : Array[TextureButton] = [
	$"Control/Inventario Estructuras/Estructura1",
	$"Control/Inventario Estructuras/Estructura2",
	$"Control/Inventario Estructuras/Estructura3"
]

func obtenerEstructuras(carta):
	Inventario.intentar_agregar_item(carta)
	for i in Inventario.estructuras.size():
		var hechizoActual = Inventario.estructuras.get(i)
		if hechizoActual:
			var hechizoNuevo = estructuras.get(i)
			hechizoNuevo.visible = true
			hechizoNuevo.texture_normal = hechizoActual.sprite


func _on_estructura_1_pressed() -> void:
	Globals.avisoModoConstruccion.emit()
	Globals.construccion = Inventario.estructuras.get(0)


func _on_estructura_2_pressed() -> void:
	Globals.avisoModoConstruccion.emit()
	Globals.construccion = Inventario.estructuras.get(1)


func _on_estructura_3_pressed() -> void:
	Globals.avisoModoConstruccion.emit()
	Globals.construccion = Inventario.estructuras.get(2)
	
	
func avisoModoConstruccion():
	Globals.modoContruccion = !Globals.modoContruccion
	$"Control/Modo Construccion".visible = !$"Control/Modo Construccion".visible

func estructuraColocada():
	for i in Inventario.estructuras.size():
		if Inventario.estructuras.get(i) == Globals.construccion:
			Inventario.estructuras.remove_at(i)
		estructuras.get(i).visible = false
			
