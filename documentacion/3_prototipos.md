# Prototipos y seguimiento

## Problemas encontrados y soluciones adoptadas

### Almacenamiento de datos

Durante el diseño una de las cosas que me planteaba es donde almacenar los datos. Había escogido SQLite como base de datos pero no sabía si dejarlo de momento en local para simular como funcionaría solamente para el proyecto.

El problema de esto es que si ejecutamos en distintos dispositivos la base de datos se crearía en distintos entornos.

Al final aprovechando de que tendría el backend en FastAPI he movido la gestión de login y registro de una vez y así podemos almacenar toda la información de registro y progreso y usarlo desde cualquier dispostivo.

### CORS

Al ser una aplicación multiplataforma empecé activándolo en Android y Desktop en Linux. Quise habilitarlo para web además y en este caso al tener el frontend y el backend separado tendríamos problemas de CORS. Esto supone un problema y necesitamos habilitar acceso desde las URLs donde el frontend accederá.

La solución fue habilitar CORS pero hay que tener cuidado de no dar acceso desde todos los origins (*) y para ello hay que tener dos entornos, uno en local para dar acceso a localhost y otro para producción para el dominio específico donde alojemos la web e.g. [https://dillearning.com](https://dillearning.com).

### Paquete .deb

En este caso el problema es pequeño pero bueno de documentar. Necesitaba realizar el build del paquete .deb de la aplicación en Flutter. En este caso estoy desarrollando en Arch y, aunque existen maneras de construir paquetes y hay [distintas maneras de hacerlo](https://wiki.archlinux.org/title/Creating_packages_for_other_distributions) al final decidí crear un script genérico que pueda ser ejecutado en un entorno que use .deb como Ubuntu / Debian y luego en el CI usar una imagen que use `apt` sin tener que usar workarounds.

# Cambios durante el desarrollo

Esto es importante ya que, como en la mayoría de proyectos que requieren tantas tecnologías, modulos y adaptación en los despliegues, siempre hay cambios durante el desarrollo por lo que siempre va a diferir del anteproyecto.

En el apartado anterior ya he mencionado algunos.
