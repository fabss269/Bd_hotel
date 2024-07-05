
  --Vista de Información de Habitaciones Ocupadas:

CREATE OR REPLACE VIEW v_habitaciones_ocupadas AS
SELECT
    h.habitacion_id,
    h.descripcion,
    ch.nombre_categoria AS categoria,
    c.numero_documento AS documento_cliente,
    c.direccion AS direccion_cliente,
    mv.descripcion_motivo AS motivo_viaje,
    t.fecha_entrada,
    t.hora_entrada,
    t.fecha_salida,
    t.hora_salida
FROM
    transaccion t
    JOIN habitacion h ON t.habitacion_habitacion_id = h.habitacion_id
    JOIN categoria_habitacion ch ON h.categoria_habitacion_categoria_id = ch.categoria_id
    JOIN cliente c ON t.cliente_cliente_id = c.cliente_id
    JOIN motivo_viaje mv ON t.motivo_viaje_motivo_id = mv.motivo_id
WHERE
    h.estado_habitacion = 'O';

select * from v_habitaciones_ocupadas

--Vista de Resumen de Transacciones:
CREATE VIEW v_resumen_transacciones AS
SELECT
    tr.transaccion_id,
    tr.fecha_registro,
    tr.tipo_transaccion,
    h.descripcion AS descripcion_habitacion,
    p.nombres AS nombre_cliente,
    e.nombres AS nombre_empleado,
    c.tipo_comprobante,
    c.numero_comprobante,
    c.fecha_comprobante,
    c.monto_total
FROM
    transaccion tr
    JOIN habitacion h ON tr.habitacion_habitacion_id = h.habitacion_id
    JOIN persona p ON tr.persona_id = p.cliente_id
    JOIN empleado e ON tr.empleado_dni_empleado = e.dni_empleado
    JOIN comprobante c ON tr.transaccion_id = c.transaccion_transaccion_id;

select * from v_resumen_transacciones

--Vista de Detalles de Servicios Solicitados:
CREATE VIEW v_detalles_servicios AS
SELECT
    ds.detalle_id,
    ds.fecha_solicitud,
    ds.hora_solicitud,
    ds.descripcion_solicitud,
    ds.monto_servicio,
    t.transaccion_id,
    s.descricpion_servicio
FROM
    detalle_servicios ds
    JOIN transaccion t ON ds.transaccion_transaccion_id = t.transaccion_id
    JOIN servicio s ON ds.servicio_servicio_id = s.servicio_id;

select * from v_detalles_servicios

--Vista de Resumen de Habitaciones:
CREATE VIEW v_resumen_habitaciones AS
SELECT
    h.habitacion_id,
    h.descripcion,
    h.estado_habitacion,
    ch.nombre_categoria AS categoria,
    CONCAT(p.ape_paterno, ' ', p.ape_materno, ', ', p.nombres) AS nombre_cliente,
    c.telefono AS telefono_cliente,
    mv.descripcion_motivo AS motivo_viaje
FROM
    habitacion h
    LEFT JOIN transaccion t ON h.habitacion_id = t.habitacion_habitacion_id
    LEFT JOIN cliente c ON t.cliente_cliente_id = c.cliente_id
    LEFT JOIN persona p ON c.cliente_id = p.cliente_id
    LEFT JOIN categoria_habitacion ch ON h.categoria_habitacion_categoria_id = ch.categoria_id
    LEFT JOIN motivo_viaje mv ON t.motivo_viaje_motivo_id = mv.motivo_id;


select * from v_resumen_habitaciones

--Vista de Clientes y Empleados:
CREATE VIEW v_clientes_empleados AS
SELECT
    c.cliente_id,
    c.numero_documento,
    c.direccion,
    e.apellido_pat || ' ' || e.ape_materno || ', ' || e.nombres AS nombre_empleado,
    e.movil AS movil_empleado,
    t.tipo_transaccion,
    t.fecha_registro AS fecha_transaccion
FROM
    cliente c
    JOIN transaccion t ON c.cliente_id = t.cliente_cliente_id
    JOIN empleado e ON t.empleado_dni_empleado = e.dni_empleado;
select * from v_clientes_empleados

--Vista de Resumen de Transacciones por Mes
CREATE VIEW v_resumen_transacciones_mes AS
SELECT
    EXTRACT(MONTH FROM t.fecha_registro) AS mes,
    COUNT(*) AS cantidad_transacciones,
    SUM(CASE WHEN t.tipo_transaccion = '1' THEN 1 ELSE 0 END) AS reservas,
    SUM(CASE WHEN t.tipo_transaccion = '2' THEN 1 ELSE 0 END) AS confirmaciones,
    SUM(CASE WHEN t.tipo_transaccion = '1' THEN c.monto_total ELSE 0 END) AS monto_reservas,
    SUM(CASE WHEN t.tipo_transaccion = '2' THEN c.monto_total ELSE 0 END) AS monto_confirmaciones
FROM
    transaccion t
    LEFT JOIN comprobante c ON t.transaccion_id = c.transaccion_transaccion_id
GROUP BY
    EXTRACT(MONTH FROM t.fecha_registro)
ORDER BY
    mes;

select * from v_resumen_transacciones_mes

--Vista de Detalle de Servicios por Cliente
CREATE VIEW v_detalle_servicios_cliente AS
SELECT
    c.cliente_id,
    c.numero_documento,
    ds.fecha_solicitud,
    s.descricpion_servicio,
    ds.monto_servicio
FROM
    detalle_servicios ds
    JOIN transaccion t ON ds.transaccion_transaccion_id = t.transaccion_id
    JOIN cliente c ON t.cliente_cliente_id = c.cliente_id
    JOIN servicio s ON ds.servicio_servicio_id = s.servicio_id;

select * from v_detalle_servicios_cliente

--Vista de Resumen de Servicios por Mes
CREATE VIEW v_resumen_servicios_mes AS
SELECT
    EXTRACT(MONTH FROM ds.fecha_solicitud) AS mes,
    COUNT(*) AS cantidad_servicios,
    SUM(ds.monto_servicio) AS monto_total
FROM
    detalle_servicios ds
    JOIN transaccion t ON ds.transaccion_transaccion_id = t.transaccion_id
GROUP BY
    EXTRACT(MONTH FROM ds.fecha_solicitud)
ORDER BY
    mes;

select * from v_resumen_servicios_mes

--Vista de Detalle de Comprobantes por Mes
CREATE VIEW v_detalle_comprobantes_mes AS
SELECT
    EXTRACT(MONTH FROM fecha_comprobante) AS mes,
    COUNT(*) AS cantidad_comprobantes,
    SUM(monto_total) AS monto_total
FROM
    comprobante
GROUP BY
    EXTRACT(MONTH FROM fecha_comprobante)
ORDER BY
    mes;
select * from v_detalle_comprobantes_mes

