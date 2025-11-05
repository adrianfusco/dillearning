-- Drop tables if they exist
DROP TABLE IF EXISTS user_courses;
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

-- Create user_courses table
CREATE TABLE user_courses (
    user_id INTEGER REFERENCES users(id),
    course_id INTEGER REFERENCES courses(id),
    PRIMARY KEY (user_id, course_id)
);

-- Insert sample data
INSERT INTO languages (name) VALUES ('English'), ('Spanish');

INSERT INTO courses (code, from_language_id, learning_language_id, title, description) VALUES
('en-es', 1, 2, 'Spanish from English', 'Learn Spanish from English'),
('es-en', 2, 1, 'English from Spanish', 'Aprende Inglés desde Español');

INSERT INTO units (title, "order", course_id) VALUES
('Unit 1: The Basics', 1, 1),
('Unit 2: Common Phrases', 2, 1),
('Unidad 1: Lo Básico', 1, 2),
('Unidad 2: Frases Comunes', 2, 2);

INSERT INTO concepts (title, explanation, unit_id) VALUES
('Basic Greetings', 'In Spanish, you can say "Hola" to greet someone. To say goodbye, you can say "Adiós".', 1),
('Formal and Informal Greetings', 'In Spanish, "Hola" is a general greeting. For formal situations, you might use "Buenos días" (good morning), "Buenas tardes" (good afternoon), or "Buenas noches" (good evening/night). For informal situations, you can use "¿Qué tal?" (How are you?) or "¿Cómo estás?" (How are you? - informal).', 1),
('Essential Phrases', 'Some essential phrases in Spanish are "Por favor" (Please), "Gracias" (Thank you), and "De nada" (You''re welcome).', 2),
('Asking for Directions', 'To ask for directions, you can say "¿Dónde está...?" (Where is...?). For example, "¿Dónde está el baño?" (Where is the bathroom?). To ask for help, you can say "¿Me puede ayudar?" (Can you help me?).', 2);

INSERT INTO exercises (type, prompt, answer, options, concept_id) VALUES
('multiple_choice', 'How do you say "Hello" in Spanish?', 'Hola', '["Hola", "Adiós", "Gracias", "Por favor"]', 1),
('multiple_choice', 'How do you say "Good evening" in Spanish?', 'Buenas noches', '["Buenos días", "Buenas tardes", "Buenas noches", "Hola"]', 1),
('translation', 'Translate "Good morning" to Spanish.', 'Buenos días', NULL, 2),
('translation', 'Translate "Please" to Spanish.', 'Por favor', NULL, 2),
('multiple_choice', 'How do you say "five" in Spanish?', 'cinco', '["uno", "dos", "tres", "cinco"]', 3),
('translation', 'Translate "eight" to Spanish.', 'ocho', NULL, 3),
('multiple_choice', '¿Cómo se dice "Goodbye" en Inglés?', 'Goodbye', '["Hello", "Goodbye", "Thank you", "Please"]', 4),
('translation', 'Traduce "Buenas noches" al Inglés.', 'Good night', NULL, 4);
