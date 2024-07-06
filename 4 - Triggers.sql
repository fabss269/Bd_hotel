-----------ESTE ES PARA HACER TODO LO QUE TENGA QUE VER CON DINERO, DETALLES, COMPROBANTE TRANSACCIÓN--------------------
CREATE OR REPLACE FUNCTION fn_actualizar_costo_total_y_tablas()
RETURNS trigger 
AS 
$$
DECLARE
    dias_estancia INT;
    costo_total NUMERIC(10, 2);
    p_categoria NUMERIC(10, 2);
    consolidado NUMERIC(10, 2);
    nuevo_comprobante INT;
    parte1 TEXT;
    parte2 TEXT;
    secuencia INT;
    num_comprobante TEXT;
	tipo_doc varchar(20);
	det_serv_id int;

BEGIN
    -- Verificar si los valores de hora_salida y fecha_salida han cambiado
    IF NEW.hora_salida IS DISTINCT FROM OLD.hora_salida OR NEW.fecha_salida IS DISTINCT FROM OLD.fecha_salida THEN
        -- Calcular los días de estancia
        dias_estancia := NEW.fecha_salida - NEW.fecha_entrada + 1;
        
        -- Obtener el precio de la categoría de la habitación
        SELECT precio_categoria 
        INTO p_categoria 
        FROM categoria_habitacion 
        WHERE categoria_id = (
            SELECT categoria_habitacion_categoria_id 
            FROM habitacion 
            WHERE habitacion_id = NEW.habitacion_habitacion_id
        );
        
        -- Cambiar el estado de la habitación a disponible
        UPDATE habitacion 
        SET estado_habitacion = 'D' 
        WHERE habitacion_id = NEW.habitacion_habitacion_id;
      
        -- Calcular el costo total
        costo_total := dias_estancia * p_categoria;
        
        -- Insertar en detalle_servicios
		select pa_insert_detalle_servicios('Acabó su hospedaje', costo_total, new.transaccion_id, 3) into det_serv_id;
    
        -- Obtener el consolidado
        consolidado := fn_obtener_consolidado(NEW.transaccion_id);

		
        -- Generar número de comprobante usando la secuencia
        SELECT COUNT(*) 
        INTO secuencia 
        FROM comprobante;

        secuencia := secuencia + 1;
        parte1 := LPAD((secuencia / 100000)::TEXT, 4, '0');
        parte2 := LPAD((secuencia % 100000)::TEXT, 5, '0');
        num_comprobante := parte1 || '-' || parte2;
        
        -- Insertar el comprobante
		
		SELECT cl.tipo_doc into tipo_doc
		FROM transaccion tr
		JOIN cliente cl ON tr.cliente_cliente_id = cl.cliente_id
		where new.cliente_cliente_id = cl.cliente_id;
		
        if tipo_doc != 'RUC' THEN
		SELECT pa_insert_comprobante(NEW.transaccion_id, 'B', num_comprobante, consolidado, NEW.empleado_dni_empleado, 
                                     NEW.cliente_cliente_id) INTO nuevo_comprobante;
		else
		SELECT pa_insert_comprobante(NEW.transaccion_id, 'F', num_comprobante, consolidado, NEW.empleado_dni_empleado, 
                                     NEW.cliente_cliente_id) INTO nuevo_comprobante;
		end if;

        IF nuevo_comprobante != -1 THEN
            -- Insertar en detalle_comprobante
            INSERT INTO detalle_comprobante (comprobante_comprobante_id, servicio_servicio_id, monto)
            SELECT nuevo_comprobante, ds.servicio_servicio_id, SUM(ds.monto_servicio)
            FROM detalle_servicios ds
            INNER JOIN transaccion tr ON tr.transaccion_id = ds.transaccion_transaccion_id
            WHERE ds.transaccion_transaccion_id = NEW.transaccion_id
            GROUP BY ds.servicio_servicio_id;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

Create or replace trigger tr_fn_actualizar_costo_total_y_tablas after update on transaccion
	for each row execute procedure fn_actualizar_costo_total_y_tablas();
---------------------------------------PARA UPDATEAR LA SALIDA MÁS RÁPIDO-----------------------------
CREATE OR REPLACE FUNCTION pa_update_salida_transaccion(trans_id int) RETURNS int AS $$
BEGIN
    UPDATE transaccion
    SET fecha_salida = current_date,
        hora_salida = current_time
    WHERE transaccion_id = trans_id;
    RETURN trans_id;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Error updating transaccion: %', SQLERRM;
    RETURN -1;
END;
$$ LANGUAGE 'plpgsql';

---------------------------------------FUNCION_PARA CONSOLIDADO------------------------------
CREATE OR REPLACE FUNCTION fn_obtener_consolidado(transaccion_id INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    consolidado NUMERIC(10,2);
BEGIN
    SELECT SUM(monto_servicio)
    INTO consolidado
    FROM detalle_servicios
    WHERE transaccion_transaccion_id = transaccion_id
    GROUP BY transaccion_transaccion_id;

    RETURN consolidado;
END;
$$ LANGUAGE plpgsql;
---------------------------------------------PA_DE_FRANQUE**********************

CREATE OR REPLACE FUNCTION pa_insert_comprobante(trans_id int, tipo_comp CHAR(1), num_comp VARCHAR(10), monto NUMERIC(10,2), dni_emp CHAR(8), cli_cli_id int) RETURNS int AS $$
DECLARE
    retorno int;
BEGIN
    INSERT INTO comprobante (transaccion_transaccion_id, tipo_comprobante, numero_comprobante, monto_total, empleado_dni_empleado, cliente_cliente_id)
    VALUES (trans_id, tipo_comp, num_comp, monto, dni_emp, cli_cli_id)
    RETURNING comprobante_id INTO retorno;
    RETURN retorno;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;

-----------------------------------
CREATE OR REPLACE FUNCTION fn_notificar_cambio_estado_habitacion() RETURNS trigger 
AS 
$$
BEGIN
    IF NEW.estado_habitacion IS DISTINCT FROM OLD.estado_habitacion THEN
        PERFORM send_notification(
            'Cambio de estado de habitación', 
            'La habitación ' || NEW.habitacion_id || ' ha cambiado su estado a ' || NEW.estado_habitacion
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION send_notification(asunto TEXT, mensaje TEXT) RETURNS void AS 
$$
BEGIN
 
    RAISE NOTICE 'Asunto: %, Mensaje: %', asunto, mensaje;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER tr_notificar_cambio_estado_habitacion
AFTER UPDATE ON habitacion
FOR EACH ROW 
EXECUTE FUNCTION fn_notificar_cambio_estado_habitacion();
