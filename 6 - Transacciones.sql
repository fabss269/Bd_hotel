---------------------------------------------------------------------------------------------
--1. Actualización del Teléfono y Dirección del Cliente
BEGIN;
SAVEPOINT actualizar_cliente;

UPDATE cliente
SET telefono = '+51999999999',
    direccion = '456 Calle Principal'
WHERE cliente_id = 1;

COMMIT;


select * from cliente
---------------------------------------------------------------------------------------------------------------------------------------------  
--2. Registro de un Nuevo Servicio para un Cliente
DO $$
DECLARE
    habitacion_id INTEGER;
    transaccion_id INTEGER;
    cliente_id INTEGER := 2; -- Ejemplo de cliente_id
BEGIN
    -- Seleccionar la última transacción confirmada para el cliente especificado
    SELECT t.transaccion_id, t.habitacion_habitacion_id
    INTO transaccion_id, habitacion_id
    FROM transaccion t
    WHERE t.cliente_cliente_id = cliente_id AND t.tipo_transaccion = '2'
    ORDER BY t.fecha_registro DESC
    LIMIT 1
    FOR UPDATE;

    -- Verificar si transaccion_id es nulo
    IF transaccion_id IS NULL THEN
        RAISE EXCEPTION 'No se encontró ninguna transacción válida para el cliente con ID %.', cliente_id;
    ELSE
        RAISE NOTICE 'Transacción encontrada para el cliente con ID %: transaccion_id: %, habitacion_id: %', cliente_id, transaccion_id, habitacion_id;
    END IF;

    -- Debugging: Verificar los valores obtenidos
    RAISE NOTICE 'transaccion_id obtenido: %', transaccion_id;
    RAISE NOTICE 'habitacion_id obtenido: %', habitacion_id;

    -- Insertar un nuevo servicio solicitado para la habitación seleccionada
    INSERT INTO detalle_servicios (fecha_solicitud, hora_solicitud, descripcion_solicitud, monto_servicio, transaccion_transaccion_id, servicio_servicio_id)
    VALUES (current_date, current_time, 'Masaje en habitación', 50.00, transaccion_id, 1); -- '5' es el ID del servicio de Spa

    COMMIT;
END $$;

select * from detalle_servicios
---------------------------------------------------------------------
--3. Inserción de una Nueva Persona y Registro de Reserva
  
select * from cliente

	
DO $$
DECLARE
    v_cliente_id INTEGER := 4; -- Ejemplo de cliente_id
    v_persona_id INTEGER;
BEGIN
    -- Verificar si el cliente con cliente_id especificado existe
    PERFORM 1 FROM cliente WHERE cliente_id = v_cliente_id;

    -- Si no se encuentra el cliente, lanzar una excepción
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El cliente con cliente_id = % no existe.', v_cliente_id;
    END IF;

    -- Insertar nueva persona asignada al cliente existente
    INSERT INTO persona (cliente_id, ape_paterno, ape_materno, nombres, sexo)
    VALUES (v_cliente_id, 'Gonzales', 'Pérez', 'María', 'F')
    RETURNING cliente_id INTO v_persona_id;

    -- Verificar si la persona se insertó correctamente
    IF v_persona_id IS NULL THEN
        RAISE EXCEPTION 'Error al insertar la nueva persona.';
    END IF;

    -- Registrar nueva reserva asignando la persona
    INSERT INTO transaccion (fecha_registro, tipo_transaccion, habitacion_habitacion_id, persona_id, cliente_cliente_id, motivo_viaje_motivo_id, empleado_dni_empleado)
    VALUES (current_date, '1', 3, v_persona_id, v_cliente_id, 1, '12345678'); -- Ejemplo de un empleado con dni '12345678'

    COMMIT;
END $$;

select * from transaccion
