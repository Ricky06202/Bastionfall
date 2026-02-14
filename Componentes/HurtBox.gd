extends Area2D
class_name Hurtbox

@onready var vida_component: Vida = get_parent().get_node("Vida") # Referencia al componente de vida que ya tienes

func recibir_daño(cantidad: float):
	if vida_component:
		vida_component.recibir_daño(cantidad) # Asumiendo que tu Vida.gd tiene esta función