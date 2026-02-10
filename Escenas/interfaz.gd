extends CanvasLayer

@onready var monedas: Label = $"Control/Grupo Monedas/Monedas"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.obtenerMonedas.connect(obtenerMonedas)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_siguiente_oleada_pressed() -> void:
	Globals.siguienteOleada.emit()

func obtenerMonedas(cantidad):
	monedas.text = str(int(monedas.text) + cantidad)
