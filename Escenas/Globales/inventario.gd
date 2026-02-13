extends Node

var monedas: int = 0
var hechizos: Array[TipoDeCarta] = []
var estructuras: Array[TipoDeCarta] = []

const MAX_HECHIZOS = 2
const MAX_ESTRUCTURAS = 3

signal obtenerMonedas(carta)
signal obtenerHechizos(carta)
signal obtenerEstructuras(carta)

func intentar_agregar_item(recurso: TipoDeCarta) -> bool:
	match recurso.tipo:
		0:
			monedas += recurso.cantidad # O el valor que tenga el recurso
			return true
		1:
			if hechizos.size() < MAX_HECHIZOS:
				hechizos.append(recurso)
				return true
		2:
			if estructuras.size() < MAX_ESTRUCTURAS:
				estructuras.append(recurso)
				return true
	
	return false # Si llegó aquí, es que estaba lleno o no era un tipo válido

func resetearInventario():
	monedas = 0
	hechizos = []
	estructuras = []