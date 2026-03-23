-- Autores: Lucía Cepeda González, Adriana Rubia Alcarria
-- Descripción: Script páctica 3 - creación de tablas

-- En Luna4 se almacenarán los fragmentos correspondientes a la delegación de Granada (localidad 4)
-- que son los fragmentos F15, F16, F17, F18 y F19.
-- suministra vinos a clientes de 'Canarias','Andalucía','Extremadura','Melilla','Ceuta'


-- DROPS 

DROP TABLE Empleado4 CASCADE CONSTRAINTS;
DROP TABLE Sucursal4 CASCADE CONSTRAINTS;
DROP TABLE Cliente4 CASCADE CONSTRAINTS;
DROP TABLE Vino4 CASCADE CONSTRAINTS;
DROP TABLE Productor CASCADE CONSTRAINTS;
DROP TABLE SucursalVendeVino4 CASCADE CONSTRAINTS;
DROP TABLE ClienteSolicitaSuministro4 CASCADE CONSTRAINTS;
DROP TABLE SucursalPideSuministro CASCADE CONSTRAINTS;  


-- TABLAS

CREATE TABLE Empleado4 (
    cod_empleado          NUMBER(6) PRIMARY KEY, --TRPK hecho
    DNI_empleado          VARCHAR2(9) NOT NULL, -- DNI son (8 números + letra) y NIE (letra + 7 números + letra)
    nombre_empleado       VARCHAR2(50) NOT NULL,
    fecha_inicio_contrato DATE NOT NULL,
    direccion_empleado    VARCHAR2(100),
    salario               NUMBER(8,2) DEFAULT 0 NOT NULL,
    cod_sucursal          NUMBER(6) NOT NULL 
--TRFK cod_sucursal hecho 
);

CREATE TABLE Sucursal4 (
    cod_sucursal     NUMBER(6) PRIMARY KEY, --TRPK hecho
    nombre_sucursal  VARCHAR2(50) NOT NULL,
    ciudad_sucursal  VARCHAR2(50) NOT NULL,
    ca_sucursal      VARCHAR2(20) NOT NULL,
    cod_director     NUMBER(6),
	UNIQUE (cod_director)  --TR Unico (globalmente) -NO FUNCIONAN PROCEDIMIENTOS (6) CON ESTE TRIGGER HABILITADO!
--TRFK cod_director hecho
);

CREATE TABLE Cliente4 (
    cod_cliente       NUMBER(6) PRIMARY KEY, --TRPK hecho
    DNI_cliente       VARCHAR2(9) NOT NULL,
    nombre_cliente    VARCHAR2(50) NOT NULL,
    direccion_cliente VARCHAR2(100) NOT NULL,
    tipo_cliente      VARCHAR2(1) NOT NULL,
    ca_cliente        VARCHAR2(20) NOT NULL,
    CHECK (tipo_cliente IN ('A', 'B', 'C')) --TR hecho
);

CREATE TABLE Productor (
    cod_productor       NUMBER(6) PRIMARY KEY, --TRPK hecho
    DNI_productor       VARCHAR2(9) NOT NULL,
    nombre_productor    VARCHAR2(50) NOT NULL,
    direccion_productor VARCHAR2(100) NOT NULL
);

CREATE TABLE Vino4 (
    cod_vino            NUMBER(6) PRIMARY KEY, --TRPK hecho
    marca               VARCHAR2(50) NOT NULL,
    anio_cosecha        NUMBER(4) NOT NULL,
    origen              VARCHAR2(100), -- Si la tiene -> puede ser NULL
    graduacion          NUMBER(4,2) NOT NULL,
    procedencia         VARCHAR2(50) NOT NULL,
    cantidad_producida  NUMBER(6) DEFAULT 0 NOT NULL,
    cod_productor       NUMBER(6) NOT NULL,
    cantidad_stock      NUMBER(6) DEFAULT 0 NOT NULL,
    ca_vino             VARCHAR2(20) NOT NULL,
    CHECK (cantidad_stock BETWEEN 0 AND cantidad_producida)
   --TRFK cod_productor hecho (13)
);

-- Tablas de relaciones

CREATE TABLE SucursalVendeVino4 (
    cod_sucursal NUMBER(6) NOT NULL,
    cod_vino     NUMBER(6) NOT NULL,
    PRIMARY KEY (cod_sucursal, cod_vino) --TRPK hecho
--TRFK codsucursal hecho 
--TRFK codvino hecho
);

CREATE TABLE ClienteSolicitaSuministro4 (
    cod_cliente         NUMBER(6) NOT NULL,
    cod_sucursal        NUMBER(6) NOT NULL, --debe ser de la delegacion de la comunidad autonoma del cliente --FK hecho (9)
    cod_vino            NUMBER(6) NOT NULL,
    fecha_suministro    DATE NOT NULL,
    cantidad_suministro NUMBER(6) DEFAULT 0 NOT NULL,
    PRIMARY KEY (cod_sucursal, cod_vino, cod_cliente, fecha_suministro) --TRPK hecho
--TRFK codcliente hecho
--TRFK codsucursal hecho
--TRFK codvino hecho (11)
);

CREATE TABLE SucursalPideSuministro (
    cod_sucursal_solicita NUMBER(6) NOT NULL,
    cod_sucursal_provee   NUMBER(6) NOT NULL,
    cod_vino              NUMBER(6) NOT NULL,
    fecha_pedido          DATE NOT NULL,
    cantidad_pedido       NUMBER(6) DEFAULT 0 NOT NULL,
    PRIMARY KEY (cod_sucursal_solicita, cod_vino, cod_sucursal_provee, fecha_pedido) --TRPK hecho
--TRFK (cod_sucursal_provee, cod_vino) REFERENCES SucursalVendeVino  hecho
--TRFK cod_sucursal_solicita hecho
--TRFK cod_sucursal_provee hecho
--TRFK cod_vino hecho (12)
);


-- GRANTS
-- Para conectar las cuatro “localidades” y poder acceder desde cualquiera de ellas a los datos almacenados en las demás localidades
-- debemos conceder permisos desde cada cuenta 

GRANT SELECT, INSERT, UPDATE, DELETE ON Empleado4 TO luna1, luna2, luna3;

GRANT SELECT, INSERT, UPDATE, DELETE ON Sucursal4 TO luna1, luna2, luna3;

GRANT SELECT, INSERT, UPDATE, DELETE ON Cliente4 TO luna1, luna2, luna3;

GRANT SELECT, INSERT, UPDATE, DELETE ON Vino4 TO luna1, luna2, luna3;

GRANT SELECT, INSERT, UPDATE, DELETE ON SucursalVendeVino4 TO luna1, luna2, luna3;

GRANT SELECT, INSERT, UPDATE, DELETE ON ClienteSolicitaSuministro4 TO luna1, luna2, luna3;

GRANT SELECT, INSERT, UPDATE, DELETE ON SucursalPideSuministro TO luna1, luna2, luna3;

GRANT SELECT, INSERT, UPDATE, DELETE ON Productor TO luna1, luna2, luna3;       
COMMIT;
-- Sentencias DDL con commit implícito
