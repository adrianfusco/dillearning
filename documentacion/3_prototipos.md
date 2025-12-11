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

### Provider y notifier

Cuando estaba implementando el cambio de tema de dark / light tuve problemas ya que lograba cambiar el tema en la propia vista y no en la aplicación entera. En este caso como el cambio de tema se hacía desde otra vista que no era la principal donde corría la aplicación (main) entonces no podía notificar a toda la aplicación el cambio de tema. Como solución Al final tuve que usar [https://pub.dev/packages/provider](https://pub.dev/packages/provider) que me fue de ayuda para poder notificar a la vista superior a través del widget. En este caso tengo que agradecer los siguientes posts que me fueron de ayuda ya que con esa base y un poco de ayuda con IA pude implementarlo: 

- https://medium.com/@ravipatel84184/implementing-dark-mode-in-flutter-a-complete-guide-e6924d2d9932
- https://www.geeksforgeeks.org/flutter/flutter-implement-light-mode-and-dark-mode/
- https://youtu.be/ep6PC6QHpEc?si=fI5UD1FShEnrUFbD
- https://youtu.be/rRrSOQYAYtA?si=Sx1IpZ80_ipwR6FF
- https://medium.com/@notesapp555/flutter-dark-light-mode-toggle-with-provider-state-management-complete-guide-and-example-f80041ef0d0d
- https://github.com/luizeof/flutter-darkmode-provider-example

El código no fue mucho al final pero me costó un poco entenderlo al principio [MR - Habilitar modo claro oscuro](https://gitlab.iessanclemente.net/damd/a23adrianfa1/-/merge_requests/25).

### Push de imágenes al registry de docker usando GitLab CI/CD

En este caso no tengo acceso a los runners del GitLab por lo que hacer build de imágenes es complicado al no tener privilegios. En este caso he optado por usar [GoogleContainerTools/kaniko](https://github.com/GoogleContainerTools/kaniko) que es rootless y no tuve más problemas para hacer el build, tag y push al registry de docker.

### Modelos que requieren de más memoria

En este caso he contratado un VPS que tiene 1GB de RAM. Estaba usando el modelo `granite4:micro-h` para hacer pruebas y me daba el siguiente error:
```
  File "/usr/local/lib/python3.12/site-packages/ollama/_client.py", line 179, in inner
    raise ResponseError(e.response.text, e.response.status_code) from None
ollama._types.ResponseError: model requires more system memory (1.9 GiB) than is available (794.6 MiB) (status code: 500)
```

Esto es algo a tener en cuenta. En este caso en producción para hacer pruebas lo he sustituido con `qwen2.5:0.5b` que tiene muy pocos parámetros al ser 0.5b por lo que las respuestas serán más deficientes y maneja menos datos pero para probar como sería la aplicación desplegada nos viene bien.

# Cambios durante el desarrollo

Esto es importante ya que, como en la mayoría de proyectos que requieren tantas tecnologías, modulos y adaptación en los despliegues, siempre hay cambios durante el desarrollo por lo que siempre va a diferir del anteproyecto.

En el apartado anterior ya he mencionado algunos.
