extends CharacterBody2D

@export var velocidad: float = 50.0
@export var tiempo_ataque: float = 1.5

var objetivo: Vector2
var objetivo_nodo: Node2D = null

@onready var sprite = $Sprite2D
@onready var detector: Detector = $Detector
@onready var hitbox: Hitbox = $Hitbox
@onready var timer_ataque: Timer = $TimerAtaque

enum Estado { CAMINANDO, PERSIGUIENDO, ATACANDO }
var estado_actual = Estado.CAMINANDO

func _ready():
	add_to_group("enemigos")
	timer_ataque.wait_time = tiempo_ataque
	timer_ataque.timeout.connect(_on_timer_ataque_timeout)
	
	# Conectamos señales del hitbox para saber cuándo atacar
	hitbox.area_entered.connect(_on_hitbox_area_entered)
	hitbox.area_exited.connect(_on_hitbox_area_exited)

func _physics_process(delta):
	actualizar_ia()
	
	match estado_actual:
		Estado.CAMINANDO:
			moverse_hacia(objetivo)
		Estado.PERSIGUIENDO:
			if is_instance_valid(objetivo_nodo):
				moverse_hacia(objetivo_nodo.global_position)
		Estado.ATACANDO:
			velocity = Vector2.ZERO
	
	move_and_slide()

func actualizar_ia():
	# Si hay un objetivo en el hitbox, atacamos
	if tiene_objetivo_en_hitbox():
		estado_actual = Estado.ATACANDO
		if timer_ataque.is_stopped():
			timer_ataque.start()
	# Si no hay nadie en el hitbox pero sí en el detector, perseguimos
	elif detector.tiene_objetivo():
		objetivo_nodo = detector.objetivo_actual
		estado_actual = Estado.PERSIGUIENDO
		timer_ataque.stop()
	# Si no hay nadie, caminamos al castillo
	else:
		objetivo_nodo = null
		estado_actual = Estado.CAMINANDO
		timer_ataque.stop()

func tiene_objetivo_en_hitbox() -> bool:
	for area in hitbox.get_overlapping_areas():
		if area is Hurtbox:
			# Solo atacamos si el hurtbox pertenece a una unidad (y no a otro enemigo)
			if area.get_parent().is_in_group("unidades"):
				objetivo_nodo = area.get_parent()
				return true
	return false

func moverse_hacia(pos: Vector2):
	var direccion = (pos - global_position).normalized()
	velocity = direccion * velocidad

func _on_hitbox_area_entered(area):
	if area is Hurtbox:
		actualizar_ia()

func _on_hitbox_area_exited(area):
	actualizar_ia()

func _on_timer_ataque_timeout():
	if estado_actual == Estado.ATACANDO:
		# Atacamos a todos los que estén en el área del hitbox
		for area in hitbox.get_overlapping_areas():
			if area is Hurtbox and area.get_parent().is_in_group("unidades"):
				area.recibir_daño(hitbox.daño)
				print("Enemigo atacó a una unidad en el hitbox!")


func _on_vida_morir() -> void:
	queue_free()