extends ProgressBar
class_name BarraVida

@onready var vida : Vida = get_parent().get_node("Vida")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = vida.vidaMax
	value = vida.vida
	vida.vida_cambiada.connect(cambiarVida)
	show_percentage = false
	modulate = Color.GREEN
	visible = false
	
func cambiarVida(nuevaVida):
	value = nuevaVida
	visible = true
	
