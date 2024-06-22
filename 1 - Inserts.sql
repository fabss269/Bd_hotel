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

select*from pais
-- 2. Tabla categoria_habitacion
INSERT INTO categoria_habitacion (nombre_categoria, precio_categoria) VALUES
('Economica', 50.00),
('Estándar', 75.00),
('Lujo', 150.00);
select*from categoria_habitacion
-- 3. Tabla tipo_empresa
INSERT INTO tipo_empresa (nombre_tipo) VALUES
('Tecnología'),
('Consultoría'),
('Manufactura');
select*from tipo_empresa
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
-- 8. Tabla cliente
INSERT INTO cliente (direccion, telefono, tipo_doc, numero_documento, pais_codigo_pais) VALUES
('123 Calle Falsa', '+51451456456', 'DNI', '12345678A', '032'),
('456 Avenida Real', '+5111111111', 'Pasaporte', 'A1234567', '040'),
('789 Camino Verde', '+5122122222', 'DNI', '87654321B', '604'),
('789 Kha Verde', '+12315312311', 'RUC', '12311236521', '040');
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