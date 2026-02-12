@tool # <--- Esto permite que el script corra en el editor
extends Node2D

@export_range(1, 4) var nivel_actual : int = 1:
	set(valor):
		nivel_actual = valor
		# Esto asegura que el código solo corra si el nodo ya está listo
		if Engine.is_editor_hint(): 
			generar_castillo()

@onready var grid: GridContainer = $ColorRect/CenterContainer/GridContainer
@export var parcela_escena: PackedScene = preload("res://Escenas/Parcela.tscn")

# Tu tabla de configuración
const CONFIG_NIVELES = {
	1: {"cols": 2, "total": 6, "res": Vector2(135, 192)},
	2: {"cols": 3, "total": 9, "res": Vector2(192, 192)},
	3: {"cols": 3, "total": 12, "res": Vector2(192, 249)},
	4: {"cols": 3, "total": 15, "res": Vector2(192, 306)}
}

func _ready():
	generar_castillo()

func generar_castillo():
	# En el modo @tool, a veces los @onready no han cargado, así que aseguramos el nodo
	if not grid: 
		grid = get_node_or_null("GridContainer")
	if not grid: return

	var datos = CONFIG_NIVELES[nivel_actual]
	
	$ColorRect.custom_minimum_size = datos["res"]
	
	# 1. Configurar el Grid
	grid.columns = datos["cols"]
	#grid.custom_minimum_size = datos["res"]
	
	# 2. Limpiar parcelas viejas de forma segura en el editor
	for hijo in grid.get_children():
		hijo.free() # Usamos free() en lugar de queue_free() para el editor
		
	# 3. Crear las nuevas parcelas
	if parcela_escena:
		for i in range(datos["total"]):
			var nueva_parcela = parcela_escena.instantiate()
			grid.add_child(nueva_parcela)
			# En el editor es útil ver qué parcela es cuál
			nueva_parcela.name = "Parcela_" + str(i+1)
