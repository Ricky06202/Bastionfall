extends CharacterBody2D

var objetivo : Vector2
@onready var posInicial = global_position

@export var velocidad := 20.0
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if objetivo:
		# 1. Calculamos la dirección (vector unitario)
		var direccion = (objetivo - global_position).normalized()
		
		# 2. Aplicamos movimiento solo en los ejes, sin rotar el nodo
		velocity.x = direccion.x * velocidad
		move_and_slide()
		
		# 3. Orientación visual (Flip)
		# Si la dirección en X es negativa, mira a la izquierda. Si es positiva, a la derecha.
		if direccion.x < 0:
			sprite.flip_h = false  # O false, dependiendo de hacia donde mire tu sprite original
		elif direccion.x > 0:
			sprite.flip_h = true
		
	
