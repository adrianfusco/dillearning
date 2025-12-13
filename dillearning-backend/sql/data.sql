-- Drop tables if they exist
DROP TABLE IF EXISTS user_exercise_progress;
DROP TABLE IF EXISTS user_unit_progress;
DROP TABLE IF EXISTS exercises;
DROP TABLE IF EXISTS concepts;
DROP TABLE IF EXISTS units;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS languages;
DROP TABLE IF EXISTS conversations;
DROP TABLE IF EXISTS token_blocklist;
DROP TABLE IF EXISTS user_exercise_progress;
DROP TABLE IF EXISTS user_unit_progress;
DROP TABLE IF EXISTS exercises;
DROP TABLE IF EXISTS concepts;
DROP TABLE IF EXISTS units;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS languages;
DROP TABLE IF EXISTS users;

-- Create languages table
CREATE TABLE languages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);

-- Create courses table
CREATE TABLE courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT UNIQUE NOT NULL,
    from_language_id INTEGER REFERENCES languages(id),
    learning_language_id INTEGER REFERENCES languages(id),
    title TEXT NOT NULL,
    description TEXT
);

-- Create units table
CREATE TABLE units (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    course_id INTEGER REFERENCES courses(id)
);

-- Create concepts table
CREATE TABLE concepts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    explanation TEXT NOT NULL,
    unit_id INTEGER REFERENCES units(id)
);

-- Create exercises table
CREATE TABLE exercises (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL,
    prompt TEXT NOT NULL,
    answer TEXT NOT NULL,
    options TEXT, -- Storing JSON as TEXT
    concept_id INTEGER REFERENCES concepts(id)
);

-- Create users table
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    hashed_password TEXT NOT NULL
);

-- Create conversations table
CREATE TABLE conversations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL REFERENCES users(id),
    role TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create token_blocklist table
CREATE TABLE token_blocklist (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    jti TEXT UNIQUE NOT NULL,
    created_at DATETIME NOT NULL
);

-- Create user_unit_progress table
CREATE TABLE user_unit_progress (
    user_id INTEGER REFERENCES users(id),
    unit_id INTEGER REFERENCES units(id),
    completed BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (user_id, unit_id)
);

-- Create user_exercise_progress table
CREATE TABLE user_exercise_progress (
    user_id INTEGER REFERENCES users(id),
    exercise_id INTEGER REFERENCES exercises(id),
    completed BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (user_id, exercise_id)
);

-- Insert sample data
INSERT INTO languages (name) VALUES ('English'), ('Spanish'), ('Italiano');

INSERT INTO courses (code, from_language_id, learning_language_id, title, description) VALUES
('en-es', 1, 2, 'Spanish from English', 'Learn Spanish from English'),
('es-en', 2, 1, 'English from Spanish', 'Aprende Inglés desde Español'),
('es-it', 2, 3, 'Italiano desde Español', 'Aprende Italiano desde Español');

-- Spanish from English course (en-es, course_id 1)
INSERT INTO units (title, "order", course_id) VALUES
('Unit 1: The Basics', 1, 1),
('Unit 2: Common Phrases', 2, 1);

INSERT INTO concepts (title, explanation, unit_id) VALUES
('Basic Greetings', 'In Spanish, you can say "Hola" to greet someone. To say goodbye, you can say "Adiós".', 1),
('Formal and Informal Greetings', 'In Spanish, "Hola" is a general greeting. For formal situations, you might use "Buenos días" (good morning), "Buenas tardes" (good afternoon), or "Buenas noches" (good evening/night). For informal situations, you can use "¿Qué tal?" (How are you?) or "¿Cómo estás?" (How are you? - informal).', 1),
('Essential Phrases', 'Some essential phrases in Spanish are "Por favor" (Please), "Gracias" (Thank you), and "De nada" (You''re welcome).', 2),
('Asking for Directions', 'To ask for directions, you can say "¿Dónde está...?" (Where is...?). For example, "¿Dónde está el baño?" (Where is the bathroom?). To ask for help, you can say "¿Me puede ayudar?" (Can you help me?).', 2);

INSERT INTO exercises (type, prompt, answer, options, concept_id) VALUES
('multiple_choice', 'How do you say "Hello" in Spanish?', 'Hola', '["Hola", "Adiós", "Gracias", "Por favor"]', 1),
('multiple_choice', 'How do you say "Good evening" in Spanish?', 'Buenas noches', '["Buenos días", "Buenas tardes", "Buenas noches", "Hola"]', 1),
('translation', 'Translate "Good morning" to Spanish.', 'Buenos días', NULL, 2),
('translation', 'Translate "Please" to Spanish.', 'Por favor', NULL, 2);

-- English from Spanish course (es-en, course_id 2)
INSERT INTO units (title, "order", course_id) VALUES
('Unidad 1: Lo Básico', 1, 2),
('Unidad 2: Frases Comunes', 2, 2);

INSERT INTO concepts (title, explanation, unit_id) VALUES
('Saludos Básicos', 'En Inglés, puedes decir "Hello" para saludar a alguien. Para despedirse, puedes decir "Goodbye".', 3),
('Saludos Formales e Informales', 'En Inglés, "Hello" es un saludo general. Para situaciones formales, puedes usar "Good morning", "Good afternoon", o "Good evening". Para situaciones informales, se puede usar "Hi" o "Hey".', 3),
('Frases Esenciales', 'Algunas frases esenciales en Inglés son "Please", "Thank you", y "You''re welcome".', 4),
('Pidiendo Direcciones', 'Para pedir direcciones, puedes decir "Where is...?" (¿Dónde está...?). Por ejemplo, "Where is the bathroom?".', 4);

INSERT INTO exercises (type, prompt, answer, options, concept_id) VALUES
('multiple_choice', '¿Cómo se dice "Hello" en Inglés?', 'Hello', '["Hello", "Goodbye", "Thank you", "Please"]', 5),
('translation', 'Traduce "Good night" al Inglés.', 'Good night', NULL, 5),
('multiple_choice', '¿Cómo se dice "Goodbye" en Inglés?', 'Goodbye', '["Hello", "Goodbye", "Thank you", "Please"]', 6),
('translation', 'Traduce "Buenas noches" al Inglés.', 'Good night', NULL, 6);


-- Italiano from Spanish course (es-it, course_id 3)
INSERT INTO units (title, "order", course_id) VALUES
('Unidad 1: Lo Básico (Italiano)', 1, 3),
('Unidad 2: Frases Comunes (Italiano)', 2, 3);

INSERT INTO concepts (title, explanation, unit_id) VALUES
('Saludos Básicos', 'En Italiano, puedes decir "Ciao" para saludar a alguien. Para despedirse, puedes decir "Addio".', 5),
('Saludos Formales e Informales', 'En Italiano, "Ciao" es un saludo general. Para situaciones formales, puedes usar "Buongiorno" (buenos días) o "Buonasera" (buenas tardes). Para situaciones informales, se puede usar "Come stai?" (¿Cómo estás?).', 5),
('Frases Esenciales', 'Algunas frases esenciales en Italiano son "Per favore" (Por favor), "Grazie" (Gracias), y "Prego" (De nada).', 6),
('Pidiendo Direcciones', 'Para pedir direcciones, puedes decir "Dove si trova...?" (¿Dónde está...?). Por ejemplo, "Dove si trova il bagno?" (¿Dónde está el baño?).', 6);

INSERT INTO exercises (type, prompt, answer, options, concept_id) VALUES
('multiple_choice', 'How do you say "Hello" in Italian?', 'Ciao', '["Ciao", "Addio", "Grazie", "Per favore"]', 9),
('multiple_choice', 'How do you say "Good evening" in Italian?', 'Buonasera', '["Buongiorno", "Buonasera", "Ciao", "Grazie"]', 9),
('translation', 'Translate "Good morning" to Italian.', 'Buongiorno', NULL, 10),
('translation', 'Translate "Please" to Italian.', 'Per favore', NULL, 10);
