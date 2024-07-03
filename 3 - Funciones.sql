-- Calcular el costo total de una estancia
CREATE OR REPLACE FUNCTION calcular_costo_total_estancia(
  hab_id INTEGER, 
  dias_estancia INTEGER, 
  servicios JSON
  ) 
RETURNS NUMERIC AS $$
DECLARE
    precio_habitacion NUMERIC;
    precio_servicios NUMERIC := 0;
    costo_total NUMERIC;
BEGIN
    -- Obtener el precio de la habitación
    SELECT precio
    INTO precio_habitacion
    FROM habitacion
    WHERE habitacion_id = hab_id;

    -- Calcular el costo de los servicios adicionales
    FOR serv IN SELECT * FROM json_each_text(servicios)
    LOOP
        SELECT precio_total
        INTO precio_servicios
        FROM servicio
        WHERE servicio_id = serv.key::INTEGER;
        precio_servicios := precio_servicios + precio_servicios * serv.value::INTEGER;
    END LOOP;

    -- Calcular el costo total
    costo_total := (precio_habitacion * dias_estancia) + precio_servicios;

    RETURN costo_total;
END;
$$ 
LANGUAGE plpgsql;



-- Generar reporte de ingresos en un rango de fechas
CREATE OR REPLACE FUNCTION generar_reporte_ingresos(
  fecha_inicio DATE, 
  fecha_fin DATE
  ) 
RETURNS NUMERIC AS $$
DECLARE
    ingresos NUMERIC;
BEGIN
    -- Calcular los ingresos totales en el rango de fechas
    SELECT SUM(monto_total)
    INTO ingresos
    FROM comprobante
    WHERE fecha_emision BETWEEN fecha_inicio AND fecha_fin;

    RETURN ingresos;
END;
$$ 
LANGUAGE plpgsql;




























