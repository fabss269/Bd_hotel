
-- 11. Tabla transaccion
INSERT INTO transaccion (tipo_transaccion, habitacion_habitacion_id, persona_id, fecha_entrada, hora_entrada, fecha_salida, hora_salida, empleado_dni_empleado, cliente_cliente_id, motivo_viaje_motivo_id) VALUES
('1', 3, 6, '2023-07-01', '13:00', '2023-07-05', '11:00', '56789012', 3, 1),
('2', 4, 5, '2023-07-06', '14:00', '2023-07-08', '10:00', '87651234', 4, 2);


-- 13. Tabla detalle_alojamiento
INSERT INTO detalle_alojamiento (transaccion_transaccion_id, persona_cliente_id) VALUES
(3, 6),
(4, 5);


-- 15. Tabla detalle_servicios
INSERT INTO detalle_servicios (fecha_solicitud, hora_solicitud, descripcion_solicitud, monto_servicio, transaccion_transaccion_id, servicio_servicio_id) VALUES
('2023-07-02', '10:00', 'Masaje', 50.00, 3, 5),
('2023-07-07', '17:00', 'Cena Gourmet', 75.00, 4, 6);

-------------------------------------------------------------------------------------LOS REALES INSERTS------------------------------------------------------------------------------------------------
--1.INSERT DE PAÍS
INSERT INTO public.pais(codigo_pais, nombre) VALUES 
(124, 'Canada'), 
(250, 'Francia'), 
(008, 'Albania'), 
(020, 'Andorra'), 
(682, 'Arabia Saudita'), 
(012, 'Argelia'), 
(032, 'Argentina'), 
(036, 'Australia'), 
(040, 'Austria'), 
(056, 'Belgica'), 
(058, 'Luxemburgo'), 
(084, 'Belice'), 
(604, 'Peru'), 
(192, 'Cuba'), 
(300, 'Grecia'), 
(218, 'Ecuador'), 
(484, 'Mexico'), 
(504, 'Marruecos'), 
(591, 'Panama'), 
(170, 'Colombia'), 
(392, 'China');
-- 2. Tabla categoria_habitacion
INSERT INTO categoria_habitacion (nombre_categoria, precio_categoria) VALUES
('Suite Presidencial', 300.00),
('Junior Suite', 200.00),
('Lujo', 150.00),
('Estándar', 80.00),
('Economica', 60.00);
-- 3. Tabla tipo_empresa
INSERT INTO tipo_empresa (nombre_tipo) VALUES
('Educación'),
('Salud'),
('Tecnología'),
('Manufactura');
-- 4. Tabla servicio
INSERT INTO servicio (descricpion_servicio) VALUES
('Spa'),
('Gimnasio'),
('Alojamiento'),
('Restaurante'),
('Cochera'),
('Transporte');
-- 5. Tabla motivo_viaje
INSERT INTO motivo_viaje (descripcion_motivo) VALUES
('Estudios'),
('Salud'),
('Vacaciones'),
('Negocios'),
('Conferencia');
--6. Tabla empleado
INSERT INTO empleado(dni_empleado, apellido_pat, ape_materno, nombres, sexo, movil, f_alta, f_baja) VALUES 
(56789012, 'Garcia', 'Fernandez', 'Carlos', 'M', '+51987654321', '2024-07-03', ''), 
(78564972, 'Garcia', 'Chinchay', 'Alan', 'M', '+51906300972', '2024-07-03', '2024-08-03'), 
(72928142, 'Guzman', 'Alarcon', 'Gabo', 'M', '+51904300876', '2024-07-04', ''), 
(74295872, 'Perez', 'Vasquez', 'Ander', 'M', '+51945678345', '2024-07-04', '');
--7. Tabla cliente
INSERT INTO cliente(cliente_id, direccion, telefono, f_registro, tipo_doc, numero_documento, pais_codigo_pais) VALUES 
(1, '789 Boulevard Principal', '+51888888888', '2024-07-03', 'DNI', '56789012C', 124), 
(2, '101 Avenida del Sol', '+51777777777', '2024-07-03', 'Pasaporte', 'B1234567', 250), 
(3, 'La niña 170', '906300962', '2024-07-03', 'DNI', '72428857', 056), 
(4, 'Salas 128', '986709124', '2024-07-03', 'DNI', '73435567', 170), 
(5, 'Gladiolos 236', '987654234', '2024-07-04', 'DNI', '97568765', 008), 
(6, 'La florida 270', '+51923800962', '2024-07-04', 'DNI', '74446589', 300), 
(7, 'Antonio Arenas 344', '+51964784235', '2024-07-04', 'DNI', '18647746', 604), 
(8, 'Los Treboles 456', '+51965941533', '2024-07-04', 'DNI', '16628363', 058), 
(9, 'Casa de Zumi', '+51968923459', '2024-07-04', 'DNI', '19645322', 170), 
(10, 'Zarumilla 230', '+51907300976', '2024-07-04', 'DNI', '75624910', 170), 
(11, 'Av Antenor Orrego 200', '+51945673246', '2024-07-04', 'DNI', '16648684', 170);
--8. Tabla de persona
INSERT INTO persona (cliente_id, ape_paterno, ape_materno, nombres, sexo) VALUES
(5, 'Lopez', 'Gomez', 'Juan', 'M'),
(6, 'Garcia', 'Martinez', 'Ana', 'F'),
(7, 'Ramirez', 'Sanchez', 'Pedro', 'M'),
(8, 'Fernandez', 'Torres', 'Lucia', 'F'),
(9, 'Perez', 'Hernandez', 'Jose', 'M'),
(10, 'Sanchez', 'Morales', 'Elena', 'F'),
(11, 'Diaz', 'Vargas', 'Miguel', 'M');
--9.Tabla de empresa
INSERT INTO empresa (cliente_id, razon_social, tipo_empresa_tipo_id) VALUES
(1, 'Tech Solutions S.A.C.', 1),
(2, 'Inversiones El Sol E.I.R.L.', 2),
(3, 'Consultoría Global S.R.L.', 3),
(4, 'Servicios Integrales S.A.', 4);
--10. Tabla de habitación
INSERT INTO habitacion (estado_habitacion, descripcion, categoria_habitacion_categoria_id) VALUES
('R', 'Habitación reservada con balcón', 2),
('D', 'Habitación con cama king size', 2),
('L', 'Habitación con vista al mar', 1),
('D', 'Habitación con jacuzzi', 1),
('L', 'Habitación con decoración moderna', 3),
('R', 'Habitación con acceso a la piscina', 3),
('D', 'Habitación con aire acondicionado', 4),
('R', 'Habitación con dos camas individuales', 4),
('L', 'Habitación cerca del lobby', 5),
('D', 'Habitación con baño compartido', 5);
--Detalle_alojamiento, comprobante, detalle_comprobante se hacen con un trigger
--11. Tabla de transaccion
INSERT INTO transaccion (habitacion_habitacion_id, empleado_dni_empleado, cliente_cliente_id, motivo_viaje_motivo_id) VALUES
(1, 56789012, 1, 1),
(2, 78564972, 2, 2),
(3, 72928142, 3, 3),
(4, 74295872, 4, 4),
(5, 56789012, 9, 5),
(6, 78564972, 6, 1),
(7, 72928142, 7, 2),
(8, 74295872, 8, 3),
(9, 56789012, 9, 4),
(10, 78564972, 10, 5),
(1, 72928142, 11, 1);
