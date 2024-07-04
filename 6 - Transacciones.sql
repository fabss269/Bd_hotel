
---Esta transacción verifica la disponibilidad de una habitación antes de realizar una reserva y maneja el caso de error si la habitación no está disponible.

BEGIN;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se pudo completar la reserva debido a un error.';
END;

SELECT estado_habitacion
INTO @estado
FROM habitacion
WHERE habitacion_id = 20
FOR UPDATE;

IF @estado = 'D' THEN
    UPDATE habitacion
    SET estado_habitacion = 'R'
    WHERE habitacion_id = 20;
    INSERT INTO detalle_alojamiento (transaccion_transaccion_id, persona_cliente_id)
    VALUES (30, 35);
ELSE
    -- Habitación no disponible
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'La habitación no está disponible para reserva.';
END IF;

COMMIT;

---Esta transacción realiza la reserva de una habitación y luego inserta un registro en la tabla de detalle de alojamiento.

BEGIN;
SAVEPOINT reserva_habitacion;

-- Reservar habitación
UPDATE habitacion
SET estado_habitacion = 'R'
WHERE habitacion_id = 15;

INSERT INTO detalle_alojamiento (transaccion_transaccion_id, persona_cliente_id)
VALUES (25, 30);

COMMIT;

---Esta transacción realiza la reserva de una habitación, asegurando que ninguna otra transacción pueda reservar la misma habitación al mismo tiempo.

BEGIN;
SELECT *
FROM habitacion
WHERE habitacion_id = 10
FOR UPDATE;

UPDATE habitacion
SET estado_habitacion = 'R'
WHERE habitacion_id = 10;

COMMIT;
