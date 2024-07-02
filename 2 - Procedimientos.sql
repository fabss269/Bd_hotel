
-- PAIS
create or replace function 	pa_insert_pais(
		p_codigo_pais char(3),
		p_nombre varchar(100)
	) 	
returns char(3) 
as $$
declare
    retorno char(3);
begin
    insert into pais (codigo_pais, nombre) 
		values (p_codigo_pais, p_nombre)
    returning codigo_pais into retorno;
    return retorno;
exception when others then
    return null;
end;
$$ language 'plpgsql';

create or replace function pa_update_pais (
    codigo_pais char(3), 
    nombre varchar
    )
returns boolean 
as $$
begin
    update pais
    set nombre = nombre
    where codigo_pais = codigo_pais;
    return true;
exception when others then
    return false;
end;
$$ language 'plpgsql';

create or replace function pa_delete_pais(codigo_pais char(3))
returns boolean as $$
begin
    delete from pais
    where codigo_pais = codigo_pais;
    return true;
exception when others then
    return false;
end;
$$ language 'plpgsql';

-- motivo_viaje

create or replace function pa_insert_motivo_viaje (
    descripcion_motivo varchar
    )
returns integer 
    as $$
declare
    retorno integer;
begin
    insert into motivo_viaje (descripcion_motivo) 
    values (descripcion_motivo)
    returning motivo_id into retorno;
    return retorno;
exception
    when others then
        return -1;
end;
$$ language 'plpgsql';

create or replace function pa_update_motivo_viaje(motivo_id integer, descripcion_motivo varchar)
returns boolean as $$
begin
    update motivo_viaje
    set descripcion_motivo = descripcion_motivo
    where motivo_id = motivo_id;
    return true;
exception
    when others then
        return false;
end;
$$ language 'plpgsql';

create or replace function pa_delete_motivo_viaje(motivo_id integer)
returns boolean as $$
begin
    delete from motivo_viaje
    where motivo_id = motivo_id;
    return true;
exception
    when others then
        return false;
end;
$$ language 'plpgsql';

-- categoria_habitacion

create or replace function pa_insert_categoria_habitacion(
    nombre_categoria varchar, 
    precio_categoria numeric
    )
returns integer 
as $$
declare
    retorno integer;
begin
    insert into categoria_habitacion (nombre_categoria, precio_categoria) 
    values (nombre_categoria, precio_categoria)
    returning categoria_id into retorno;
    return retorno;
exception
    when others then
        return -1;
end;
$$ language 'plpgsql';

create or replace function pa_update_categoria_habitacion(categoria_id integer, nombre_categoria varchar, precio_categoria numeric)
returns boolean as $$
begin
    update categoria_habitacion
    set nombre_categoria = nombre_categoria,
        precio_categoria = precio_categoria
    where categoria_id = categoria_id;
    return true;
exception
    when others then
        return false;
end;
$$ language 'plpgsql';

create or replace function pa_delete_categoria_habitacion(categoria_id integer)
returns boolean as $$
begin
    delete from categoria_habitacion
    where categoria_id = categoria_id;
    return true;
exception
    when others then
        return false;
end;
$$ language 'plpgsql';

-- tipo_empresa

create or replace function pa_insert_tipo_empresa(nombre_tipo varchar)
returns integer as $$
declare
    retorno integer;
begin
    insert into tipo_empresa (nombre_tipo) 
    values (nombre_tipo)
    returning tipo_id into retorno;
    return retorno;
exception
    when others then
        return -1;
end;
$$ language 'plpgsql';

create or replace function pa_update_tipo_empresa(tipo_id integer, nombre_tipo varchar)
returns boolean as $$
begin
    update tipo_empresa
    set nombre_tipo = nombre_tipo
    where tipo_id = tipo_id;
    return true;
exception
    when others then
        return false;
end;
$$ language 'plpgsql';

create or replace function pa_delete_tipo_empresa(tipo_id integer)
returns boolean as $$
begin
    delete from tipo_empresa
    where tipo_id = tipo_id;
    return true;
exception
    when others then
        return false;
end;
$$ language 'plpgsql';

-- habitacion

create or replace function pa_insert_habitacion(estado_habitacion char(1), descripcion varchar, categoria_habitacion_categoria_id integer)
returns integer as $$
declare
    retorno integer;
begin
    insert into habitacion (estado_habitacion, descripcion, categoria_habitacion_categoria_id) 
    values (estado_habitacion, descripcion, categoria_habitacion_categoria_id)
    returning habitacion_id into retorno;
    return retorno;
exception
    when others then
        return -1;
end;
$$ language 'plpgsql';

create or replace function pa_update_habitacion(habitacion_id integer, estado_habitacion char(1), descripcion varchar, categoria_habitacion_categoria_id integer)
returns boolean as $$
begin
    update habitacion
    set estado_habitacion = estado_habitacion,
        descripcion = descripcion,
        categoria_habitacion_categoria_id = categoria_habitacion_categoria_id
    where habitacion_id = habitacion_id;
    return true;
exception
    when others then
        return false;
end;
$$ language 'plpgsql';

create or replace function pa_delete_habitacion(habitacion_id integer)
returns boolean as $$
begin
    delete from habitacion
    where habitacion_id = habitacion_id;
    return true;
exception
    when others then
        return false;
end;
$$ language 'plpgsql';













