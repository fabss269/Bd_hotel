--------------------------------------------------- INSERTAR DATOS -----------------------------------------------------------

-- 1. Tabla pais
INSERT INTO pais (codigo_pais, nombre) VALUES
('008', 'Albania'),
('276', 'Alemania'),
('020', 'Andorra'),
('682', 'Arabia Saudita'),
('012', 'Argelia'),
('032', 'Argentina'),
('036', 'Australia'),
('040', 'Austria'),
('056', 'Bélgica'),
('058', 'Bélgica-Luxemburgo'),
('084', 'Belice'),
('068', 'Bolivia'),
('070', 'Bosnia y Herzegovina'),
('484', 'México'),
('604','Perú');

select*from pais;

-- 2. Tabla categoria_habitacion
INSERT INTO categoria_habitacion (nombre_categoria, precio_categoria) VALUES
('Economica', 50.00),
('Estándar', 75.00),
('Lujo', 150.00);

select*from categoria_habitacion;

-- 3. Tabla tipo_empresa
INSERT INTO tipo_empresa (nombre_tipo) VALUES
('Tecnología'),
('Consultoría'),
('Manufactura');
select*from tipo_empresa;

-- 4. Tabla servicio (no tiene dependencia)
INSERT INTO servicio (descricpion_servicio) VALUES
('Alojamiento'),
('Restaurante'),
('Cochera'),
('Transporte');

-- 5. Tabla motivo_viaje
INSERT INTO motivo_viaje (descripcion_motivo) VALUES
('Vacaciones'),
('Negocios'),
('Conferencia');

-- 7. Tabla empleado
INSERT INTO empleado (dni_empleado, apellido_pat, ape_materno, nombres, sexo, movil) VALUES
('12345678', 'Pérez', 'Gómez', 'Juan', 'M', '+51456456456'),
('87654321', 'López', 'Martínez', 'Ana', 'F', '+51232323232');
select * from empleado;

-- 8. Tabla cliente
INSERT INTO cliente (direccion, telefono, tipo_doc, numero_documento, pais_codigo_pais) VALUES
('123 Calle Falsa', '+51451456456', 'DNI', '12345678A', '032'),
('456 Avenida Real', '+5111111111', 'Pasaporte', 'A1234567', '040'),
('789 Camino Verde', '+5122122222', 'DNI', '87654321B', '604'),
('789 Kha Verde', '+12315312311', 'RUC', '12311236521', '040');
select * from cliente;

-- 10. Tabla persona
INSERT INTO persona (cliente_id, ape_paterno, ape_materno, nombres, sexo) VALUES
(4, 'Smith', 'Johnson', 'Michael', 'M'),
(3, 'Brown', 'Williams', 'Jessica', 'F'),
(1, 'Castillo', 'Zumarán', 'Segundo', 'M');

-- 9. Tabla empresa
INSERT INTO empresa (cliente_id, razon_social, tipo_empresa_tipo_id) VALUES
(4, 'Tech Innovators Inc.', 1),
(1, 'Consultores Asociados', 3);

-- 10. Tabla habitacion
INSERT INTO habitacion (estado_habitacion, descripcion, categoria_habitacion_categoria_id) VALUES
('D', 'Habitación con vista a la calle.', 1),
('O', 'Habitación con aire acondicionado', 3),
('M', 'Habitación con vista al mar', 3);

-- 11. Tabla transaccion
INSERT INTO transaccion (tipo_transaccion, habitacion_habitacion_id, persona_id, fecha_entrada, hora_entrada, fecha_salida, hora_salida, empleado_dni_empleado, cliente_cliente_id, motivo_viaje_motivo_id) VALUES
('1', 1, 3, '2023-06-01', '14:00', '2023-06-07', '12:00', '12345678', 1, 3),
('2', 2, 4, '2023-06-08', '15:00', '2023-06-10', '11:00', '87654321', 2, 3);

-- 12. Tabla comprobante
INSERT INTO comprobante (transaccion_transaccion_id, tipo_comprobante, numero_comprobante, monto_total, cliente_id, empleado_dni_empleado, cliente_cliente_id) VALUES
(1, 'B', '00000001', 350.00, 4, '12345678', 1),
(2, 'F', '00000002', 150.00, 5, '12345678', 2);

-- 13. Tabla detalle_alojamiento
INSERT INTO detalle_alojamiento (transaccion_transaccion_id, persona_cliente_id) VALUES
(1, 3),
(2, 4);

-- 14. Tabla detalle_comprobante
INSERT INTO detalle_comprobante (servicio_servicio_id, comprobante_comprobante_id, monto) VALUES
(3, 1, 300.00),
(4, 1, 100.00);

-- 15. Tabla detalle_servicios
INSERT INTO detalle_servicios (fecha_solicitud, hora_solicitud, descripcion_solicitud, monto_servicio, transaccion_transaccion_id, servicio_servicio_id) VALUES
('2023-06-02', '09:00', 'Desayuno', 20.00, 1, 3),
('2023-06-09', '18:00', 'Cena', 25.00, 1, 4);

------------------------------------------------------------------------

-- 1. Tabla pais
INSERT INTO pais (codigo_pais, nombre) VALUES
('124', 'Canadá'),
('250', 'Francia'),
('356', 'India'),
('392', 'Japón'),
('528', 'Países Bajos');

-- 2. Tabla categoria_habitacion
INSERT INTO categoria_habitacion (nombre_categoria, precio_categoria) VALUES
('Suite Presidencial', 300.00),
('Junior Suite', 200.00);

-- 3. Tabla tipo_empresa
INSERT INTO tipo_empresa (nombre_tipo) VALUES
('Educación'),
('Salud');

-- 4. Tabla servicio
INSERT INTO servicio (descricpion_servicio) VALUES
('Spa'),
('Gimnasio');

-- 5. Tabla motivo_viaje
INSERT INTO motivo_viaje (descripcion_motivo) VALUES
('Estudios'),
('Salud');

-- 6. Tabla empleado
INSERT INTO empleado (dni_empleado, apellido_pat, ape_materno, nombres, sexo, movil) VALUES
('56789012', 'García', 'Fernández', 'Carlos', 'M', '+51987654321'),
('87651234', 'Martín', 'Rodríguez', 'Luisa', 'F', '+51923456789');

-- 7. Tabla cliente
INSERT INTO cliente (direccion, telefono, tipo_doc, numero_documento, pais_codigo_pais) VALUES
('789 Boulevard Principal', '+51888888888', 'DNI', '56789012C', '124'),
('101 Avenida del Sol', '+51777777777', 'Pasaporte', 'B1234567', '250');

-- 8. Tabla persona
INSERT INTO persona (cliente_id, ape_paterno, ape_materno, nombres, sexo) VALUES
(6, 'Smith', 'Brown', 'John', 'M'),
(5, 'Johnson', 'White', 'Emily', 'F');

-- 9. Tabla empresa
INSERT INTO empresa (cliente_id, razon_social, tipo_empresa_tipo_id) VALUES
(5, 'Educational Institute', 4),
(6, 'Healthcare Services', 5);

-- 10. Tabla habitacion
INSERT INTO habitacion (estado_habitacion, descripcion, categoria_habitacion_categoria_id) VALUES
('R', 'Habitación reservada con balcón', 2),
('D', 'Habitación con cama king size', 2);

-- 11. Tabla transaccion
INSERT INTO transaccion (tipo_transaccion, habitacion_habitacion_id, persona_id, fecha_entrada, hora_entrada, fecha_salida, hora_salida, empleado_dni_empleado, cliente_cliente_id, motivo_viaje_motivo_id) VALUES
('1', 3, 6, '2023-07-01', '13:00', '2023-07-05', '11:00', '56789012', 3, 1),
('2', 4, 5, '2023-07-06', '14:00', '2023-07-08', '10:00', '87651234', 4, 2);

-- 12. Tabla comprobante
INSERT INTO comprobante (transaccion_transaccion_id, tipo_comprobante, numero_comprobante, monto_total, cliente_id, empleado_dni_empleado, cliente_cliente_id) VALUES
(3, 'B', '00000003', 400.00, 3, '56789012', 3),
(4, 'F', '00000004', 250.00, 4, '87651234', 4);

-- 13. Tabla detalle_alojamiento
INSERT INTO detalle_alojamiento (transaccion_transaccion_id, persona_cliente_id) VALUES
(3, 6),
(4, 5);

-- 14. Tabla detalle_comprobante
INSERT INTO detalle_comprobante (servicio_servicio_id, comprobante_comprobante_id, monto) VALUES
(5, 3, 100.00),
(6, 4, 150.00);

-- 15. Tabla detalle_servicios
INSERT INTO detalle_servicios (fecha_solicitud, hora_solicitud, descripcion_solicitud, monto_servicio, transaccion_transaccion_id, servicio_servicio_id) VALUES
('2023-07-02', '10:00', 'Masaje', 50.00, 3, 5),
('2023-07-07', '17:00', 'Cena Gourmet', 75.00, 4, 6);














