-- Clientes pr pais
CREATE OR REPLACE FUNCTION consultar_clientes_por_pais(p_codigo_pais CHAR(3))
RETURNS INTEGER
AS $$
DECLARE
    total_clientes INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO total_clientes
    FROM cliente
    WHERE pais_codigo_pais = p_codigo_pais;

    RETURN total_clientes;
END;
$$ LANGUAGE plpgsql;





-- Ingresos en un rango de fechas
CREATE OR REPLACE FUNCTION generar_reporte_ingresos(
  fecha_inicio DATE, 
  fecha_fin DATE
  ) 
RETURNS NUMERIC AS $$
DECLARE
    ingresos NUMERIC;
BEGIN
    SELECT SUM(monto_total)
    INTO ingresos
    FROM comprobante
    WHERE fecha_emision BETWEEN fecha_inicio AND fecha_fin;

    RETURN ingresos;
END;
$$ 
LANGUAGE plpgsql;





-- Contar habitaciones por estado
CREATE OR REPLACE FUNCTION contar_habitaciones_por_estado(p_estado CHAR(1))
RETURNS INTEGER
AS $$
DECLARE
    total_habitaciones INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO total_habitaciones
    FROM habitacion
    WHERE estado_habitacion = p_estado;

    RETURN total_habitaciones;
END;
$$ LANGUAGE plpgsql;



-- Total de ingresos por servicio
CREATE OR REPLACE FUNCTION calcular_total_ingresos_servicio(p_servicio_id INTEGER)
RETURNS NUMERIC
AS $$
DECLARE
    total_ingresos NUMERIC;
BEGIN
    SELECT COALESCE(SUM(dc.monto), 0)
    INTO total_ingresos
    FROM detalle_comprobante dc
    INNER JOIN comprobante c ON dc.comprobante_comprobante_id = c.comprobante_id
    WHERE dc.servicio_servicio_id = p_servicio_id;

    RETURN total_ingresos;
END;
$$ LANGUAGE plpgsql;



-- Cantidad de transacciones por servicio
CREATE OR REPLACE FUNCTION contar_transacciones_por_servicio(p_servicio_id INTEGER)
RETURNS INTEGER
AS $$
DECLARE
    total_transacciones INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO total_transacciones
    FROM detalle_servicios ds
    INNER JOIN transaccion t ON ds.transaccion_transaccion_id = t.transaccion_id
    WHERE ds.servicio_servicio_id = p_servicio_id;

    RETURN total_transacciones;
END;
$$ LANGUAGE plpgsql;















