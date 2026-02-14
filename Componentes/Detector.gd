extends Area2D
class_name Detector

@export var grupo_a_detectar: String = "unidades"
var objetivo_actual: Node2D = null

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group(grupo_a_detectar):
		if not objetivo_actual:
			objetivo_actual = body

func _on_body_exited(body):
	if body == objetivo_actual:
		objetivo_actual = null
		# Buscar otro objetivo si hay más en el área
		var bodies = get_overlapping_bodies()
		for b in bodies:
			if b.is_in_group(grupo_a_detectar):
				objetivo_actual = b
				break

func tiene_objetivo() -> bool:
	return is_instance_valid(objetivo_actual)