extends CharacterBody2D

@export var tipoDeUnidad: TipoDeUnidad # Aquí arrastras el archivo .tres
@onready var sprite = $AnimatedSprite2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var tiempo_ataque: float = 1.0

var objetivo_pos : Vector2
var desplegando : bool = false
var objetivo_enemigo: Node2D = null

@onready var detector: Detector = $Detector
@onready var hitbox: Hitbox = $Hitbox
@onready var timer_ataque: Timer = $TimerAtaque

func _ready():
	add_to_group("unidades")
	timer_ataque.wait_time = tiempo_ataque
	timer_ataque.timeout.connect(_on_timer_ataque_timeout)
	
	# Conectamos señales del hitbox
	hitbox.area_entered.connect(_on_hitbox_area_entered)
	hitbox.area_exited.connect(_on_hitbox_area_exited)
	
	if tipoDeUnidad:
		# Le pasamos el paquete de animaciones del recurso al sprite
		#sprite.sprite_frames = tipoDeUnidad.animaciones
		#sprite.play("idle") # Todas las unidades deben tener una anim llamada "idle"
		
		sprite_2d.texture = tipoDeUnidad.sprite

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
	else:
		# Si ya está en su sitio, solo se encarga de atacar
		actualizar_combate()

func actualizar_combate():
	if tiene_enemigo_en_hitbox():
		if timer_ataque.is_stopped():
			timer_ataque.start()
	else:
		timer_ataque.stop()

func tiene_enemigo_en_hitbox() -> bool:
	for area in hitbox.get_overlapping_areas():
		if area is Hurtbox:
			if area.get_parent().is_in_group("enemigos"):
				return true
	return false

func _on_hitbox_area_entered(area):
	if not desplegando:
		actualizar_combate()

func _on_hitbox_area_exited(area):
	if not desplegando:
		actualizar_combate()

func _on_timer_ataque_timeout():
	# Atacamos a los enemigos que estén dentro del área del hitbox
	for area in hitbox.get_overlapping_areas():
		if area is Hurtbox and area.get_parent().is_in_group("enemigos"):
			area.recibir_daño(hitbox.daño)
			print("Unidad atacó a un enemigo en el hitbox!")


func _on_vida_morir() -> void:
	queue_free()
