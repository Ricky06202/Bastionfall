extends CharacterBody2D

@export var tipoDeUnidad: TipoDeUnidad # Aquí arrastras el archivo .tres
@onready var sprite = $AnimatedSprite2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	add_to_group("unidades")
	if tipoDeUnidad:
		# Le pasamos el paquete de animaciones del recurso al sprite
		#sprite.sprite_frames = tipoDeUnidad.animaciones
		#sprite.play("idle") # Todas las unidades deben tener una anim llamada "idle"
		
		sprite_2d.texture = tipoDeUnidad.sprite

var objetivo_pos : Vector2
var desplegando : bool = false

func ir_a_posicion(pos: Vector2):
	objetivo_pos = pos
	desplegando = true

func _physics_process(delta):
	if desplegando:
		var direccion = (objetivo_pos - global_position)
		if direccion.length() > 5: # Si no ha llegado
			velocity = direccion.normalized() * tipoDeUnidad.velocidad
			move_and_slide()
		else:
			desplegando = false # Ya llegó a su fila
			velocity = Vector2.ZERO
