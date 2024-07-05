CREATE TABLE pais (
    codigo_pais CHAR(3) PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL
);

CREATE TABLE categoria_habitacion (
    categoria_id     SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL,
    precio_categoria numeric(10, 2) NOT NULL
);

CREATE TABLE tipo_empresa (
    tipo_id     SERIAL PRIMARY KEY,
    nombre_tipo VARCHAR(100) NOT NULL
);

CREATE TABLE habitacion (
    habitacion_id                     SERIAL PRIMARY KEY,
    estado_habitacion                 CHAR(1) NOT NULL,
    descripcion                       varchar(100) NOT NULL,
    categoria_habitacion_categoria_id INTEGER NOT NULL,
    FOREIGN KEY (categoria_habitacion_categoria_id) REFERENCES categoria_habitacion (categoria_id)
);

COMMENT ON COLUMN habitacion.estado_habitacion IS 'O: Ocupada D: Disponible M: Mantenimiento R: Reservada';

COMMENT ON COLUMN habitacion.descripcion IS 'Por ej. Habitación con vista a la calle.';

CREATE TABLE cliente (
    cliente_id       SERIAL PRIMARY KEY,
    direccion        VARCHAR(255),
    telefono         varchar(14), ---Loss numeros de teléfono están entre 8 y 11, agregándole el +(..)
    f_registro       DATE default current_date,
    tipo_doc         VARCHAR(20) NOT NULL,
    numero_documento VARCHAR(20) unique,
    pais_codigo_pais CHAR(3) NOT NULL,
    FOREIGN KEY (pais_codigo_pais) REFERENCES pais (codigo_pais)
);
ALTER TABLE cliente
ADD CONSTRAINT chk_telefono
CHECK (telefono ~ '^(?:\+\d{2})?\d{8,11}$');

CREATE TABLE empleado (
    dni_empleado char(8) PRIMARY KEY,
    apellido_pat VARCHAR(100) NOT NULL,
    ape_materno  VARCHAR(100) NOT NULL,
    nombres      VARCHAR(100) NOT NULL,
    sexo         CHAR(1) NOT NULL,
    movil        char(12) NOT NULL,
    f_alta       DATE default current_date,
    f_baja       DATE
);

CREATE TABLE motivo_viaje (
    motivo_id          SERIAL PRIMARY KEY,
    descripcion_motivo VARCHAR(255) not null
);

CREATE TABLE persona (
    cliente_id  INTEGER PRIMARY KEY,
    ape_paterno VARCHAR(100) not null,
    ape_materno VARCHAR(100) not null,
    nombres     VARCHAR(100) not null,
    sexo        CHAR(1) not null,
    FOREIGN KEY (cliente_id) REFERENCES cliente (cliente_id)
);

CREATE TABLE servicio (
    servicio_id          SERIAL PRIMARY KEY,
    descricpion_servicio varchar(150) NOT NULL
);

COMMENT ON COLUMN servicio.servicio_id IS '1 Alojamiento 2 Restaurante 3 Cochera 4 Transporte';

CREATE TABLE empresa (
    cliente_id           INTEGER PRIMARY KEY,
    razon_social         VARCHAR(255) not null,
    tipo_empresa_tipo_id INTEGER NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente (cliente_id),
    FOREIGN KEY (tipo_empresa_tipo_id) REFERENCES tipo_empresa (tipo_id)
);

CREATE TABLE transaccion (
    transaccion_id           SERIAL PRIMARY KEY,
    fecha_registro           DATE default current_date,
    hora_registro            TIME default current_time,
    tipo_transaccion         CHAR(1) default 'C',
    habitacion_habitacion_id INTEGER NOT NULL,
    fecha_entrada	     date default current_date,
    hora_entrada	     time default current_time,
    fecha_salida             DATE,
    hora_salida              TIME,
    empleado_dni_empleado    CHAR(8) NOT NULL,
    cliente_cliente_id       INTEGER NOT NULL,
    motivo_viaje_motivo_id   INTEGER NOT NULL,
    FOREIGN KEY (habitacion_habitacion_id) REFERENCES habitacion (habitacion_id),
    FOREIGN KEY (persona_id) REFERENCES persona (cliente_id),
    FOREIGN KEY (empleado_dni_empleado) REFERENCES empleado (dni_empleado),
    FOREIGN KEY (cliente_cliente_id) REFERENCES cliente (cliente_id),
    FOREIGN KEY (motivo_viaje_motivo_id) REFERENCES motivo_viaje (motivo_id)
);

COMMENT ON COLUMN transaccion.tipo_transaccion IS '1 Reserva 2 Confirmacion';

CREATE TABLE comprobante (
    comprobante_id             SERIAL PRIMARY KEY,
    transaccion_transaccion_id INTEGER NOT NULL,
    tipo_comprobante           char(2) not null, --'B','F','BE','FE'
    numero_comprobante         char(10) unique not null,
    fecha_comprobante          DATE default current_date,
    hora_comprobante           TIME default current_time,
    monto_total                numeric(10,2),
    empleado_dni_empleado      VARCHAR(8) NOT NULL, 
    cliente_cliente_id         INTEGER NOT NULL,
    FOREIGN KEY (transaccion_transaccion_id) REFERENCES transaccion (transaccion_id),
    FOREIGN KEY (cliente_cliente_id) REFERENCES cliente (cliente_id),
    FOREIGN KEY (empleado_dni_empleado) REFERENCES empleado (dni_empleado),
	CHECK(tipo_comprobante in ('B','F','BE','FE'))
);

CREATE TABLE detalle_alojamiento (
    transaccion_transaccion_id INTEGER NOT NULL,
    persona_cliente_id         INTEGER NOT NULL,
    PRIMARY KEY (transaccion_transaccion_id, persona_cliente_id),
    FOREIGN KEY (transaccion_transaccion_id) REFERENCES transaccion (transaccion_id),
    FOREIGN KEY (persona_cliente_id) REFERENCES persona (cliente_id)
);

CREATE TABLE detalle_comprobante (
    servicio_servicio_id       INTEGER NOT NULL,
    comprobante_comprobante_id INTEGER NOT NULL,
    monto                      numeric(10, 2),
    PRIMARY KEY (servicio_servicio_id, comprobante_comprobante_id),
    FOREIGN KEY (comprobante_comprobante_id) REFERENCES comprobante (comprobante_id),
    FOREIGN KEY (servicio_servicio_id) REFERENCES servicio (servicio_id)
);

CREATE TABLE detalle_servicios (
    detalle_id                 SERIAL PRIMARY KEY,
    fecha_solicitud            DATE default current_date,
    hora_solicitud             TIME default current_time,
    descripcion_solicitud      varchar(100),
    monto_servicio             numeric(10, 2) not null,
    transaccion_transaccion_id INTEGER NOT NULL,
    servicio_servicio_id       INTEGER NOT NULL,
    FOREIGN KEY (transaccion_transaccion_id) REFERENCES transaccion (transaccion_id),
    FOREIGN KEY (servicio_servicio_id) REFERENCES servicio (servicio_id)
);
