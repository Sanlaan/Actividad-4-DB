CREATE DATABASE veterinaria;
USE veterinaria;

CREATE TABLE propietarios (
    id_propietario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100),
    direccion TEXT,
    fecha_registro DATE DEFAULT (CURRENT_DATE)
);

-- CREAR TABLA MASCOTAS
CREATE TABLE mascotas (
    id_mascota INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    raza VARCHAR(50),
    edad INT,
    peso DECIMAL(5,2),
    color VARCHAR(30),
    id_propietario INT NOT NULL,
    fecha_registro DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (id_propietario) REFERENCES propietarios(id_propietario)
);

-- CREAR TABLA VETERINARIOS
CREATE TABLE veterinarios (
    id_veterinario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cedula_profesional VARCHAR(20) UNIQUE,
    especialidad VARCHAR(100),
    telefono VARCHAR(15),
    email VARCHAR(100)
);

-- CREAR TABLA CITAS
CREATE TABLE citas (
    id_cita INT PRIMARY KEY AUTO_INCREMENT,
    fecha_cita DATE NOT NULL,
    hora_cita TIME NOT NULL,
    motivo TEXT,
    estado VARCHAR(20) DEFAULT 'Programada',
    id_mascota INT NOT NULL,
    id_veterinario INT NOT NULL,
    FOREIGN KEY (id_mascota) REFERENCES mascotas(id_mascota),
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id_veterinario)
);

-- CREAR TABLA TRATAMIENTOS
CREATE TABLE tratamientos (
    id_tratamiento INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tratamiento VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2),
    duracion_minutos INT
);

-- CREAR TABLA HISTORIAL MÉDICO
CREATE TABLE historial_medico (
    id_historial INT PRIMARY KEY AUTO_INCREMENT,
    fecha_consulta DATE NOT NULL,
    diagnostico TEXT,
    observaciones TEXT,
    peso_actual DECIMAL(5,2),
    temperatura DECIMAL(4,1),
    id_mascota INT NOT NULL,
    id_veterinario INT NOT NULL,
    id_tratamiento INT,
    FOREIGN KEY (id_mascota) REFERENCES mascotas(id_mascota),
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id_veterinario),
    FOREIGN KEY (id_tratamiento) REFERENCES tratamientos(id_tratamiento)
);
