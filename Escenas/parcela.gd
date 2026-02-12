extends PanelContainer

var ocupada := false
@onready var escena_edificio = preload("res://Escenas/edificio.tscn")

func construir_aqui(recurso: TipoDeUnidad):
	if ocupada: return
	
	ocupada = true
	var nuevo_edificio = escena_edificio.instantiate()
	# Pasamos el recurso ANTES de añadir al hijo para que el _ready del edificio lo tenga
	nuevo_edificio.datos_unidad = recurso 
	add_child(nuevo_edificio)
	
	# Centramos el edificio en el cuadro de 48x48
	nuevo_edificio.position = size / 2
