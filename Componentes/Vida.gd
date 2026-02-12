extends Node
class_name Vida

signal vida_cambiada(nuevaVida)
signal morir
signal daño_recibido(cantidad)
signal cura_recibida(cantidad)

@export var vidaMax : int
var vida : int:
	set(valor):
		vida = clamp(valor, 0, vidaMax)
		vida_cambiada.emit(vida)
		if vida <= 0:
			morir.emit()

func _ready() -> void:
	if not vidaMax:
		vidaMax = randi_range(1,5)
	vida = vidaMax
	
func recibir_daño(cantidad: float):
	if cantidad <= 0: return
	vida -= cantidad
	daño_recibido.emit(cantidad)

func curar(cantidad: float):
	if cantidad <= 0: return
	vida += cantidad
	cura_recibida.emit(cantidad)
