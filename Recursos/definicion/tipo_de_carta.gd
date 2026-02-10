extends Resource
class_name TipoDeCarta

@export var tipo : tipos

enum tipos {
	MONEDAS,
	HECHIZOS,
	ESTRUCTURA
}

@export var sprite : Texture2D

@export_category("Monedas")
@export var cantidad : int

@export_category("Hechizos")
@export var daño : float

@export_category("Estructura")
