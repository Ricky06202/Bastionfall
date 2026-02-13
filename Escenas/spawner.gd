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
