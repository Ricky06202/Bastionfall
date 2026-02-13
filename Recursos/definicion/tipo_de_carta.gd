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
@export var spriteEstructura : Texture2D
@export var creaUnidades : bool = false
@export var tipoDeUnidad : TipoDeUnidad
@export var tipoEstructura : tiposEstructuras
@export var costo : float
@export var capacidad : int = 4

enum tiposEstructuras {
	MELEE,
	DISTANCIA,
	MAGICO
}
