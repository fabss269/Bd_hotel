-----------ESTE ES PARA HACER TODO LO QUE TENGA QUE VER CON DINERO, DETALLES, COMPROBANTE TRANSACCIÓN--------------------
CREATE or replace FUNCTION fn_actualizar_costo_total_y_tablas() RETURNS trigger 
AS 
$$
DECLARE
    dias_estancia INTEGER;
    costo_total NUMERIC(10, 2);
    p_categoria NUMERIC(10, 2);
	consolidado numeric(10, 2);
	nuevo_comprobante int;
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
		
		-- CAMBIAR EL ESTADO DE LA HABITACION A DISPONIBLE
		UPDATE habitacion set estado_habitacion = 'D' where habitacion_id = new.habitacion_habitacion_id;
      
        -- Calcular el costo total
        costo_total := dias_estancia * p_categoria;
		-------------insert en detalle
		INSERT INTO detalle_servicios(fecha_solicitud, hora_solicitud, descripcion_solicitud, 
									 monto_servicio, transaccion_transaccion_id, servicio_servicio_id)
		VALUES (new.fecha_salida, new.hora_salida, 'Se va mikin', costo_total, new.transaccion_id, 1);
	
		consolidado = fn_obtener_consolidado(new.transaccion_id);
		
		select pa_insert_comprobante(new.transaccion_id, 'B', '0000004', consolidado, new.empleado_dni_empleado, 
							  new.cliente_cliente_id) INTO nuevo_comprobante;
	
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
$$ language 'plpgsql';

Create or replace trigger tr_fn_actualizar_costo_total_y_tablas after update on transaccion
	for each row execute procedure fn_actualizar_costo_total_y_tablas();

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
