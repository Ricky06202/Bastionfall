extends Node2D

@onready var timer := Timer.new()
@onready var direccion_castillo: Marker2D = $DireccionCastillo
@onready var enemigo : PackedScene = load("res://Escenas/enemigo.tscn")
@onready var enemigo1: Area2D = $Enemigo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = 1
	add_child(timer)
	timer.timeout.connect(on_timeout)
	
	Globals.siguienteOleada.connect(siguienteOleada)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func on_timeout():
	#calcular las zonas de spawn
	var spawnPositionY = randf_range(10, get_viewport_rect().size.y -10)
	
	var nuevoEnemigo = enemigo.instantiate() as CharacterBody2D
	nuevoEnemigo.position.y = spawnPositionY
	nuevoEnemigo.objetivo = direccion_castillo.global_position
	add_child(nuevoEnemigo)
	
func siguienteOleada():
	timer.autostart = true
	timer.start()


########### TODO Esto esta aqui provisionalmente
@onready var unidad = load("res://Escenas/unidad.tscn")

func spawn_unidades_de_torre(tipo_unidad: TipoDeUnidad, parcela_pos: Vector2):
	for i in range(4): # 4 unidades por edificio
		var nueva_unidad = unidad.instantiate()
		nueva_unidad.datos = tipo_unidad
		add_child(nueva_unidad)
		
		# Calculamos el destino según el tipo
		var offset_fila = Vector2.ZERO
		match tipo_unidad.tipo:
			"CERCANO": offset_fila.x = 50  # Fila delantera
			"CURANDERO": offset_fila.x = 0  # Centro
			"LEJANO": offset_fila.x = -50  # Fila trasera
			
		nueva_unidad.global_position = parcela_pos + offset_fila + Vector2(0, i * 20)
############ Esto es provicional
