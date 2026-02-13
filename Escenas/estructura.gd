extends Node2D

var tipoDeUnidad : TipoDeUnidad # Se llena al instanciarse
var unidad_escena = preload("res://Escenas/unidad.tscn")
var capacidad : int = 0
var cantidad_a_generar : int = 0

func _ready():
	add_to_group("estructuras")
	Globals.siguienteOleada.connect(_on_siguiente_oleada)
	# Preparamos las unidades iniciales para la primera oleada
	if tipoDeUnidad:
		cantidad_a_generar = capacidad

func _on_siguiente_oleada():
	# Recargamos la cantidad para que cada oleada salgan nuevas
	if tipoDeUnidad:
		cantidad_a_generar = capacidad
	producir_unidades()

func producir_unidades():
	if not tipoDeUnidad or cantidad_a_generar <= 0: return
	
	for i in range(cantidad_a_generar):
		var unidad = unidad_escena.instantiate()
		unidad.tipoDeUnidad = tipoDeUnidad
		
		get_tree().current_scene.add_child(unidad)
		unidad.global_position = global_position
		
		# Obtenemos el índice de la fila según el tipo
		var indice_tipo = tipoDeUnidad.tipo # 0: Melee, 1: Curador, 2: Distancia
		
		# Calculamos su posición en X basándonos en el Marker2D global (punto_reunion)
		# Si no existe, usamos valores por defecto
		var base_x = 600
		if Globals.punto_reunion:
			base_x = Globals.punto_reunion.global_position.x
			
		var x_destino = base_x
		match indice_tipo:
			TipoDeUnidad.tiposUnidades.MELEE: 
				x_destino = base_x # El frente exacto
			TipoDeUnidad.tiposUnidades.CURADOR: 
				x_destino = base_x - 50 # Un poco atrás
			TipoDeUnidad.tiposUnidades.DISTANCIA: 
				x_destino = base_x - 100 # Más atrás
		
		# Usamos el contador GLOBAL para la variación en Y
		# Calculamos el desplazamiento para que queden centradas respecto al Marker
		# (Asumimos un máximo de 10-12 unidades por fila para el centrado, o lo hacemos dinámico)
		var numero_unidad_en_fila = Globals.contadores_filas[indice_tipo]
		var separacion_y = 25
		
		# Obtenemos el centro (Y del Marker)
		var centro_y = 180
		if Globals.punto_reunion:
			centro_y = Globals.punto_reunion.global_position.y
		
		# Calculamos el offset para que la formación esté centrada
		# (Total de unidades en esta fila - 1) * separacion / 2
		var total_unidades_fila = Globals.totales_oleada[indice_tipo]
		var offset_centrado = (total_unidades_fila - 1) * separacion_y / 2.0
		
		var variacion_y = centro_y + (numero_unidad_en_fila * separacion_y) - offset_centrado
		
		var pos_final = Vector2(x_destino, variacion_y)
		unidad.ir_a_posicion(pos_final)
		
		# Incrementamos el contador global para la siguiente unidad (de este u otro edificio)
		Globals.contadores_filas[indice_tipo] += 1
		
		await get_tree().create_timer(0.1).timeout
	
	# Una vez generadas todas las unidades de esta tanda, reseteamos la cantidad
	# para que no se vuelvan a crear en la siguiente oleada a menos que el edificio genere más.
	cantidad_a_generar = 0
