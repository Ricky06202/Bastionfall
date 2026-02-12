extends Resource
class_name TipoDeCarta

@export var nombre : String

@export var tipo : tiposCartas

enum tiposCartas {
	MONEDAS,
	HECHIZOS,
	ESTRUCTURA
}

@export var sprite : Texture2D

@export_category("Monedas")
@export var cantidad : int

@export_category("Hechizos")
@export var icono : Texture2D
@export var tipoHechizo : tiposHechizos
@export var poder : float
@export var mana : float
@export var duracion : float

enum tiposHechizos {
	FUEGO,
	HIELO,
	ELECTRICIDAD,
	VENENO,
	CURACION
}

@export_category("Estructura")
@export var tipoUnidad : tiposEstructuras
@export var costo : float
@export var capacidad : int = 4

@export_subgroup("Estadisticas de unidad")
@export var vida : float
@export var ataque : float
@export var velocidad : float

enum tiposEstructuras {
	MELEE,
	DISTANCIA,
	MAGICO
}
