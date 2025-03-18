CREATE DATABASE booking_db;
\c booking_db;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    duration INTERVAL NOT NULL CHECK (duration > '0 min'),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE availability (
    availability_id SERIAL PRIMARY KEY,
    service_id INT REFERENCES services(service_id) ON DELETE CASCADE,
    weekday INT NOT NULL CHECK (weekday BETWEEN 1 AND 7),
    start_time TIME NOT NULL,
    end_time TIME NOT NULL CHECK (end_time > start_time)
);

CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    service_id INT REFERENCES services(service_id) ON DELETE CASCADE,
    appointment_date DATE NOT NULL CHECK (appointment_date >= NOW()),
    appointment_time TIME NOT NULL,
    status VARCHAR(20) CHECK (status IN ('scheduled', 'completed', 'canceled')),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (name, email, phone) VALUES
('Олександр Іваненко', 'o.ivanenko@gmail.com', '+380501234567'),
('Марія Петренко', 'm.petrenko@gmail.com.com', '+380971234567');

INSERT INTO services (name, description, duration, price) VALUES
('Консультація', 'Консультація з фахівцем', '00:30:00', 500.00),
('Лікування зубів', 'Повний цикл лікування', '01:00:00', 1500.00);

INSERT INTO availability (service_id, weekday, start_time, end_time) VALUES
(1, 1, '09:00', '17:00'),
(2, 3, '10:00', '18:00');

INSERT INTO appointments (user_id, service_id, appointment_date, appointment_time, status) VALUES
(1, 1, '2025-03-20', '09:30', 'scheduled'),
(2, 2, '2025-03-22', '11:00', 'scheduled');
