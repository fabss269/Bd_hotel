
-- TIPO_EMPRESA
create or replace function pa_insert_tipo_empresa(
	nom_tipo varchar(100)
	) 
returns int as $$
declare
    retorno int;
begin
    insert into tipo_empresa (nombre_tipo)
    values (nom_tipo)
    returning tipo_id into retorno;

    return retorno;
exception when others then
    return -1;
end;
$$ 
language plpgsql;

--
create or replace function pa_update_tipo_empresa(
	tipo_id int,
	nom_tipo varchar(100)
	) 
returns int as $$
begin
    update tipo_empresa
    set nombre_tipo = nom_tipo
    where tipo_id = tipo_id;
    return tipo_id;
exception when others then
    return -1;
end;
$$ 
language plpgsql;

--
create or replace function pa_delete_tipo_empresa(
	tipo int
	) 
returns int as $$
begin
    delete from tipo_empresa
    where tipo_id = tipo;
    return tipo_id;
exception when others then
    return -1;
end;
$$ 
language plpgsql;



-- PAIS
CREATE OR REPLACE FUNCTION pa_insert_pais(
	cod_pais CHAR(3),
	nom VARCHAR(100)
	) 
RETURNS CHAR(3) AS $$
DECLARE
    retorno CHAR(3);
BEGIN
    INSERT INTO pais (codigo_pais, nombre)
    VALUES (cod_pais, nom)
    RETURNING codigo_pais INTO retorno;
    RETURN retorno;
EXCEPTION WHEN OTHERS THEN
    RETURN null;
END;
$$ 
LANGUAGE plpgsql;

--
CREATE OR REPLACE FUNCTION pa_update_pais(
    cod_pais CHAR(3), 
    nom VARCHAR(100)
    ) 
RETURNS CHAR(3) AS $$
BEGIN
    UPDATE pais
    SET nombre = nom
    WHERE codigo_pais = cod_pais;
    RETURN cod_pais;
EXCEPTION WHEN OTHERS THEN
    RETURN null;
END;
$$ 
LANGUAGE plpgsql;

--
CREATE OR REPLACE FUNCTION pa_delete_pais(cod_pais CHAR(3)) RETURNS CHAR(3) AS $$
BEGIN
    DELETE FROM pais
    WHERE codigo_pais = cod_pais;
    RETURN cod_pais;
EXCEPTION WHEN OTHERS THEN
    RETURN null;
END;
$$ 
LANGUAGE plpgsql;



-- CLIENTE
create or replace function pa_insert_cliente_empresa (
    dir varchar(255),
    tel varchar(14),
    doc varchar (20),
    n_doc varchar(20),
    pais char(3),
    raz_soc varchar(255),
    tipo int
    )
returns int as $$
declare
    retorno int;
begin
    INSERT INTO public.cliente (direccion, telefono, tipo_doc, numero_documento, pais_codigo_pais)
	VALUES (dir, tel,doc, n_doc, pais)
    returning cliente_id into retorno;

    INSERT INTO public.empresa(cliente_id, razon_social, tipo_empresa_tipo_id)
	VALUES (retorno, raz_soc, tipo);

    return retorno;
exception when others then
    return -1;
end;
$$ 
language 'plpgsql';

--
create or replace function pa_insert_cliente_persona (
    dir varchar(255),
    tel varchar(14),
    doc varchar (20),
    n_doc varchar(20),
    pais char(3),    
    apet varchar(100),
    apem varchar(100),
    nom varchar(100),
    sexo char(1)
    )
returns int as $$
declare
    retorno int;
begin
    INSERT INTO public.cliente (direccion, telefono, tipo_doc, numero_documento, pais_codigo_pais)
	VALUES (dir, tel,doc, n_doc, pais)
    returning cliente_id into retorno;
    
    INSERT INTO public.persona(cliente_id, ape_paterno, ape_materno, nombres, sexo)
	VALUES (retorno, apet, apem,nom, sexo);

    return retorno;
exception when others then
    return -1;
end;
$$ 
language 'plpgsql';

--
CREATE OR REPLACE FUNCTION pa_update_cliente_empresa (
    cliente_id int,
    dir varchar(255),
    tel varchar(14),
    doc varchar (20),
    n_doc varchar(20),
    pais char(3),
    raz_soc varchar(255),
    tipo int
)
RETURNS BOOLEAN AS $$
BEGIN
    UPDATE public.cliente
    SET direccion = dir, 
        telefono = tel, 
        tipo_doc = doc, 
        numero_documento = n_doc, 
        pais_codigo_pais = pais
    WHERE cliente_id = cliente_id;

    UPDATE public.empresa
    SET razon_social = raz_soc, 
        tipo_empresa_tipo_id = tipo
    WHERE cliente_id = cliente_id;

    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END;
$$ 
LANGUAGE 'plpgsql';

--
CREATE OR REPLACE FUNCTION pa_update_cliente_persona (
    cliente_id int,
    dir varchar(255),
    tel varchar(14),
    doc varchar (20),
    n_doc varchar(20),
    pais char(3),    
    apet varchar(100),
    apem varchar(100),
    nom varchar(100),
    sexo char(1)
)
RETURNS BOOLEAN AS $$
BEGIN
    UPDATE public.cliente
    SET direccion = dir, 
        telefono = tel, 
        tipo_doc = doc, 
        numero_documento = n_doc, 
        pais_codigo_pais = pais
    WHERE cliente_id = cliente_id;

    UPDATE public.persona
    SET ape_paterno = apet, 
        ape_materno = apem, 
        nombres = nom, 
        sexo = sexo
    WHERE cliente_id = cliente_id;

    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END;
$$ 
LANGUAGE 'plpgsql';

--
CREATE OR REPLACE FUNCTION pa_delete_cliente (
    cliente_id int
)
RETURNS BOOLEAN AS $$
BEGIN
    -- Eliminar de empresa si existe
    DELETE FROM public.empresa WHERE cliente_id = cliente_id;

    -- Eliminar de persona si existe
    DELETE FROM public.persona WHERE cliente_id = cliente_id;

    -- Eliminar de cliente
    DELETE FROM public.cliente WHERE cliente_id = cliente_id;

    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END;
$$ 
LANGUAGE 'plpgsql';





-- CATEGORIA_HABITACION
CREATE OR REPLACE FUNCTION pa_insert_categoria_habitacion(nom_cat VARCHAR(100), precio NUMERIC(10,2)) RETURNS int AS $$
DECLARE
    retorno int;
BEGIN
    INSERT INTO categoria_habitacion (nombre_categoria, precio_categoria)
    VALUES (nom_cat, precio)
    RETURNING categoria_id INTO retorno;
    RETURN retorno;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_update_categoria_habitacion(cat_id int, nom_cat VARCHAR(100), precio NUMERIC(10,2)) RETURNS int AS $$
BEGIN
    UPDATE categoria_habitacion
    SET nombre_categoria = nom_cat, precio_categoria = precio
    WHERE categoria_id = cat_id;
    RETURN cat_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_delete_categoria_habitacion(cat_id int) RETURNS int AS $$
BEGIN
    DELETE FROM categoria_habitacion
    WHERE categoria_id = cat_id;
    RETURN cat_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;





-- HABITACION
CREATE OR REPLACE FUNCTION pa_insert_habitacion(est_hab CHAR(1), descrip VARCHAR(100), cat_id int) RETURNS int AS $$
DECLARE
    retorno int;
BEGIN
    INSERT INTO habitacion (estado_habitacion, descripcion, categoria_habitacion_categoria_id)
    VALUES (est_hab, descrip, cat_id)
    RETURNING habitacion_id INTO retorno;
    RETURN retorno;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_update_habitacion(hab_id int, est_hab CHAR(1), desc VARCHAR(100), cat_id int) RETURNS int AS $$
BEGIN
    UPDATE habitacion
    SET estado_habitacion = est_hab, descripcion = desc, categoria_habitacion_categoria_id = cat_id
    WHERE habitacion_id = hab_id;
    RETURN hab_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_delete_habitacion(hab_id int) RETURNS int AS $$
BEGIN
    DELETE FROM habitacion
    WHERE habitacion_id = hab_id;
    RETURN hab_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;



-- EMPLEADO
CREATE OR REPLACE FUNCTION pa_insert_empleado(dni CHAR(8), ape_pat VARCHAR(100), ape_mat VARCHAR(100), nom VARCHAR(100), sex CHAR(1), mov CHAR(12)) RETURNS CHAR(8) AS $$
DECLARE
    retorno CHAR(8);
BEGIN
    INSERT INTO empleado (dni_empleado, apellido_pat, ape_materno, nombres, sexo, movil)
    VALUES (dni, ape_pat, ape_mat, nom, sex, mov)
    RETURNING dni_empleado INTO retorno;
    RETURN retorno;
EXCEPTION WHEN OTHERS THEN
    RETURN 'ERR';
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_update_empleado(dni CHAR(8), ape_pat VARCHAR(100), ape_mat VARCHAR(100), nom VARCHAR(100), sex CHAR(1), mov CHAR(12)) RETURNS CHAR(8) AS $$
BEGIN
    UPDATE empleado
    SET apellido_pat = ape_pat, ape_materno = ape_mat, nombres = nom, sexo = sex, movil = mov
    WHERE dni_empleado = dni;
    RETURN dni;
EXCEPTION WHEN OTHERS THEN
    RETURN 'ERR';
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_delete_empleado(dni CHAR(8)) RETURNS CHAR(8) AS $$
BEGIN
    DELETE FROM empleado
    WHERE dni_empleado = dni;
    RETURN dni;
EXCEPTION WHEN OTHERS THEN
    RETURN 'ERR';
END;
$$ LANGUAGE plpgsql;



-- MOTIVO_VIAJE
CREATE OR REPLACE FUNCTION pa_insert_motivo_viaje(desc_motivo VARCHAR(255)) RETURNS int AS $$
DECLARE
    retorno int;
BEGIN
    INSERT INTO motivo_viaje (descripcion_motivo)
    VALUES (desc_motivo)
    RETURNING motivo_id INTO retorno;
    RETURN retorno;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_update_motivo_viaje(mot_id int, desc_motivo VARCHAR(255)) RETURNS int AS $$
BEGIN
    UPDATE motivo_viaje
    SET descripcion_motivo = desc_motivo
    WHERE motivo_id = mot_id;
    RETURN mot_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_delete_motivo_viaje(mot_id int) RETURNS int AS $$
BEGIN
    DELETE FROM motivo_viaje
    WHERE motivo_id = mot_id;
    RETURN mot_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;



-- SERVICIO
CREATE OR REPLACE FUNCTION pa_insert_servicio(desc_servicio VARCHAR(255)) RETURNS int AS $$
DECLARE
    retorno int;
BEGIN
    INSERT INTO servicio (descricpion_servicio)
    VALUES (desc_servicio)
    RETURNING servicio_id INTO retorno;
    RETURN retorno;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_update_servicio(serv_id int, desc_servicio VARCHAR(255)) RETURNS int AS $$
BEGIN
    UPDATE servicio
    SET descricpion_servicio = desc_servicio
    WHERE servicio_id = serv_id;
    RETURN serv_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_delete_servicio(serv_id int) RETURNS int AS $$
BEGIN
    DELETE FROM servicio
    WHERE servicio_id = serv_id;
    RETURN serv_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;



-- TRANSACCION
CREATE OR REPLACE FUNCTION pa_insert_transaccion(tipo_trans CHAR(1), hab_id int, per_id int, fecha_ent DATE, hora_ent TIME, fecha_sal DATE, hora_sal TIME, dni_emp CHAR(8), cli_id int, mot_id int) RETURNS int AS $$
DECLARE
    retorno int;
BEGIN
    INSERT INTO transaccion (tipo_transaccion, habitacion_habitacion_id, persona_id, fecha_entrada, hora_entrada, fecha_salida, hora_salida, empleado_dni_empleado, cliente_cliente_id, motivo_viaje_motivo_id)
    VALUES (tipo_trans, hab_id, per_id, fecha_ent, hora_ent, fecha_sal, hora_sal, dni_emp, cli_id, mot_id)
    RETURNING transaccion_id INTO retorno;
    RETURN retorno;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_update_transaccion(trans_id int, tipo_trans CHAR(1), hab_id int, per_id int, fecha_ent DATE, hora_ent TIME, fecha_sal DATE, hora_sal TIME, dni_emp CHAR(8), cli_id int, mot_id int) RETURNS int AS $$
BEGIN
    UPDATE transaccion
    SET tipo_transaccion = tipo_trans, habitacion_habitacion_id = hab_id, persona_id = per_id, fecha_entrada = fecha_ent, hora_entrada = hora_ent, fecha_salida = fecha_sal, hora_salida = hora_sal, empleado_dni_empleado = dni_emp, cliente_cliente_id = cli_id, motivo_viaje_motivo_id = mot_id
    WHERE transaccion_id = trans_id;
    RETURN trans_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_delete_transaccion(trans_id int) RETURNS int AS $$
BEGIN
    DELETE FROM transaccion
    WHERE transaccion_id = trans_id;
    RETURN trans_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;



-- COMPROBANTE
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
--
CREATE OR REPLACE FUNCTION pa_update_comprobante(comp_id int, trans_id int, tipo_comp CHAR(1), num_comp VARCHAR(10), monto NUMERIC(10,2), dni_emp CHAR(8), cli_cli_id int) RETURNS int AS $$
BEGIN
    UPDATE comprobante
    SET transaccion_transaccion_id = trans_id, tipo_comprobante = tipo_comp, numero_comprobante = num_comp, monto_total = monto, empleado_dni_empleado = dni_emp, cliente_cliente_id = cli_cli_id
    WHERE comprobante_id = comp_id;
    RETURN comp_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_delete_comprobante(comp_id int) RETURNS int AS $$
BEGIN
    DELETE FROM comprobante
    WHERE comprobante_id = comp_id;
    RETURN comp_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;



-- DETALLE_ALOJAMIENTO
CREATE OR REPLACE FUNCTION pa_insert_detalle_alojamiento(trans_id int, per_cli_id int) RETURNS int AS $$
DECLARE
    retorno int;
BEGIN
    INSERT INTO detalle_alojamiento (transaccion_transaccion_id, persona_cliente_id)
    VALUES (trans_id, per_cli_id)
    RETURNING detalle_alojamiento_id INTO retorno;
    RETURN retorno;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_update_detalle_alojamiento(det_alo_id int, trans_id int, per_cli_id int) RETURNS int AS $$
BEGIN
    UPDATE detalle_alojamiento
    SET transaccion_transaccion_id = trans_id, persona_cliente_id = per_cli_id
    WHERE detalle_alojamiento_id = det_alo_id;
    RETURN det_alo_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_delete_detalle_alojamiento(det_alo_id int) RETURNS int AS $$
BEGIN
    DELETE FROM detalle_alojamiento
    WHERE detalle_alojamiento_id = det_alo_id;
    RETURN det_alo_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;



--DETALLE COMPROBANTE
CREATE OR REPLACE FUNCTION pa_insert_detalle_comprobante(comp_id int, desc VARCHAR(255), cantidad int, precio_unit NUMERIC(10,2)) RETURNS int AS $$
DECLARE
    retorno int;
BEGIN
    INSERT INTO detalle_comprobante (comprobante_comprobante_id, descripcion, cantidad, precio_unitario)
    VALUES (comp_id, desc, cantidad, precio_unit)
    RETURNING detalle_comprobante_id INTO retorno;
    RETURN retorno;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_update_detalle_comprobante(det_comp_id int, comp_id int, desc VARCHAR(255), cantidad int, precio_unit NUMERIC(10,2)) RETURNS int AS $$
BEGIN
    UPDATE detalle_comprobante
    SET comprobante_comprobante_id = comp_id, descripcion = desc, cantidad = cantidad, precio_unitario = precio_unit
    WHERE detalle_comprobante_id = det_comp_id;
    RETURN det_comp_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION pa_delete_detalle_comprobante(det_comp_id int) RETURNS int AS $$
BEGIN
    DELETE FROM detalle_comprobante
    WHERE detalle_comprobante_id = det_comp_id;
    RETURN det_comp_id;
EXCEPTION WHEN OTHERS THEN
    RETURN -1;
END;
$$ LANGUAGE plpgsql;



-- DETALLE_SERVICIOS
create or replace function pa_insert_detalle_servicios(serv_id int, trans_id int, cantidad int, precio numeric(10,2)) returns int as $$
declare
    retorno int;
begin
    insert into detalle_servicios (servicio_servicio_id, transaccion_transaccion_id, cantidad, precio_total)
    values (serv_id, trans_id, cantidad, precio)
    returning detalle_servicios_id into retorno;
    return retorno;
exception when others then
    return -1;
end;
$$ language plpgsql;
--
create or replace function pa_update_detalle_servicios(det_serv_id int, serv_id int, trans_id int, cantidad int, precio numeric(10,2)) returns int as $$
begin
    update detalle_servicios
    set servicio_servicio_id = serv_id, transaccion_transaccion_id = trans_id, cantidad = cantidad, precio_total = precio
    where detalle_servicios_id = det_serv_id;
    return det_serv_id;
exception when others then
    return -1;
end;
$$ language plpgsql;
--
create or replace function pa_delete_detalle_servicios(det_serv_id int) returns int as $$
begin
    delete from detalle_servicios
    where detalle_servicios_id = det_serv_id;
    return det_serv_id;
exception when others then
    return -1;
end;
$$ language plpgsql;






