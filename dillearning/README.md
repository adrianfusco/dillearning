# Dillearning Frontend

Este directorio contiene el código fuente de la aplicación Flutter de Dillearning.

## Uso

El proyecto está desarrollado usando [Flutter](https://flutter.dev/).

## Instalación / Posta en marcha

He hecho el desarrollo en Arch por lo que usaré los comandos de la distribución pero cada distribución tiene sus packages:

Instalamos jdk17:

```
$ pacman -S jdk17-openjdk
```

Instalamos android-sdk y cada una de sus tools:

```
$ yay -S android-sdk android-sdk-build-tools android-sdk-cmdline-tools-latest android-platform android-sdk-platform-tools
```

Exportamos las variables necesarias para la ejecución dependiendo de la carpeta de instalación. Añadimos en nuestro `.bashrc`:

```
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

Configuramos flutter:

```
$ flutter config --android-sdk ~/android-sdk
$ flutter doctor --android-licenses
```

En mi caso he conectado un dispositivo android y he activado [las opciones para desarrolladores en el dispositivo](https://developer.android.com/studio/debug/dev-options?hl=es-419), lo he conectado y he aceptado permisos (podemos usar emuladores también si no tenemos un dispositivo físico).

Podemos listar los dispositivos disponibles para la ejecución:

```
$ flutter devices
Found 2 connected devices:
  iPlay60 mini Pro (mobile) • T123 • android-arm64 • Android 14 (API 34)
  Linux (desktop)           • linux                • linux-x64     • Arch Linux 6.16.8-arch1-1
...
```

Y si todo está instalado correctamente, podemos ejecutarlo. Para seleccionar un dispositivo en concreto podemos usar el parámetro `-d` con su `deviceID`. Por ejemplo, para la versión de escritorio:

```
# Para ejecutar en nuestro Linux:
$ flutter run -d linux
# Para ejecutar en nuestro dispositivo android:
$ flutter run -d T123
```

Si no se especifica, se usará el por defecto:

```
$ flutter run
Resolving dependencies...
...
```

### Internacionalización (i18n)

El proyecto utiliza el sistema de localización integrado de Flutter para soportar múltiples idiomas. Las traducciones se gestionan en los ficheros `.arb` que se encuentran en `lib/l10n`.

Cada vez que se modifique o añada un fichero `.arb`, es necesario regenerar las localizaciones. Para ello, ejecuta el siguiente comando:

```
$ flutter gen-l10n
```

### Configuración del entorno (producción, dev)

Haremos uso del parámetro `--dart-define=APP_ENV=<entorno>`. para configurar el entorno donde se ejecutará la aplicación.

Los entornos disponibles son:
- `dev` (por defecto): Para desarrollo local, apunta a `http://127.0.0.1:8000`. En caso de ejecutar la aplicación en local con `flatter run` es lo que usará. Así en caso de ejecutar por ejemplo con `linux` podemos hacer pruebas.
- `docker`: Usado por el `Dockerfile` para construir la aplicación web, apunta a `/api` para que nginx actúe como proxy ya que necesitamos un servidor web luego de hacer el build. Esto es útil para cuando hacemos el build web para hacer pruebas.
- `prod`: En caso de tener nuestro backend desplegado en producción, necesitaremos sea en Android o Linux indicarle donde se encuentra nuestra API. En este caso colocamos por defecto `https://dillearning.com/api` 

![Setup](../img/setup.jpeg)

Para ejecutar el debug en web necesitaremos Chrome o Chromium instalado. Una vez hecho:

```
$ CHROME_EXECUTABLE=/usr/bin/chromium flutter run -d chrome
```
