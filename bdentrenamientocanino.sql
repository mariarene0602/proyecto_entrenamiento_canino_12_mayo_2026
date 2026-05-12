-- ============================================================
--  Base de datos: Negocio de Entrenamiento Canino
--  Motor: MySQL 8.0 / MariaDB 10.6+
--  Generado: 2026
-- ============================================================

CREATE DATABASE IF NOT EXISTS bdentrenamientocanino
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE bdentrenamientocanino;

-- ------------------------------------------------------------
-- 1. CLIENTE
-- ------------------------------------------------------------
CREATE TABLE cliente (
    id               INT            NOT NULL AUTO_INCREMENT,
    nombre           VARCHAR(80)    NOT NULL,
    apellido         VARCHAR(80)    NOT NULL,
    telefono         VARCHAR(20),
    email            VARCHAR(120)   UNIQUE,
    direccion        VARCHAR(200),
    fecha_registro   DATE           NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_cliente PRIMARY KEY (id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 2. ENTRENADOR
-- ------------------------------------------------------------
CREATE TABLE entrenador (
    id               INT            NOT NULL AUTO_INCREMENT,
    nombre           VARCHAR(80)    NOT NULL,
    apellido         VARCHAR(80)    NOT NULL,
    especialidad     VARCHAR(100),
    certificaciones  TEXT,
    telefono         VARCHAR(20),
    tarifa_hora      DECIMAL(10,2),
    activo           BOOLEAN        NOT NULL DEFAULT TRUE,
    CONSTRAINT pk_entrenador PRIMARY KEY (id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 3. INSTALACION
-- ------------------------------------------------------------
CREATE TABLE instalacion (
    id               INT            NOT NULL AUTO_INCREMENT,
    nombre           VARCHAR(80)    NOT NULL,
    tipo             VARCHAR(50)    COMMENT 'agility | sala | exterior | domicilio',
    capacidad        INT,
    disponible       BOOLEAN        NOT NULL DEFAULT TRUE,
    CONSTRAINT pk_instalacion PRIMARY KEY (id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 4. SERVICIO
-- ------------------------------------------------------------
CREATE TABLE servicio (
    id               INT            NOT NULL AUTO_INCREMENT,
    nombre           VARCHAR(100)   NOT NULL,
    descripcion      TEXT,
    tipo             VARCHAR(50)    COMMENT 'individual | grupal | domicilio',
    duracion_min     INT,
    precio_base      DECIMAL(10,2)  NOT NULL,
    CONSTRAINT pk_servicio PRIMARY KEY (id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 5. PAQUETE
-- ------------------------------------------------------------
CREATE TABLE paquete (
    id               INT            NOT NULL AUTO_INCREMENT,
    servicio_id      INT            NOT NULL,
    nombre           VARCHAR(100)   NOT NULL,
    num_sesiones     INT            NOT NULL,
    precio_total     DECIMAL(10,2)  NOT NULL,
    vigencia_dias    INT,
    CONSTRAINT pk_paquete   PRIMARY KEY (id),
    CONSTRAINT fk_paquete_servicio
        FOREIGN KEY (servicio_id) REFERENCES servicio (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 6. MASCOTA
-- ------------------------------------------------------------
CREATE TABLE mascota (
    id                   INT         NOT NULL AUTO_INCREMENT,
    cliente_id           INT         NOT NULL,
    nombre               VARCHAR(60) NOT NULL,
    raza                 VARCHAR(80),
    edad_meses           INT,
    sexo                 CHAR(1)     COMMENT 'M = Macho | H = Hembra',
    nivel_entrenamiento  VARCHAR(30) COMMENT 'basico | intermedio | avanzado',
    observaciones        TEXT,
    CONSTRAINT pk_mascota PRIMARY KEY (id),
    CONSTRAINT fk_mascota_cliente
        FOREIGN KEY (cliente_id) REFERENCES cliente (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 7. CONTRATACION
-- ------------------------------------------------------------
CREATE TABLE contratacion (
    id                INT          NOT NULL AUTO_INCREMENT,
    cliente_id        INT          NOT NULL,
    paquete_id        INT          NOT NULL,
    fecha_compra      DATE         NOT NULL,
    fecha_vencimiento DATE,
    sesiones_usadas   INT          NOT NULL DEFAULT 0,
    estado            VARCHAR(20)  NOT NULL DEFAULT 'activo'
                                   COMMENT 'activo | vencido | completado',
    CONSTRAINT pk_contratacion PRIMARY KEY (id),
    CONSTRAINT fk_contratacion_cliente
        FOREIGN KEY (cliente_id) REFERENCES cliente (id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_contratacion_paquete
        FOREIGN KEY (paquete_id) REFERENCES paquete (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 8. PAGO
-- ------------------------------------------------------------
CREATE TABLE pago (
    id               INT            NOT NULL AUTO_INCREMENT,
    contratacion_id  INT            NOT NULL,
    fecha            DATE           NOT NULL,
    monto            DECIMAL(10,2)  NOT NULL,
    metodo           VARCHAR(30)    COMMENT 'efectivo | tarjeta | transferencia',
    referencia       VARCHAR(80),
    estado           VARCHAR(20)    NOT NULL DEFAULT 'completado'
                                    COMMENT 'pendiente | completado | cancelado',
    CONSTRAINT pk_pago PRIMARY KEY (id),
    CONSTRAINT fk_pago_contratacion
        FOREIGN KEY (contratacion_id) REFERENCES contratacion (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 9. SESION
-- ------------------------------------------------------------
CREATE TABLE sesion (
    id               INT          NOT NULL AUTO_INCREMENT,
    mascota_id       INT          NOT NULL,
    entrenador_id    INT          NOT NULL,
    servicio_id      INT          NOT NULL,
    contratacion_id  INT          NULL COMMENT 'NULL si la sesion es suelta (sin paquete)',
    fecha_hora       DATETIME     NOT NULL,
    duracion_real_min INT,
    estado           VARCHAR(20)  NOT NULL DEFAULT 'programada'
                                  COMMENT 'programada | realizada | cancelada',
    notas            TEXT,
    CONSTRAINT pk_sesion PRIMARY KEY (id),
    CONSTRAINT fk_sesion_mascota
        FOREIGN KEY (mascota_id) REFERENCES mascota (id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_sesion_entrenador
        FOREIGN KEY (entrenador_id) REFERENCES entrenador (id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_sesion_servicio
        FOREIGN KEY (servicio_id) REFERENCES servicio (id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_sesion_contratacion
        FOREIGN KEY (contratacion_id) REFERENCES contratacion (id)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 10. RESERVACION
-- ------------------------------------------------------------
CREATE TABLE reservacion (
    id               INT       NOT NULL AUTO_INCREMENT,
    sesion_id        INT       NOT NULL,
    instalacion_id   INT       NOT NULL,
    inicio           DATETIME  NOT NULL,
    fin              DATETIME  NOT NULL,
    CONSTRAINT pk_reservacion PRIMARY KEY (id),
    CONSTRAINT fk_reservacion_sesion
        FOREIGN KEY (sesion_id) REFERENCES sesion (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_reservacion_instalacion
        FOREIGN KEY (instalacion_id) REFERENCES instalacion (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 11. PROGRESO
-- ------------------------------------------------------------
CREATE TABLE progreso (
    id               INT         NOT NULL AUTO_INCREMENT,
    mascota_id       INT         NOT NULL,
    sesion_id        INT         NOT NULL,
    habilidad        VARCHAR(80) NOT NULL,
    puntuacion       INT         CHECK (puntuacion BETWEEN 1 AND 10),
    observaciones    TEXT,
    fecha            DATE        NOT NULL,
    CONSTRAINT pk_progreso PRIMARY KEY (id),
    CONSTRAINT fk_progreso_mascota
        FOREIGN KEY (mascota_id) REFERENCES mascota (id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_progreso_sesion
        FOREIGN KEY (sesion_id) REFERENCES sesion (id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--  DATOS DE PRUEBA
-- ============================================================

-- Clientes
INSERT INTO cliente (nombre, apellido, telefono, email, direccion, fecha_registro) VALUES
('Ana',    'García',    '656-100-001', 'ana.garcia@email.com',    'Av. Juárez 12, Col. Centro',    '2026-01-10'),
('Luis',   'Martínez',  '656-100-002', 'luis.martinez@email.com', 'Calle Nogal 45, Col. Las Flores', '2026-02-14'),
('Sofía',  'Hernández', '656-100-003', 'sofia.h@email.com',       'Paseo del Pino 78, Col. Jardines', '2026-03-05');

-- Entrenadores
INSERT INTO entrenador (nombre, apellido, especialidad, certificaciones, telefono, tarifa_hora, activo) VALUES
('Carlos', 'Romero', 'Obediencia básica y avanzada', 'IACP Certified Dog Trainer', '656-200-001', 350.00, TRUE),
('Paola',  'Ríos',   'Agility y deportes caninos',   'AKC Canine Good Citizen',    '656-200-002', 400.00, TRUE);

-- Instalaciones
INSERT INTO instalacion (nombre, tipo, capacidad, disponible) VALUES
('Pista de Agility',   'agility',  8,  TRUE),
('Sala de Obediencia', 'sala',     12, TRUE),
('Jardín Exterior',    'exterior', 20, TRUE);

-- Servicios
INSERT INTO servicio (nombre, descripcion, tipo, duracion_min, precio_base) VALUES
('Obediencia Básica',    'Comandos fundamentales: sentado, quieto, aquí', 'individual', 60,  300.00),
('Agility Principiantes','Introducción a obstáculos y circuitos',          'grupal',     90,  250.00),
('Adiestramiento a Domicilio', 'Sesión personalizada en el hogar del cliente', 'domicilio', 60, 500.00);

-- Paquetes
INSERT INTO paquete (servicio_id, nombre, num_sesiones, precio_total, vigencia_dias) VALUES
(1, 'Pack Básico 5 sesiones',   5,  1300.00, 60),
(1, 'Pack Básico 10 sesiones', 10,  2500.00, 90),
(2, 'Pack Agility Mensual',     8,  1800.00, 30);

-- Mascotas
INSERT INTO mascota (cliente_id, nombre, raza, edad_meses, sexo, nivel_entrenamiento, observaciones) VALUES
(1, 'Max',   'Labrador Retriever', 18, 'M', 'basico',      'Muy enérgico, requiere paciencia'),
(2, 'Luna',  'Border Collie',      24, 'H', 'intermedio',  'Aprende rápido, ideal para agility'),
(3, 'Rocky', 'Pastor Alemán',      36, 'M', 'avanzado',    'Entrenamiento previo en obediencia');

-- Contrataciones
INSERT INTO contratacion (cliente_id, paquete_id, fecha_compra, fecha_vencimiento, sesiones_usadas, estado) VALUES
(1, 1, '2026-04-01', '2026-05-31', 3, 'activo'),
(2, 3, '2026-04-10', '2026-05-10', 5, 'activo'),
(3, 2, '2026-03-01', '2026-05-30', 10,'completado');

-- Pagos
INSERT INTO pago (contratacion_id, fecha, monto, metodo, referencia, estado) VALUES
(1, '2026-04-01', 1300.00, 'tarjeta',     'TXN-20260401-001', 'completado'),
(2, '2026-04-10', 1800.00, 'transferencia','REF-20260410-002', 'completado'),
(3, '2026-03-01', 2500.00, 'efectivo',     NULL,               'completado');

-- Sesiones
INSERT INTO sesion (mascota_id, entrenador_id, servicio_id, contratacion_id, fecha_hora, duracion_real_min, estado, notas) VALUES
(1, 1, 1, 1, '2026-04-05 10:00:00', 60, 'realizada', 'Buen avance en comando sentado'),
(1, 1, 1, 1, '2026-04-12 10:00:00', 55, 'realizada', 'Practica quieto y aquí'),
(2, 2, 2, 2, '2026-04-15 09:00:00', 90, 'realizada', 'Completa circuito básico sin errores'),
(1, 1, 1, 1, '2026-05-10 10:00:00', NULL, 'programada', NULL);

-- Reservaciones
INSERT INTO reservacion (sesion_id, instalacion_id, inicio, fin) VALUES
(1, 2, '2026-04-05 10:00:00', '2026-04-05 11:00:00'),
(2, 2, '2026-04-12 10:00:00', '2026-04-12 11:00:00'),
(3, 1, '2026-04-15 09:00:00', '2026-04-15 10:30:00'),
(4, 2, '2026-05-10 10:00:00', '2026-05-10 11:00:00');

-- Progreso
INSERT INTO progreso (mascota_id, sesion_id, habilidad, puntuacion, observaciones, fecha) VALUES
(1, 1, 'Sentado',  7, 'Responde bien al comando verbal',      '2026-04-05'),
(1, 1, 'Quieto',   5, 'Necesita refuerzo, se distrae',        '2026-04-05'),
(1, 2, 'Aquí',     6, 'Mejora notable respecto a sesión 1',   '2026-04-12'),
(2, 3, 'Agility',  9, 'Excelente coordinación y velocidad',   '2026-04-15');

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
