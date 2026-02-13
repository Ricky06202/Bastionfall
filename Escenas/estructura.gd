extends Node2D

var tipoDeUnidad : TipoDeUnidad # Se llena al instanciarse
var unidad_escena = preload("res://Escenas/Unidad.tscn")

func _ready():
	# En cuanto el edificio entra al árbol, esperamos un frame para 
	# asegurar que su global_position sea correcta y lanzamos soldados
	producir_unidades()

func producir_unidades():
	if not tipoDeUnidad: return
	
	for i in range(4):
		var unidad = unidad_escena.instantiate()
		unidad.datos = tipoDeUnidad # Le pasamos la ficha técnica (Fase 1)
		
		# Lo añadimos a la escena principal para que corra libre
		get_tree().current_scene.add_child(unidad)
		
		# Sale desde la posición de este edificio
		unidad.global_position = global_position
		
		# Calculamos su fila de destino
		var x_destino = 0
		match tipoDeUnidad.tipo:
			"CERCANO": x_destino = 600
			"CURANDERO": x_destino = 450
			"LEJANO": x_destino = 300
			
		# Le damos su objetivo (con un poco de variación en Y para que no se solapen)
		var pos_final = Vector2(x_destino, global_position.y + (i * 20 - 30))
		unidad.ir_a_posicion(pos_final)
		
		# Pequeño delay para que salgan uno tras otro
		await get_tree().create_timer(0.1).timeout
