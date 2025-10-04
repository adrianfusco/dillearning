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
Downloading packages...
  characters 1.4.0 (1.4.1 available)
  flutter_lints 5.0.0 (6.0.0 available)
  lints 5.1.1 (6.0.0 available)
  material_color_utilities 0.11.1 (0.13.0 available)
  meta 1.16.0 (1.17.0 available)
  test_api 0.7.6 (0.7.7 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Launching lib/main.dart on iPlay60 mini Pro in debug mode...
Running Gradle task 'assembleDebug'...                              4.0s
✓ Built build/app/outputs/flutter-apk/app-debug.apk
Installing build/app/outputs/flutter-apk/app-debug.apk...           6.5s
D/FlutterJNI(23513): Beginning load of flutter...
D/FlutterJNI(23513): flutter (null) was loaded normally!
I/flutter (23513): [IMPORTANT:flutter/shell/platform/android/android_context_vk_impeller.cc(62)] Using the Impeller rendering backend (Vulkan).
Syncing files to device iPlay60 mini Pro...                         44ms

Flutter run key commands.
r Hot reload. 🔥🔥🔥
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).
```

![Setup](../img/setup.jpeg)

Para ejecutar el debug en web necesitaremos Chrome o Chromium instalado. Una vez hecho:

```
$ CHROME_EXECUTABLE=/usr/bin/chromium flutter run -d chrome
```
