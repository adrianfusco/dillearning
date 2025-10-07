# Anteproyecto dillearning (dil del Turco idioma o lengua) - Aplicación para aprendizaje de idiomas.

**Grupo:** DAM

**Estudiante:** Adrian Fusco Arnejo

**Tutor:** Marcos Marcos Andujar Mato

---

## Índice

1. [Descripción del proyecto](#descripción-del-proyecto)
   1. [Justificación del proyecto](#11-justificación-del-proyecto)
   2. [Estudio de necesidades](#12-estudio-de-necesidades)
   3. [Personas destinatarias](#13-personas-destinatarias)
   4. [Modelo de negocio](#14-modelo-de-negocio)
   5. [Funcionalidades del proyecto (objetivos y alcance)](#15-funcionalidades-del-proyecto-objetivos-y-alcance)
2. [Recursos](#2-recursos)
3. [Análisis de requerimientos del sistema](#3-análisis-de-requerimientos-del-sistema)
   1. [Funcionalidades](#31-funcionalidades)
   2. [Tipos de usuarios](#32-tipos-de-usuarios)
   3. [Normativa](#33-normativa)
4. [Diseño](#4-diseño)
   1. [Diseño de la arquitectura del sistema](#41-diseño-de-la-arquitectura-del-sistema)
   2. [Diseño de la persistencia de datos](#42-diseño-de-la-persistencia-de-datos)
   3. [Diseño de la interfaz de usuario](#43-diseño-de-la-interfaz-de-usuario)

---

## 1. Descripción del proyecto

El proyecto consiste en el desarrollo de una aplicación multiplataforma para el aprendizaje de idiomas. La aplicación busca ofrecer una experiencia de usuario fluida y accesible, permitiendo a los usuarios aprender nuevas lenguas de forma interactiva desde diferentes dispositivos. Incorporaremos IA a nuestra aplicación para hacerla incluso más práctica donde tendremos manera de realizar un chat en el idioma en el que estamos aprendiendo con correcciones, hacer definiciones en cuestiones de gramática, generar ejemplos de palabras u oraciones, entre otras cosas.

### 1.1. Justificación del proyecto

La idea surge de la gran demanda de aprendizaje de idiomas en un mundo cada vez más globalizado. El objetivo principal es crear una plataforma intuitiva y eficaz que motive a los usuarios a adquirir y mejorar sus competencias lingüísticas, eliminando barreras de acceso y ofreciendo flexibilidad en el proceso de aprendizaje. El proyecto pretende resolver la necesidad de disponer de una herramienta de aprendizaje de idiomas que sea a la vez completa y fácil de usar sin tener un modelo tan orientado a la monetización como lo es en otras aplicaciones.

### 1.2. Estudio de necesidades

Existen diversas aplicaciones consolidadas en el mercado del aprendizaje de idiomas, como Duolingo o Babbel. Estas plataformas sirven como referencia en cuanto a funcionalidades y modelo de negocio. Este proyecto buscará diferenciarse ofreciendo una metodología de aprendizaje específica, una interfaz de usuario innovadora, además de ser un proyecto de código abierto para que la comunidad pueda contribuir.

### 1.3. Personas destinatarias

La aplicación está dirigida a un público amplio y diverso y sin restricciones de edad. Incluye a estudiantes, profesionales que buscan mejorar sus oportunidades laborales, viajeros, y cualquier persona con interés en aprender una nueva lengua sea cual sea el motivo.

### 1.4. Modelo de negocio

El proyecto se desarrollará como software libre, aportando valor a la comunidad y permitiendo la colaboración externa. No se contempla un modelo de negocio inicial, ya que el objetivo es crear una herramienta abierta y accesible para todo el mundo.

### 1.5. Funcionalidades del proyecto (objetivos y alcance)

Las funcionalidades principales que se pretenden desarrollar son:

-   Aplicación multiplataforma: Android y Escritorio (Linux).
-   Registro y autenticación de usuarios.
-   Consulta de perfil de usuario, selección de idioma y seguimiento de progreso.
-   Múltiples idiomas que pueden ser seleccionados para el aprendizaje.
-   Lecciones interactivas organizadas por niveles de dificultad (vocabulario, gramática, ejemplos, …).
-   Ejercicios prácticos y cuestionarios para reforzar lo aprendido.
-   IA disponible con el mejor modelo LLM que se adapte a las necesidades de aprendizaje:
    -   Chat
    -   Generar ejemplos prácticos
    -   Traductor
-   Sistema de notificaciones y recordatorios para fomentar la práctica diaria.

---

## 2. Recursos

Los medios y tecnologías que se emplearán para el desarrollo del proyecto son:

-   **Lenguaje de programación:**
    -   Dart para la aplicación de escritorio y móvil.
    -   Python para nuestra API en el backend.
-   **Framework Flutter:** Para el desarrollo de la aplicación usando una base de código que luego puede ser utilizada en distintas aplicaciones.
-   **Entorno de Desarrollo (IDE):** Visual Studio Code que se puede usar perfectamente. Tenemos una guía detallada para ello: [https://docs.flutter.dev/tools/vs-code](https://docs.flutter.dev/tools/vs-code) para usar la extensión Flutter que hace de un buen trabajo: [https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
-   **Backend:**
    -   **API:**
        -   Desarrollaremos una API usando el framework FastAPI.
        -   Esquemas definidos usando pydantic que sirve como validación de datos.
        -   Servidor web vía uvicorn.
        -   ORM para mapear la base de datos con clases usando sqlalchemy
        -   Uso de la librería ollama para interactuar con el LLM.
    -   **Base de datos:** SQLite.
    -   **IA:**
        -   Como no invertiremos dinero en este caso, obviamos soluciones pagas que ofrecen mejores modelos como OpenIA o Gemini. Sería mucho más rápido, eficaz y tendríamos menos alucinaciones y más capabilities pero tendríamos que pagar por lo que en este caso usaremos ollama ([https://ollama.com/](https://ollama.com/)) y un modelo que se adapte y no necesite tantos recursos como IBM Granite 2B o Meta Llama 3.
        -   Definiremos un system prompt para cada caso para poder adaptar la IA a casos de traducción, chat, generación de ejemplos.
-   **Autenticación:** Realizaremos la autenticación vía API con datos encriptados. En un caso de producción también tendríamos HTTPS.
-   **Control de versiones:** Git. Alojaremos el código en GitLab en [https://gitlab.iessanclemente.net/damd/a23adrianfa1](https://gitlab.iessanclemente.net/damd/a23adrianfa1) y también en GitHub en [https://github.com/adrianfusco](https://github.com/adrianfusco) .
-   **Containerization:** Tendremos el backend preparado con imágenes en docker.
-   **Integración Continua (CI):** GitLab CI para la automatización de pruebas y análisis de código.
    -   Se ejecutarán linters con flutter analyze y tests para la calidad del código.
    -   Usaremos tox para el caso de nuestra API con módulos como flake, bandit e isort.
-   **Despliegue Continuo (CD):** GitLab CI/CD para automatizar el despliegue. En este caso haremos un build de la aplicación para crear artifacts que pueden ser usados en las distintas plataformas. Se desplegará la API en un servidor público. En el caso del frontend lo instalaremos a mano para no tener que pasar por Google Play.

Hay que tener en cuenta de que a medida de que se avance en el proyecto, se harán algunos cambios y puede que se cambie alguna tecnología o use algún módulo distinto

---

## 3. Análisis de requerimientos del sistema

A continuación, se describen los requerimientos del proyecto, especificando las funcionalidades.

### 3.1. Funcionalidades

#### Accion - Descripción:

**Registro de usuario**

Permite a un nuevo usuario crear una cuenta proporcionando un correo electrónico y una contraseña. El sistema validará los datos y creará el perfil en la base de datos.Esto nos servirá para poder ver nuestro progreso y poder autenticarnos desde distintos dispositivos.

**Inicio de sesión**

Un usuario registrado puede acceder a su cuenta usando sus credenciales. El sistema verifica la identidad y carga su progreso.

**Selección de idioma**

El usuario puede escoger el idioma que desea aprender de una lista de idiomas disponibles.

**Realizar lección**

El usuario accede a una lección. La lección presenta contenido (texto, imágenes) y el usuario interactúa con ello.

**Completar ejercicio**

Tras una leión, el usuario realiza un ejercicio para evaluar sus conocimientos. El sistema corrige las respuestas y proporciona feedback al usuario.

**Ver progreso**

El usuario puede consultar sus estadísticas, como lecciones completadas, puntos obtenidos y tiempo de práctica.

**Traducir con IA**

El usuario podrá traducir textos usando IA. Para ello tendremos un prompt definido para este caso de uso que se enfoque solamente en la traducción.

**Generar ejemplos con IA**

El usuario podrá solicitar ejemplos de palabras u oraciones usando IA. De igual manera tendremos un prompt enfocado en una buena gramática y buenos ejemplos.

**Chat con IA**

El usuario será capaz de tener una conversación con la IA. También tendremos un prompt destinado al chat.

Hay que tener en cuenta de que a medida de que se avance en el proyecto, se harán algunos cambios y se podrán introducir nuevas funcionalidades pero será una extensión a lo que estamos definiendo, es decir, como mejoras y extras.

### 3.2. Tipos de usuarios

**Usuario registrado:** Tiene acceso a todas las funcionalidades, puede escoger un idioma, guardar su progreso, y personalizar su perfil. Al poder tener un usuario registrado además, podremos autenticarnos desde distintos dispositivos y así no perder nuestro progreso.

No habrá un usuario administrador ya que no es necesario en este caso.

### 3.3. Normativa

El proyecto se desarrollará cumpliendo con la normativa vigente en materia de protección de datos, en particular con la Ley Orgánica 3/2018, de 5 de diciembre, de Protección de Datos Personales y garantía de los derechos digitales (LOPDPGDD) y el General Data Protection Regulation (GDPR) europeo.

Para garantizar el cumplimiento, se crearán los siguientes documentos legales accesibles para el usuario:

-   **Aviso legal:** Información sobre el titular de la aplicación.
-   **Política de privacidad:** Se detalla qué datos se recogen, con qué finalidad, y quién es el responsable del tratamiento. Se explicarán los derechos de los usuarios sobre sus datos.

---

## 4. Diseño

En esta fase inicial, el diseño se conceptualiza para ser detallado más adelante. Se emplearán herramientas estándar de la industria para su elaboración.

### 4.1. Diseño de la arquitectura del sistema

![Diseño de la arquitectura del sistema](documentacion/diagramas/arquitectura_sistema.png)

### 4.2. Diseño de la persistencia de datos

He definido las tablas y sus columnas en Inglés al igual que el código pero en el diagrama se entiende.

Puede que haya modificaciones en el esquema en un futuro.

![Diseño de la persistencia de datos](documentacion/diagramas/persistencia_datos_esquema_bd.png)

### 4.3. Diseño de la interfaz de usuario

![Diseño de la interfaz de usuario](documentacion/diagramas/interfaz_usuario.png)

Debemos recordar que, en teoría, estamos definiendo el proyecto antes de su ejecución. Esto quiere decir que a medida de que se avance pueden haber cambios para añadir nuevas funcionalidades o realizar modificaciones para mejorar lo que teníamos planteado. Por lo que puede que algunas cosas no coincidan al final del proyecto - como suele pasar en la mayoría de los casos sobre todo en proyectos grandes -.
