-- Drop tables if they exist
DROP TABLE IF EXISTS user_courses;
DROP TABLE IF EXISTS exercises;
DROP TABLE IF EXISTS lessons;
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

-- Create lessons table
CREATE TABLE lessons (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    "order" INTEGER NOT NULL,
    unit_id INTEGER REFERENCES units(id)
);

-- Create exercises table
CREATE TABLE exercises (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL,
    prompt TEXT NOT NULL,
    answer TEXT NOT NULL,
    options TEXT, -- Storing JSON as TEXT
    lesson_id INTEGER REFERENCES lessons(id)
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

INSERT INTO lessons (title, description, "order", unit_id) VALUES
('Lesson 1: Greetings', 'Learn common greetings', 1, 1),
('Lesson 2: Numbers', 'Learn numbers from 1 to 10', 2, 1),
('Lección 1: Saludos', 'Aprende saludos comunes', 1, 3),
('Lección 2: Números', 'Aprende los números del 1 al 10', 2, 3);

INSERT INTO exercises (type, prompt, answer, options, lesson_id) VALUES
('multiple_choice', 'How do you say "Hello" in Spanish?', 'Hola', '["Hola", "Adiós", "Gracias", "Por favor"]', 1),
('translation', 'Translate "Good morning" to Spanish.', 'Buenos días', NULL, 1),
('multiple_choice', '¿Cómo se dice "Goodbye" en Inglés?', 'Goodbye', '["Hello", "Goodbye", "Thank you", "Please"]', 3),
('translation', 'Traduce "Buenas noches" al Inglés.', 'Good night', NULL, 3);
