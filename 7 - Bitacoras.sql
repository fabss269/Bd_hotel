------------------------------------BITACORA_DETALLE_SERVICIOS------------------------------------
CREATE TABLE BITACORA_DETALLE_SERVICIOS
(
	bitacora_ds_id serial primary key,
-----------------------------------
	detalle_id int,
	fecha_solicitud date,
	hora_solicitud time,
	descripcion_solicitud varchar(100),
	monto_servicio numeric (10,2),
	transaccion_transaccion_id int,
	servicio_servicio_id int,
-----------------------------------
	f_actualizacion date,
	h_actualizacion time,
	usuario varchar(20),
	maquina_ip inet,
	operacion varchar(10)  --IN, 
);

create or replace function fn_bitacora_detalle_servicio() returns trigger as
$$
declare
begin
	--inet_client_addr()
	--inet_server_addr()
	if tg_op='INSERT' THEN
		INSERT INTO bitacora_detalle_servicios(detalle_id, fecha_solicitud, hora_solicitud, 
											   descripcion_solicitud, monto_servicio, transaccion_transaccion_id, 
											servicio_servicio_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (new.detalle_id, new.fecha_solicitud, new.hora_solicitud, new.descripcion_solicitud, new.monto_servicio, 
			new.transaccion_transaccion_id, new.servicio_servicio_id, current_date, current_time, 
				current_user, inet_client_addr(), 'IN');
			
		return new;
	end if;
	
	if tg_op='DELETE' THEN
		INSERT INTO bitacora_detalle_servicios(detalle_id, fecha_solicitud, hora_solicitud, descripcion_solicitud, monto_servicio, 
			transaccion_transaccion_id, servicio_servicio_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (old.detalle_id, old.fecha_solicitud, old.hora_solicitud, old.descripcion_solicitud, old.monto_servicio, 
			old.transaccion_transaccion_id, old.servicio_servicio_id, current_date, current_time, 
				current_user, inet_client_addr(), 'DE');
				
		return old;
	end if;
	
	
	if tg_op='UPDATE' THEN
	
		INSERT INTO bitacora_detalle_servicios(detalle_id, fecha_solicitud, hora_solicitud, descripcion_solicitud, monto_servicio, 
			transaccion_transaccion_id, servicio_servicio_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (new.detalle_id, new.fecha_solicitud, new.hora_solicitud, new.descripcion_solicitud, new.monto_servicio, 
			new.transaccion_transaccion_id, new.servicio_servicio_id, current_date, current_time, 
				current_user, inet_client_addr(), 'UA');
			
		return new;
	
		INSERT INTO bitacora_detalle_servicios(detalle_id, fecha_solicitud, hora_solicitud, descripcion_solicitud, monto_servicio, 
			transaccion_transaccion_id, servicio_servicio_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (old.detalle_id, old.fecha_solicitud, old.hora_solicitud, old.descripcion_solicitud, old.monto_servicio, 
			old.transaccion_transaccion_id, old.servicio_servicio_id, current_date, current_time, 
				current_user, inet_client_addr(), 'UD');
				
		return old;
	end if;
end
$$ language 'plpgsql';


Create or replace trigger tr_fn_bitacora_detalle_servicio after delete OR insert OR update on detalle_servicios
	for each row execute procedure fn_bitacora_detalle_servicio();

select * from transaccion;

select* from habitacion;
select * from categoria_habitacion;
select * from servicio;

INSERT INTO detalle_servicios(descripcion_solicitud, monto_servicio, 
			transaccion_transaccion_id, servicio_servicio_id) values ('Por los días que se quedó', 225, 2, 1);
select * from bitacora_detalle_servicios;


------------------------------------BITACORA_COMPROBANTE------------------------------------
CREATE TABLE BITACORA_COMPROBANTE
(
	bitacora_comp_id serial primary key,
-----------------------------------
	comprobante_id             int,
    transaccion_transaccion_id INTEGER NOT NULL,
    tipo_comprobante           char(2) not null, --'B','F','BE','FE'
    numero_comprobante         char(10) not null,
    fecha_comprobante          DATE,
    hora_comprobante           TIME,
    monto_total                numeric(10,2),
    empleado_dni_empleado      VARCHAR(8) NOT NULL, 
    cliente_cliente_id         INTEGER NOT NULL, --para borrar
-----------------------------------
	f_actualizacion date,
	h_actualizacion time,
	usuario varchar(20),
	maquina_ip inet,
	operacion varchar(10)  --IN, 
);

create or replace function fn_bitacora_comprobante() returns trigger as
$$
declare
begin
	--inet_client_addr()
	--inet_server_addr()
	if tg_op='INSERT' THEN
		INSERT INTO BITACORA_COMPROBANTE(comprobante_id, transaccion_transaccion_id, tipo_comprobante, numero_comprobante, 
						fecha_comprobante, hora_comprobante, monto_total, empleado_dni_empleado, cliente_cliente_id,
											  f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (new.comprobante_id, new.transaccion_transaccion_id, new.tipo_comprobante, new.numero_comprobante, 
		new.fecha_comprobante, new.hora_comprobante, new.monto_total, new.empleado_dni_empleado, new.cliente_cliente_id,
		current_date, current_time, current_user, inet_client_addr(), 'IN');
			
		return new;
	end if;
	
	if tg_op='DELETE' THEN
		INSERT INTO BITACORA_COMPROBANTE(comprobante_id, transaccion_transaccion_id, tipo_comprobante, numero_comprobante, 
						fecha_comprobante, hora_comprobante, monto_total, empleado_dni_empleado, cliente_cliente_id,
											  f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (old.comprobante_id, old.transaccion_transaccion_id, old.tipo_comprobante, old.numero_comprobante, 
		old.fecha_comprobante, old.hora_comprobante, old.monto_total, old.empleado_dni_empleado, old.cliente_cliente_id,
		current_date, current_time, current_user, inet_client_addr(), 'DE');
				
		return old;
	end if;
	
	
	if tg_op='UPDATE' THEN
	
		INSERT INTO BITACORA_COMPROBANTE(comprobante_id, transaccion_transaccion_id, tipo_comprobante, numero_comprobante, 
						fecha_comprobante, hora_comprobante, monto_total, empleado_dni_empleado, cliente_cliente_id,
											  f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (new.comprobante_id, new.transaccion_transaccion_id, new.tipo_comprobante, new.numero_comprobante, 
		new.fecha_comprobante, new.hora_comprobante, new.monto_total, new.empleado_dni_empleado, new.cliente_cliente_id,
				current_date, current_time, current_user, inet_client_addr(), 'UA');
			
		return new;
	
		INSERT INTO BITACORA_COMPROBANTE(comprobante_id, transaccion_transaccion_id, tipo_comprobante, numero_comprobante, 
						fecha_comprobante, hora_comprobante, monto_total, empleado_dni_empleado, cliente_cliente_id,
											  f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (old.comprobante_id, old.transaccion_transaccion_id, old.tipo_comprobante, old.numero_comprobante, 
		old.fecha_comprobante, old.hora_comprobante, old.monto_total, old.empleado_dni_empleado, old.cliente_cliente_id,
		current_date, current_time, current_user, inet_client_addr(), 'UD');
				
		return old;
	end if;
end
$$ language 'plpgsql';


Create or replace trigger tr_fn_bitacora_comprobante after delete OR insert OR update on comprobante
	for each row execute procedure fn_bitacora_comprobante();
	
select * from transaccion;
select* from habitacion;
select * from categoria_habitacion;
select * from servicio;
select * from comprobante;
select * from cliente;

INSERT INTO comprobante(transaccion_transaccion_id, tipo_comprobante, numero_comprobante, 
							  monto_total, empleado_dni_empleado, cliente_cliente_id) 
							  values (2, 'BE', 00000003, 500, 12345678, 1);
select * from bitacora_comprobante;


------------------------------------BITACORA_DETALLE_COMPROBANTE------------------------------------
CREATE TABLE BITACORA_DETALLE_COMPROBANTE
(
	bitacora_detcomp_id serial primary key,
-----------------------------------
	servicio_servicio_id       INTEGER NOT NULL,
    comprobante_comprobante_id INTEGER NOT NULL,
    monto                      numeric(10, 2),
-----------------------------------
	f_actualizacion date,
	h_actualizacion time,
	usuario varchar(20),
	maquina_ip inet,
	operacion varchar(10)  --IN, 
);

create or replace function fn_bitacora_detalle_comprobante() returns trigger as
$$
declare
begin
	--inet_client_addr()
	--inet_server_addr()
	if tg_op='INSERT' THEN
		INSERT INTO BITACORA_DETALLE_COMPROBANTE(servicio_servicio_id, comprobante_comprobante_id, monto,
											  f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (new.servicio_servicio_id, NEW.comprobante_comprobante_id, new.monto,
		current_date, current_time, current_user, inet_client_addr(), 'IN');
			
		return new;
	end if;
	
	if tg_op='DELETE' THEN
		INSERT INTO BITACORA_DETALLE_COMPROBANTE(servicio_servicio_id, comprobante_comprobante_id, monto,
											  f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (old.servicio_servicio_id, old.comprobante_comprobante_id, old.monto,
		current_date, current_time, current_user, inet_client_addr(), 'DE');
				
		return old;
	end if;
	
	
	if tg_op='UPDATE' THEN
	
		INSERT INTO BITACORA_DETALLE_COMPROBANTE(servicio_servicio_id, comprobante_comprobante_id, monto,
											  f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (new.servicio_servicio_id, NEW.comprobante_comprobante_id, new.monto,
		current_date, current_time, current_user, inet_client_addr(), 'UA');
			
		return new;
	
		INSERT INTO BITACORA_DETALLE_COMPROBANTE(servicio_servicio_id, comprobante_comprobante_id, monto,
											  f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
		VALUES (old.servicio_servicio_id, old.comprobante_comprobante_id, old.monto,
		current_date, current_time, current_user, inet_client_addr(), 'UD');
				
		return old;
	end if;
end
$$ language 'plpgsql';


Create or replace trigger tr_fn_bitacora_detalle_comprobante after delete OR insert OR update on comprobante
	for each row execute procedure fn_bitacora_detalle_comprobante();
	
------------------------------------BITACORA_TRANSACCION------------------------------------
CREATE TABLE BITACORA_TRANSACCION
(
    bitacora_trans_id serial primary key,
    transaccion_id           int,
    fecha_registro           date,
    hora_registro            time,
    tipo_transaccion         char(1),
    habitacion_habitacion_id int,
    fecha_entrada            date,
    hora_entrada             time,
    fecha_salida             date,
    hora_salida              time,
    empleado_dni_empleado    char(8),
    cliente_cliente_id       int,
    motivo_viaje_motivo_id   int,
    f_actualizacion          date,
    h_actualizacion          time,
    usuario                  varchar(20),
    maquina_ip               inet,
    operacion                varchar(10)
);

CREATE OR REPLACE FUNCTION fn_bitacora_transaccion() RETURNS trigger AS
$$
DECLARE
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO BITACORA_TRANSACCION(transaccion_id, fecha_registro, hora_registro, tipo_transaccion, habitacion_habitacion_id, 
                                         fecha_entrada, hora_entrada, fecha_salida, hora_salida, empleado_dni_empleado, 
                                         cliente_cliente_id, motivo_viaje_motivo_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
        VALUES (NEW.transaccion_id, NEW.fecha_registro, NEW.hora_registro, NEW.tipo_transaccion, NEW.habitacion_habitacion_id, 
                NEW.fecha_entrada, NEW.hora_entrada, NEW.fecha_salida, NEW.hora_salida, NEW.empleado_dni_empleado, 
                NEW.cliente_cliente_id, NEW.motivo_viaje_motivo_id, current_date, current_time, current_user, inet_client_addr(), 'IN');
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO BITACORA_TRANSACCION(transaccion_id, fecha_registro, hora_registro, tipo_transaccion, habitacion_habitacion_id, 
                                       fecha_entrada, hora_entrada, fecha_salida, hora_salida, empleado_dni_empleado, 
                                         cliente_cliente_id, motivo_viaje_motivo_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
        VALUES (OLD.transaccion_id, OLD.fecha_registro, OLD.hora_registro, OLD.tipo_transaccion, OLD.habitacion_habitacion_id, 
                 OLD.fecha_entrada, OLD.hora_entrada, OLD.fecha_salida, OLD.hora_salida, OLD.empleado_dni_empleado, 
                OLD.cliente_cliente_id, OLD.motivo_viaje_motivo_id, current_date, current_time, current_user, inet_client_addr(), 'DE');
        RETURN OLD;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO BITACORA_TRANSACCION(transaccion_id, fecha_registro, hora_registro, tipo_transaccion, habitacion_habitacion_id, 
                                          fecha_entrada, hora_entrada, fecha_salida, hora_salida, empleado_dni_empleado, 
                                         cliente_cliente_id, motivo_viaje_motivo_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
        VALUES (NEW.transaccion_id, NEW.fecha_registro, NEW.hora_registro, NEW.tipo_transaccion, NEW.habitacion_habitacion_id, 
                 NEW.fecha_entrada, NEW.hora_entrada, NEW.fecha_salida, NEW.hora_salida, NEW.empleado_dni_empleado, 
                NEW.cliente_cliente_id, NEW.motivo_viaje_motivo_id, current_date, current_time, current_user, inet_client_addr(), 'UA');
        
        INSERT INTO BITACORA_TRANSACCION(transaccion_id, fecha_registro, hora_registro, tipo_transaccion, habitacion_habitacion_id, 
                                         persona_id, fecha_entrada, hora_entrada, fecha_salida, hora_salida, empleado_dni_empleado, 
                                         cliente_cliente_id, motivo_viaje_motivo_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
        VALUES (OLD.transaccion_id, OLD.fecha_registro, OLD.hora_registro, OLD.tipo_transaccion, OLD.habitacion_habitacion_id, 
                 OLD.fecha_entrada, OLD.hora_entrada, OLD.fecha_salida, OLD.hora_salida, OLD.empleado_dni_empleado, 
                OLD.cliente_cliente_id, OLD.motivo_viaje_motivo_id, current_date, current_time, current_user, inet_client_addr(), 'UD');
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE TRIGGER tr_fn_bitacora_transaccion AFTER INSERT OR DELETE OR UPDATE ON transaccion 
FOR EACH ROW EXECUTE FUNCTION fn_bitacora_transaccion();

select * from bitacora_transaccion;

------------------------------------BITACORA_DETALLE_ALOJAMIENTO------------------------------------
-- create table bitacora_detalle_alojamiento
-- (
--     bitacora_da_id serial primary key,
-- 	--------------------------------------------------------
--     transaccion_transaccion_id int,
--     persona_cliente_id int,
-- 	--------------------------------------------------------------
--     f_actualizacion date,
--     h_actualizacion time,
--     usuario varchar(20),
--     maquina_ip inet,
--     operacion varchar(10)  -- in, de, ua, ud
-- );

-- create or replace function fn_bitacora_detalle_alojamiento() returns trigger as
-- $$
-- declare
-- begin
--     if tg_op = 'insert' then
--         insert into bitacora_detalle_alojamiento(transaccion_transaccion_id, persona_cliente_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
--         values (new.transaccion_transaccion_id, new.persona_cliente_id, current_date, current_time, current_user, inet_client_addr(), 'in');
--         return new;
--     elsif tg_op = 'delete' then
--         insert into bitacora_detalle_alojamiento(transaccion_transaccion_id, persona_cliente_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
--         values (old.transaccion_transaccion_id, old.persona_cliente_id, current_date, current_time, current_user, inet_client_addr(), 'de');
--         return old;
--     elsif tg_op = 'update' then
--         insert into bitacora_detalle_alojamiento(transaccion_transaccion_id, persona_cliente_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
--         values (new.transaccion_transaccion_id, new.persona_cliente_id, current_date, current_time, current_user, inet_client_addr(), 'ua');
        
--         insert into bitacora_detalle_alojamiento(transaccion_transaccion_id, persona_cliente_id, f_actualizacion, h_actualizacion, usuario, maquina_ip, operacion)
--         values (old.transaccion_transaccion_id, old.persona_cliente_id, current_date, current_time, current_user, inet_client_addr(), 'ud');
--         return new;
--     end if;
-- end;
-- $$ language 'plpgsql';

-- create or replace trigger tr_fn_bitacora_detalle_alojamiento
-- after insert or delete or update on detalle_alojamiento
-- for each row execute function fn_bitacora_detalle_alojamiento();
