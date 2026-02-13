extends Node

signal cartaSeleccionada(cartaTocada)

signal siguienteOleada()

var modoContruccion := false
signal avisoModoConstruccion(activo)
var construccion : TipoDeCarta
signal estructuraColocada

# El punto donde las unidades se reunirán (frente de batalla)
var punto_reunion : Marker2D

# Diccionario para contar cuántas unidades hay en cada fila (MELEE, CURADOR, DISTANCIA)
# Esto permite que unidades de distintos edificios se posicionen sin solaparse.
var contadores_filas : Dictionary = {
	0: 0, # MELEE
	1: 0, # CURADOR
	2: 0  # DISTANCIA
}

func resetear_contadores_filas():
	contadores_filas[0] = 0
	contadores_filas[1] = 0
	contadores_filas[2] = 0

var totales_oleada : Dictionary = {0: 0, 1: 0, 2: 0}
