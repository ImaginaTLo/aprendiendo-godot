# Proyecto 1: Cube Survivor
Un prototipo sencillo de recolección y supervivencia procedural desarrollado en Godot 4.6 (.NET) 
como primera toma de contacto y preparación para el grado de diseño de Videojuegos en la U-tad.

## Game Loop y Reglas
El jugador debe moverse por la pantalla para recolectar monedas mientras esquiva una horda creciente de enemigos
procedurales.

**Victoria:** Recolectar 4 monedas.
**Derrota:** Ser tocado por un cubo enemigo.
**Progresión:** Un nuevo enemigo aparece del lateral izquierdo en el nivel cada 2 segundos, aumentando la dificultad dinámicamente.

## Controles
* **Movimientos:** Teclas `W A S D` o `Flechas Direccionales`.
* **Sprint:** Mantener `Shift` para duplicar la velocidad base.
* **Reiniciar:** Tecla `R` para recargar el nivel al instante.

## Conceptos de Game Design Implementados
1. **Separación lógica:** Uso de *Input Maps* personalizados para abstracción de controles.
2. **Máquina de Estados** Variables booleanas para congelar el juego al ganar/perder.
3. **Escalabilidad:** Identificación de colisiones medieante *Grupos* (`monedas`, `enemigos`) en lugar de rutas directas.
4. **Instanciación Procedural:** Creación de enemigos en memoria (`preload`, `instantiate`) con un `Timer`automático.
