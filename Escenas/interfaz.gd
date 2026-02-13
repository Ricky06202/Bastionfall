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

var siguienteOleadaActivada := false

func resetGlobals():
	Globals.modoContruccion = false
	Globals.avisoModoConstruccion.emit(false)
	Globals.construccion = null
	Globals.estructuraColocada.emit()
	Inventario.resetearInventario()

func _on_siguiente_oleada_pressed() -> void:
	if siguienteOleadaActivada: 
		get_tree().reload_current_scene()
		resetGlobals()
		return
	# Limpiamos las unidades supervivientes antes de empezar la nueva oleada
	get_tree().call_group("unidades", "queue_free")
	
	Globals.resetear_contadores_filas()
	
	# Contamos cuántas unidades totales habrá por tipo para centrar la formación
	var total_por_tipo = {0: 0, 1: 0, 2: 0}
	var estructuras_en_escena = get_tree().get_nodes_in_group("estructuras")
	for est in estructuras_en_escena:
		if est.tipoDeUnidad:
			var idx = est.tipoDeUnidad.tipo
			total_por_tipo[idx] += est.capacidad
	
	Globals.totales_oleada = total_por_tipo
	
	Globals.siguienteOleada.emit()

	siguienteOleadaActivada = true
	$"Control/Siguiente Oleada".text = "Reset"


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
	Globals.avisoModoConstruccion.emit(true)
	indiceConstruccion = 0
	Globals.construccion = Inventario.estructuras.get(0)


func _on_estructura_2_pressed() -> void:
	Globals.avisoModoConstruccion.emit(true)
	indiceConstruccion = 1
	Globals.construccion = Inventario.estructuras.get(1)


func _on_estructura_3_pressed() -> void:
	Globals.avisoModoConstruccion.emit(true)
	indiceConstruccion = 2
	Globals.construccion = Inventario.estructuras.get(2)
	
var indiceConstruccion := 0

func avisoModoConstruccion(activo):
	Globals.modoContruccion = activo
	$"Control/Modo Construccion".visible = activo

func estructuraColocada():
	Inventario.estructuras.remove_at(indiceConstruccion)
	estructuras.get(indiceConstruccion).visible = false
			
