//1- Creo la base de datos
CREATE DATABASE IF NOT EXISTS ValiPass;
//2- Creo las tablas
USE ValiPass;

-- 1. Tabla: Puesto
CREATE TABLE Puesto (
    PuestoID INT PRIMARY KEY AUTO_INCREMENT,
    NombrePuesto VARCHAR(255) NOT NULL,
    CompetenciasTecnicas TEXT,
    CompetenciasBlandas TEXT,
    ExperienciaMinima INT,
    Descripcion TEXT,
    SalarioBase DECIMAL(10, 2)
);

-- 2. Tabla: ProcesoSeleccion
CREATE TABLE ProcesoSeleccion (
    ProcesoID INT PRIMARY KEY AUTO_INCREMENT,
    EmpleadoID INT,
    FechaInicio DATE NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    VerificacionAntecedentes BOOLEAN DEFAULT 0,
    EntrevistaPreliminar BOOLEAN DEFAULT 0,
    EvaluacionTecnica BOOLEAN DEFAULT 0,
    EntrevistaFinal BOOLEAN DEFAULT 0,
    AprobacionGerente BOOLEAN DEFAULT 0,
    FOREIGN KEY (EmpleadoID) REFERENCES empleados(EmpleadoID)
);

-- 3. Tabla: Capacitacion
CREATE TABLE Capacitacion (
    CapacitacionID INT PRIMARY KEY AUTO_INCREMENT,
    NombreCapacitacion VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    FechaInicio DATE NOT NULL,
    FechaFin DATE,
    EsInduccion BOOLEAN DEFAULT 0
);

-- 4. Tabla: CapacitacionEmpleado
CREATE TABLE CapacitacionEmpleado (
    CapacitacionEmpleadoID INT PRIMARY KEY AUTO_INCREMENT,
    EmpleadoID INT,
    CapacitacionID INT,
    ResultadoEvaluacion DECIMAL(5, 2),
    FechaCapacitacion DATE,
    FOREIGN KEY (EmpleadoID) REFERENCES empleados(EmpleadoID),
    FOREIGN KEY (CapacitacionID) REFERENCES Capacitacion(CapacitacionID)
);

-- 5. Tabla: DesarrolloEmpleado
CREATE TABLE DesarrolloEmpleado (
    DesarrolloID INT PRIMARY KEY AUTO_INCREMENT,
    EmpleadoID INT,
    ProgramaDesarrollo VARCHAR(255),
    FechaInicio DATE NOT NULL,
    FechaFin DATE,
    Observaciones TEXT,
    FOREIGN KEY (EmpleadoID) REFERENCES empleados(EmpleadoID)
);

-- 6. Tabla: Bienestar
CREATE TABLE Bienestar (
    BienestarID INT PRIMARY KEY AUTO_INCREMENT,
    NombrePrograma VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    FechaInicio DATE NOT NULL,
    FechaFin DATE
);

-- 7. Tabla: BienestarEmpleado
CREATE TABLE BienestarEmpleado (
    BienestarEmpleadoID INT PRIMARY KEY AUTO_INCREMENT,
    EmpleadoID INT,
    BienestarID INT,
    ParticipacionFecha DATE NOT NULL,
    FOREIGN KEY (EmpleadoID) REFERENCES empleados(EmpleadoID),
    FOREIGN KEY (BienestarID) REFERENCES Bienestar(BienestarID)
);

-- 8. Tabla: ClimaLaboral
CREATE TABLE ClimaLaboral (
    ClimaID INT PRIMARY KEY AUTO_INCREMENT,
    EmpleadoID INT,
    FechaEvaluacion DATE NOT NULL,
    Satisfaccion INT CHECK(Satisfaccion BETWEEN 1 AND 10),
    Comentarios TEXT,
    FOREIGN KEY (EmpleadoID) REFERENCES empleados(EmpleadoID)
);

-- 9. Tabla: Reconocimiento
CREATE TABLE Reconocimiento (
    ReconocimientoID INT PRIMARY KEY AUTO_INCREMENT,
    EmpleadoID INT,
    DescripcionReconocimiento TEXT NOT NULL,
    FechaReconocimiento DATE NOT NULL,
    TipoIncentivo VARCHAR(100),
    FOREIGN KEY (EmpleadoID) REFERENCES empleados(EmpleadoID)
);
--10. Tabla: Emplea
CREATE TABLE empleados (
EmpleadoID INT PRIMARY KEY,
NombreCompleto VARCHAR(100),
FechaNacimiento DATE,
Email VARCHAR(100),
Telefono VARCHAR(100),
Direccion VARCHAR(100),
FechaContratacion DATE,
FechaFinalContrato DATE,
Estado VARCHAR(100),
PuestoID INT FK,
NivelAcceso VARCHAR(25),
FOREIGN KEY (PuestoID) REFERENCES Puesto(PuestoId)
);

//Inserts con los datos
//Tabla Empleado
INSERT INTO empleados (NombreCompleto, FechaNacimiento, Email, Telefono, Direccion, FechaContratacion, FechaFinalContrato, Estado, PuestoID, NivelAcceso)
VALUES
('Juan Pérez', '1990-04-12', 'juan.perez@empresa.com', '555-1234', 'Calle Falsa 123, Ciudad', '2022-01-15', '2025-01-15', 'activo', 1, 'empleado'),
('Ana Gómez', '1985-11-25', 'ana.gomez@empresa.com', '555-5678', 'Av. Siempre Viva 456, Ciudad', '2021-03-10', NULL, 'activo', 2, 'gerente'),
('Carlos Ruiz', '1995-08-19', 'carlos.ruiz@empresa.com', '555-8765', 'Calle Luna 789, Ciudad', '2023-06-01', '2024-06-01', 'en prueba', 3, 'empleado'),
('María Fernández', '1992-02-05', 'maria.fernandez@empresa.com', '555-4321', 'Calle Sol 101, Ciudad', '2021-09-20', NULL, 'activo', 4, 'administrador'),
('José Martínez', '1988-12-30', 'jose.martinez@empresa.com', '555-3456', 'Av. Las Flores 202, Ciudad', '2020-11-05', '2023

//Tabla Puesto
INSERT INTO Puesto (NombrePuesto, CompetenciasTecnicas, CompetenciasBlandas, ExperienciaMinima, Descripcion, SalarioBase)
VALUES 
('Desarrollador', 'Java, SQL, APIs', 'Trabajo en equipo, Comunicación', 2, 'Desarrollador backend junior', 35000.00),
('Gerente de Proyecto', 'Gestión de proyectos, Scrum', 'Liderazgo, Organización', 5, 'Responsable de gestionar proyectos', 60000.00),
('Analista de Datos', 'Python, SQL, Machine Learning', 'Pensamiento analítico, Resolución de problemas', 3, 'Analizar datos y crear informes', 45000.00),
('Diseñador UX', 'Adobe XD, Figma, HTML/CSS', 'Empatía, Creatividad', 4, 'Diseñar interfaces centradas en el usuario', 40000.00),
('Soporte Técnico', 'Redes, Hardware, Diagnóstico', 'Atención al cliente, Resolución de problemas', 1, 'Soporte a usuarios de la empresa', 30000.00);

//Tabla Proceso Selección
INSERT INTO ProcesoSeleccion (EmpleadoID, FechaInicio, Estado, VerificacionAntecedentes, EntrevistaPreliminar, EvaluacionTecnica, EntrevistaFinal, AprobacionGerente)
VALUES 
(1, '2024-01-10', 'En Progreso', 1, 1, 0, 0, 0),
(2, '2024-02-15', 'Aprobado', 1, 1, 1, 1, 1),
(3, '2024-03-20', 'Rechazado', 0, 1, 1, 0, 0),
(4, '2024-04-25', 'En Progreso', 1, 1, 1, 0, 0),
(5, '2024-05-05', 'Aprobado', 1, 1, 1, 1, 1);

//Tabla Reconocimiento
INSERT INTO Reconocimiento (EmpleadoID, DescripcionReconocimiento, FechaReconocimiento, TipoIncentivo)
VALUES 
(1, 'Mejor Desarrollador del Mes', '2024-06-01', 'Económico'),
(2, 'Liderazgo en Gestión de Proyectos', '2024-07-01', 'No Monetario'),
(3, 'Reconocimiento por Innovación', '2024-08-01', 'Económico'),
(4, 'Excelente Atención al Cliente', '2024-09-01', 'No Monetario'),
(5, 'Mejor Desempeño en Análisis de Datos', '2024-10-01', 'Económico');

//Tabla Bienestar
INSERT INTO Bienestar (NombrePrograma, Descripcion, FechaInicio, FechaFin)
VALUES 
('Programa de Salud y Bienestar', 'Promoción de la salud física y mental', '2024-01-01', '2024-12-31'),
('Programa de Equilibrio Trabajo-Vida', 'Actividades para equilibrar la vida personal y laboral', '2024-01-15', '2024-11-30'),
('Plan de Nutrición Corporativa', 'Servicios de nutrición y comida saludable', '2024-02-01', '2024-12-31'),
('Yoga y Meditación', 'Clases de yoga y meditación para reducir el estrés', '2024-03-01', '2024-12-31'),
('Subsidio de Gimnasio', 'Acceso a gimnasios con descuento', '2024-04-01', '2024-12-31');

//Tabla Bienestar Empleado
INSERT INTO BienestarEmpleado (EmpleadoID, BienestarID, ParticipacionFecha)
VALUES 
(1, 1, '2024-06-15'),
(2, 2, '2024-06-20'),
(3, 3, '2024-07-01'),
(4, 4, '2024-07-05'),
(5, 5, '2024-07-10');

//Tabla Desarrollo Empleado
INSERT INTO DesarrolloEmpleado (EmpleadoID, ProgramaDesarrollo, FechaInicio, FechaFin, Observaciones)
VALUES 
(1, 'Programa de Liderazgo', '2024-05-01', '2024-08-01', 'Demuestra habilidades sólidas de liderazgo'),
(2, 'Curso de Data Science Avanzado', '2024-06-01', '2024-09-01', 'Gran capacidad para manejar grandes conjuntos de datos'),
(3, 'Capacitación en Gestión de Proyectos', '2024-07-01', '2024-10-01', 'Ha mejorado la capacidad de gestión de tiempo'),
(4, 'Programa de Innovación', '2024-08-01', NULL, 'Muestra gran iniciativa en nuevos proyectos'),
(5, 'Desarrollo en Atención al Cliente', '2024-09-01', '2024-12-01', 'Excelente mejora en la satisfacción de clientes');

//Tabla Capacitación Empleado
INSERT INTO CapacitacionEmpleado (EmpleadoID, CapacitacionID, ResultadoEvaluacion, FechaCapacitacion)
VALUES 
(1, 1, 9.5, '2024-06-01'),
(2, 2, 8.7, '2024-06-10'),
(3, 3, 9.0, '2024-06-15'),
(4, 4, 7.8, '2024-06-20'),
(5, 5, 9.3, '2024-06-25');


//15 consultas
//1. Listar empleados con su puesto actual
SELECT e.EmpleadoID, e.NombreCompleto, p.NombrePuesto
FROM empleados e
JOIN puesto p ON e.PuestoID = p.PuestoID;
//2. Listar empleados y el estado de su proceso de selección
SELECT e.EmpleadoID, e.NombreCompleto, ps.Estado
FROM empleados e
JOIN ProcesoSeleccion ps ON e.EmpleadoID = ps.EmpleadoID;
//3. Empleados que completaron la verificación de antecedentes en el proceso de selección
SELECT e.EmpleadoID, e.NombreCompleto, ps.FechaInicio, ps.Estado
FROM empleados e
JOIN ProcesoSeleccion ps ON e.EmpleadoID = ps.EmpleadoID
WHERE ps.VerificacionAntecedentes = 1;
//4. Capacitaciones de empleados y sus resultados
SELECT e.EmpleadoID, e.NombreCompleto, c.NombreCapacitacion, ce.ResultadoEvaluacion
FROM empleados e
JOIN CapacitacionEmpleado ce ON e.EmpleadoID = ce.EmpleadoID
JOIN Capacitacion c ON ce.CapacitacionID = c.CapacitacionID;
// 5. Empleados que participaron en programas de bienestar
SELECT e.EmpleadoID, e.NombreCompleto, b.NombrePrograma, be.ParticipacionFecha
FROM empleados e
JOIN BienestarEmpleado be ON e.EmpleadoID = be.EmpleadoID
JOIN Bienestar b ON be.BienestarID = b.BienestarID;
//6. Empleados con sueldos base superiores a 50,000
SELECT e.EmpleadoID, e.NombreCompleto, p.SalarioBase
FROM empleados e
JOIN puesto p ON e.PuestoID = p.PuestoID
WHERE p.SalarioBase > 50000;
//7. Reconocimientos otorgados a empleados
SELECT e.EmpleadoID, e.NombreCompleto, r.DescripcionReconocimiento, r.FechaReconocimiento
FROM empleados e
JOIN Reconocimiento r ON e.EmpleadoID = r.EmpleadoID;
//8. Programas de desarrollo en los que han participado empleados
SELECT e.EmpleadoID, e.NombreCompleto, de.ProgramaDesarrollo, de.FechaInicio
FROM empleados e
JOIN DesarrolloEmpleado de ON e.EmpleadoID = de.EmpleadoID;
//9. Empleados con puntuación de satisfacción mayor a 8 en clima laboral
SELECT e.EmpleadoID, e.NombreCompleto, cl.Satisfaccion
FROM empleados e
JOIN ClimaLaboral cl ON e.EmpleadoID = cl.EmpleadoID
WHERE cl.Satisfaccion > 8;
//10. Empleados cuya contratación se realizó en los últimos 6 meses
SELECT e.EmpleadoID, e.NombreCompleto, e.FechaContratacion, p.NombrePuesto
FROM empleados e
JOIN puesto p ON e.PuestoID = p.PuestoID
WHERE e.FechaContratacion >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
//11. Empleados con entrevistas finales completadas en el proceso de selección
SELECT e.EmpleadoID, e.NombreCompleto, ps.FechaInicio, ps.Estado
FROM empleados e
JOIN ProcesoSeleccion ps ON e.EmpleadoID = ps.EmpleadoID
WHERE ps.EntrevistaFinal = 1;
//12. Capacitaciones que forman parte del proceso de inducción obligatoria
SELECT c.NombreCapacitacion, c.Descripcion, c.FechaInicio, c.FechaFin
FROM Capacitacion c
WHERE c.EsInduccion = 1;
//13. Empleados que completaron programas de desarrollo con observaciones positivas
SELECT e.EmpleadoID, e.NombreCompleto, de.ProgramaDesarrollo, de.Observaciones
FROM empleados e
JOIN DesarrolloEmpleado de ON e.EmpleadoID = de.EmpleadoID
WHERE de.Observaciones IS NOT NULL;
//14. Empleados que recibieron reconocimientos monetarios
SELECT e.EmpleadoID, e.NombreCompleto, r.DescripcionReconocimiento, r.TipoIncentivo
FROM empleados e
JOIN Reconocimiento r ON e.EmpleadoID = r.EmpleadoID
WHERE r.TipoIncentivo = 'económico';
//15. Capacitaciones recibidas por empleados y su fecha de participación
SELECT e.EmpleadoID, e.NombreCompleto, c.NombreCapacitacion, ce.FechaCapacitacion
FROM empleados e
JOIN CapacitacionEmpleado ce ON e.EmpleadoID = ce.EmpleadoID
JOIN Capacitacion c ON ce.CapacitacionID = c.CapacitacionID;

