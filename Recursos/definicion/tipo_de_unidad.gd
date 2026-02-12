extends Resource
class_name TipoDeUnidad

@export var nombre: String = "Unidad"
@export var tipo: tiposUnidades

enum tiposUnidades {
	MELEE,
	CURADOR,
	DISTANCIA
}

# Atributos de combate
@export var vida_maxima: float = 50.0
@export var daño: float = 10.0
@export var velocidad: float = 100.0

# El secreto de las animaciones:
@export var animaciones: SpriteFrames
@export var sprite: Texture2D
