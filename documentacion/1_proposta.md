# DESENVOLVEMENTO DO PROXECTO FIN DE CICLO

## PROPOSTA IDEA DE PROXECTO

### DATOS DO/A ALUMNO/A

| NOME:             | Adrian Fusco Arnejo         | DNI:        | 54656185C                   |
| :---------------- | :-------------------------- | :---------- | :-------------------------- |
| **CONVOCATORIA:** | Diciembre 2025              | **E-MAIL:** | adrianfuscoarnejo@gmail.com |

### DATOS DO PROXECTO

**TÍTULO:** dillearning (dil del Turco idioma o lengua) - Aplicación para aprendizaje de idiomas.

**DESCRICIÓN:**

Como indica el título, la idea crear una aplicación para el aprendizaje de idiomas ya que es una de las cosas que más me gusta (inglés, italiano, turco y espero seguir incorporando más idiomas en el futuro).

No se por reinventar la rueda - hoy en día es difícil crear algo completamente original - pero el objetivo es construir una alternativa a aplicaciones como Duolingo, que con el tiempo ha perdido su enfoque pedagógico en favor de modelos más orientados a monetización.

Mi propuesta busca ofrecer una experiencia más amigable, transparente y enriquecedora para el usuario, añadiendo temas que son más orientados a un uso más realista del lenguaje.

**La idea principal y orientación del proyecto:**

- Aplicación móvil android.
- Sistema de autenticación de usuarios: registro, login y manejo seguro de sesiones.
- Diseño de la estructura del contenido: idiomas, cursos, asignaturas por curso, contenidos.
- Diseño del un sistema de seguimiento de progreso por usuario.

---

### Como extra en caso de que pueda avanzar a buen ritmo en el proyecto y tenga tiempo:

- Convertir la aplicación en multiplataforma, no solo android pero también de escritorio.
- Sistema de revisión inteligente: detección de errores en ejercicios, explicaciones generadas por IA.
- CI & CD: automatización de tests, builds para múltiples plataformas, despliegue continuo.

---

| TIPO DE APLICACIÓN: | (Marca as opcións que correspondan ou engada unha nova) |
| :------------------ | :------------------------------------------------------ |
|                     | [ ] Aplicación web.                                     |
|                     | [x] Aplicación móbil.                                   |
|                     | [ ] Aplicación de escritorio.                           |
|                     | Outro:                                                  |

| USUARIO OBXECTIVO: | (Quén empregará a aplicación? Que necesidades ten?)                                            |
| :----------------- | :--------------------------------------------------------------------------------------------- |
|                    | Cualquier tipo de usuario que quiera aprender idiomas por lo que el ámbito es bastante global. |

### TECNOLOXÍAS QUE VAS A EMPREGAR

(Linguaxes de programación, frameworks, APIs, bases de datos, etc.)

**Para la idea principal del proyecto:**

- En este caso me gustaría trabajar con Flutter ya que nunca lo he utilizado y me parece interesante para realizar aplicaciones multiplataforma. Es un framework opensource que está siendo bastante utilizado y usa el lenguaje de programación dart.
- Para la base de datos probablemente use SQLite.
- A medida que avance y aprenda sobre Flutter miraré de incorporar módulos para linters, tests, ORM, etc.
- Por supuesto añadiré su respectivo README, explicación de como ejecutar la aplicación en local, como realizar el build, como realizar el testing, uso de la aplicación y diagramas.

**Como extra en caso de que haya tiempo:**

- Para el modelo de AI que será responsable de analizar y realizar explicaciones utilizaré una instancia de ollama en local y un modelo que se adapte bastante a este caso de uso, definiré un buen prompt orientado a aprendizaje de idiomas y usaré el endpoint que suele exponer para generación de texto - en este caso solamente para eso, no me preocuparé de abstracción para usar distintos modelos - En este caso tendré una API hecha en FastAPI usando Python completamente separada del proyecto en Flutter. Para gestión avanzada de prompts usaré LangChain.

- En este caso como estamos usando GitLab tendré el CI allí configurado.
