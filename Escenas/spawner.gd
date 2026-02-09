extends Node2D

@onready var direccion_castillo: Marker2D = $DireccionCastillo
@onready var enemigo : PackedScene = load("res://Escenas/enemigo.tscn")
@onready var enemigo1: Area2D = $Enemigo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 1
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(on_timeout)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func on_timeout():
	#calcular las zonas de spawn
	var spawnPositionX = randf_range(0, -get_viewport_rect().size.x / 2)
	var spawnPositionY = randf_range(0, get_viewport_rect().size.y + 100)
	
	var nuevoEnemigo = enemigo.instantiate() as Area2D
	nuevoEnemigo.position.y = spawnPositionY
	add_child(nuevoEnemigo)
	nuevoEnemigo.look_at(direccion_castillo.global_position)
	
	
