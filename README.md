# Bastionfall

**Bastionfall** es un juego que combina mecánicas de **Roguelite**, **Tower Defense** y **Unidades invocadas** en una perspectiva isométrica horizontal.

## Equipo de Desarrollo
- **Desarrollador (Godot):** Ricardo (Tú)
- **Artistas:** H y Aracno
- **Músico:** FenMkk
- **Líder de Proyecto:** Samuel (Visión original e idea clara del proyecto)

---

## Game Design Document (GDD)

### Resumen del Juego
- **Género:** Roguelite + Tower Defense + Unidades invocadas
- **Perspectiva:** Isométrica horizontal
- **Estilo Visual:** Pixel art semi-detallado con intención atmosférica
- **Resolución Base:** 640x360px
- **Loop Principal:** Construcción → Oleada → Recompensa → Progreso permanente

### Fantasía del Juego
El jugador lidera el último bastión del reino, construyendo defensas, entrenando unidades humanas y usando magia para detener la corrupción que avanza desde la derecha del mapa. Cada muerte otorga **Puntos Neuronales**, que permiten desbloquear unidades y mejoras permanentes para futuras partidas.

### Gameplay

#### 1. Fase de Construcción
- Solo se puede construir dentro de la zona del castillo.
- La construcción se pausa durante las oleadas.
- Requiere tener la **carta del edificio** y el **dinero necesario**.
- Cada edificio genera automáticamente 6 unidades (tiradores atrás, cuerpo a cuerpo delante).
- Las torres se pueden vender (por mitad de precio), pero no mover.

#### 2. Fase de Oleada
- Combate automático: las unidades y torres atacan solas.
- El jugador puede lanzar **hechizos manuales** consumiendo maná.
- La **corrupción del terreno** potencia a los enemigos (velocidad/fuerza).

#### 3. Sistema de Cartas (Post-oleada)
Se presentan 3 cartas tras cada victoria:
- **Dorado:** Otorga oro.
- **Verde:** Permite colocar una torre conocida.
- **Celeste:** Hechizo o poder (permanentes en el menú de hechizos).
- Se pueden almacenar hasta 2 hechizos (ampliable).

#### 4. Expansión del Castillo
El castillo crece visualmente y en capacidad a medida que se ocupan los espacios:
- **Nivel 1:** 6 torres (3x2) - 135x192 px internos.
- **Nivel 2:** 9 torres (3x3) - 192x192 px internos.
- **Nivel 3:** 12 torres (3x4) - 192x249 px internos.
- **Nivel 4:** 15 torres (3x5) - 192x306 px internos.

### Progresión y Economía
- **Puntos Neuronales:** Se obtienen al morir. Se usan para desbloquear unidades, mejorar estadísticas globales y expandir el castillo.
- **Monedas:** Se obtienen al derrotar enemigos para comprar unidades y torres durante la partida.
- **Corrupción:** Avanza visualmente desde la derecha, desaturando el mapa y añadiendo grietas, raíces negras y sombras moradas.
