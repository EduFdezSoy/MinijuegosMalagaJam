# Guía del repositorio comunitario

Este es un proyecto comunitario creado con Godot por y para la comunidad. Su finalidad es pasar un buen rato haciendo minijueguitos. 
Como son bastante cortos, no debería llevar mucho tiempo crear un minijuego (y si lo lleva, no pasa nada). 
El objetivo es llegar a tener un catálogo muy grande de minijuegos y generar una especie de Mario Party / Wario Ware creado por la comunidad.
Las funcionalidades del juego en general se irán aumentando a lo largo de el tiempo pero el objetivo por ahora es:

Crear un juego de minijuegos de 2 a 4 jugadores donde 1 persona gana tras haber conseguido X victorias (siendo X configurable dentro del juego)

## Requisitos de los minijuegos
- Deben ser minijuegos de entre 7 a 15 segundos
- Deben de poder jugarse con un único botón por jugador (Vale contar la pulsación, dejar de pulsar el botón o mantener el botón)
- Intenta que haya solo 1 ganador. A futuro barajaremos opciones de empate y juegos por equipos.

## Tutorial de como implementar nuevos minijuegos
Para implementar nuevos minijuegos, tendrás que descargarte el proyecto, crear una rama en base a develop y ahí ya podrás trabajar.
Crea una carpeta dentro de la carpeta raíz "Minijuegos" con el nombre de tu minijuego Ejemplo: "Minijuego de saltar a la comba".
Ahí colocaras tus scripts, escenas, sprites... Todo lo que necesite tu minijuego.

Los minijuegos deben ocurrir en una única escena. Esta escena debe de tener un script que herede de **MinigameBase**, para que pueda funcionar con la carga de niveles de forma automática.
Para los input de los jugadores, usaremos la clase global **InputController** que tiene las siguientes señales: 
- playerButtonPressed(playerId: int) -> Cuando un jugador ha pulsado un botón, devuelve el id del jugador
- playerButtonReleased(playerId: int) -> Cuando el jugador ha soldato el botón, devuelve el id del jugador
- playerButtonIsBeingPressed : Array[bool] -> También tenemos un array de tipo bool que devuelve en cada frame que botones se están pulsando. Por si vuestro juego necesita comprobar si se están pulsando los botones. Aunque es recomendable usar la combinación de los dos anteriores (Press y release) para saber si se está haciendo el hold.

Para probar el minijuego. Ve a la escena PlayerSelection y en el nodo **RoundController** añade al atributo **AvailableMinigames** tu escena de minijuego. ⚠️Recuerda que el nodo de la escena de tu minijuego debe tener un script que herede de **MinigameBase**
Puedes quitar la escena que haya puesta en el **RoundController** para que así salga tu minijuego directamente, pero **no subas cambios de la escena de PlayerSelection al repositorio** ⚠️
Debes crear un archivo tipo MinigameData en la carpeta de tu minijuego. Este archivo es donde pondrás los datos de las personas involucradas en el minijuego y una explicación breve de como jugar al minijuego, además de una imagen que sirva de preview. Coloca este archivo en el campo **MinigameData** del nodo del minijuego.
Estos datos aparecerán luego en una preview del minijuego que aparece antes de jugarlo.
Ahora al darle al play debería salirte una pantalla con botones. Pusla las teclas **A S D F** para activar los botones de los jugadores y pulsa la tecla **Espacio** para comenzar.
Aparecerá la ventana preview del minijuego y deberás pulsar los botones de los jugadores para indicar que están listos.
Después empezará la escena del minijuego.
  
