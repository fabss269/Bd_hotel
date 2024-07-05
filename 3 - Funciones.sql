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

-- Cantidad de clientes registrados
CREATE OR REPLACE FUNCTION contar_clientes_registrados()
RETURNS INTEGER
AS $$
DECLARE
    total_clientes INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO total_clientes
    FROM cliente;

    RETURN total_clientes;
END;
$$ LANGUAGE plpgsql;

























