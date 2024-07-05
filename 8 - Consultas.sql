-- Consultar ocupación actual de habitaciones
SELECT h.habitacion_id, h.descripcion, h.estado_habitacion
FROM habitacion h
WHERE h.estado_habitacion IN ('O', 'R'); -- Ocupadas y Reservadas


-- Verificar disponibilidad de habitaciones
SELECT h.habitacion_id, h.descripcion
FROM habitacion h
WHERE h.estado_habitacion = 'D' -- Disponible
  AND NOT EXISTS (
      SELECT 1
      FROM transaccion t
      WHERE t.habitacion_habitacion_id = h.habitacion_id
        AND t.fecha_entrada <= '2024-07-05' -- Fecha inicio deseada
        AND (t.fecha_salida IS NULL OR t.fecha_salida >= '2024-07-05') -- Fecha fin deseada
  );


-- Consultar ingresos totales por mes
SELECT DATE_PART('month', c.fecha_comprobante) AS mes,
       SUM(c.monto_total) AS ingresos_totales
FROM comprobante c
WHERE DATE_PART('year', c.fecha_comprobante) = 2024 -- Año deseado
GROUP BY DATE_PART('month', c.fecha_comprobante)
ORDER BY DATE_PART('month', c.fecha_comprobante);


-- Verificar detalles de servicios solicitados
SELECT t.transaccion_id, ds.fecha_solicitud, ds.hora_solicitud, s.descricpion_servicio, ds.monto_servicio
FROM detalle_servicios ds
JOIN servicio s ON ds.servicio_servicio_id = s.servicio_id
JOIN transaccion t ON ds.transaccion_transaccion_id = t.transaccion_id
WHERE t.fecha_entrada >= '2024-01-01' -- Fecha inicio de búsqueda
  AND t.fecha_salida <= '2024-12-31'; -- Fecha fin de búsqueda


-- Clientes con más estancias registradas
SELECT p.cliente_id, p.ape_paterno, p.ape_materno, p.nombres,
       COUNT(*) AS cantidad_estancias
FROM persona p
JOIN detalle_alojamiento da ON p.cliente_id = da.persona_cliente_id
GROUP BY p.cliente_id, p.ape_paterno, p.ape_materno, p.nombres
ORDER BY cantidad_estancias DESC
LIMIT 10; 


