-- Autores: Lucía Cepeda González, Adriana Rubia Alcarria
-- Descripción: Script páctica 3 - creación de tablas

DROP TABLE Empleado CASCADE CONSTRAINTS;
DROP TABLE Sucursal CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE Vino CASCADE CONSTRAINTS;
DROP TABLE Productor CASCADE CONSTRAINTS;
DROP TABLE SucursalVendeVino CASCADE CONSTRAINTS;
DROP TABLE ClienteSolicitaSuministro CASCADE CONSTRAINTS;
DROP TABLE SucursalPideSuministro CASCADE CONSTRAINTS;  


CREATE TABLE Empleado (
    cod_empleado          NUMBER(6) PRIMARY KEY,
    DNI_empleado          VARCHAR2(9) NOT NULL, -- DNI son (8 números + letra) y NIE (letra + 7 números + letra)
    nombre_empleado       VARCHAR2(50) NOT NULL,
    fecha_inicio_contrato DATE NOT NULL,
    direccion_empleado    VARCHAR2(100) NOT NULL,
    salario               NUMBER(8,2) DEFAULT 0 NOT NULL,
    cod_sucursal          NUMBER(6) NOT NULL -- Se referenciará después a Sucursal (requiere creación previa)
);



CREATE TABLE Sucursal (
    cod_sucursal     NUMBER(6) PRIMARY KEY,
    nombre_sucursal  VARCHAR2(50) NOT NULL,
    ciudad_sucursal  VARCHAR2(50) NOT NULL,
    ca_sucursal      VARCHAR2(20) NOT NULL,
    cod_director     NUMBER(6),
	UNIQUE (cod_director),
	FOREIGN KEY (cod_director) REFERENCES Empleado(cod_empleado)
);


ALTER TABLE Empleado 
    ADD CONSTRAINT fk_sucursal
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal);


CREATE TABLE Cliente (
    cod_cliente       NUMBER(6) PRIMARY KEY,
    DNI_cliente       VARCHAR2(9) NOT NULL,
    nombre_cliente    VARCHAR2(50) NOT NULL,
    direccion_cliente VARCHAR2(100) NOT NULL,
    tipo_cliente      VARCHAR2(1) NOT NULL,
    ca_cliente        VARCHAR2(20) NOT NULL,
    CHECK (tipo_cliente IN ('A', 'B', 'C'))
);



CREATE TABLE Productor (
    cod_productor       NUMBER(6) PRIMARY KEY,
    DNI_productor       VARCHAR2(9) NOT NULL,
    nombre_productor    VARCHAR2(50) NOT NULL,
    direccion_productor VARCHAR2(100) NOT NULL
);

CREATE TABLE Vino (
    cod_vino            NUMBER(6) PRIMARY KEY,
    marca               VARCHAR2(50) NOT NULL,
    anio_cosecha        NUMBER(4) NOT NULL,
    origen              VARCHAR2(100), -- Si la tiene -> puede ser NULL
    graduacion          NUMBER(4,2) NOT NULL,
    procedencia         VARCHAR2(50) NOT NULL,
    cantidad_producida  NUMBER(6) DEFAULT 0 NOT NULL,
    cod_productor       NUMBER(6) NOT NULL,
    cantidad_stock      NUMBER(6) DEFAULT 0 NOT NULL,
    ca_vino             VARCHAR2(20) NOT NULL,
    CHECK (cantidad_stock BETWEEN 0 AND cantidad_producida),
    FOREIGN KEY (cod_productor) REFERENCES Productor(cod_productor)
);

-- Tablas de relaciones

CREATE TABLE SucursalVendeVino (
    cod_sucursal NUMBER(6) NOT NULL,
    cod_vino     NUMBER(6) NOT NULL,
    PRIMARY KEY (cod_sucursal, cod_vino),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal),
    FOREIGN KEY (cod_vino) REFERENCES Vino(cod_vino)
);

CREATE TABLE ClienteSolicitaSuministro (
    cod_cliente         NUMBER(6) NOT NULL,
    cod_sucursal        NUMBER(6) NOT NULL,
    cod_vino            NUMBER(6) NOT NULL,
    fecha_suministro    DATE NOT NULL,
    cantidad_suministro NUMBER(6) DEFAULT 0 NOT NULL,
    PRIMARY KEY (cod_sucursal, cod_vino, cod_cliente, fecha_suministro),
    FOREIGN KEY (cod_sucursal, cod_vino)
        REFERENCES SucursalVendeVino(cod_sucursal,cod_vino),
    FOREIGN KEY (cod_cliente)
        REFERENCES Cliente(cod_cliente)
);



CREATE TABLE SucursalPideSuministro (
    cod_sucursal_solicita NUMBER(6) NOT NULL,
    cod_sucursal_provee   NUMBER(6) NOT NULL,
    cod_vino              NUMBER(6) NOT NULL,
    fecha_pedido          DATE NOT NULL,
    cantidad_pedido       NUMBER(6) DEFAULT 0 NOT NULL,
    PRIMARY KEY (cod_sucursal_solicita, cod_vino, cod_sucursal_provee, fecha_pedido),
    FOREIGN KEY (cod_sucursal_provee, cod_vino)
        REFERENCES SucursalVendeVino(cod_sucursal, cod_vino),
    FOREIGN KEY (cod_sucursal_provee)
        REFERENCES Sucursal(cod_sucursal)
);

COMMIT;

-- Autores: Lucía Cepeda González, Adriana Rubia Alcarria
-- Descripción: Script páctica 3 - creación de tablas

-- En Luna1 se almacenarán los fragmentos correspondientes a la delegación de Madrid (localidad 1) 
-- que son los fragmentos F1, F2, F3, F4 y F5.
-- suministra vinos a clientes de 'Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja'


-- DROPS 

DROP TABLE Empleado1 CASCADE CONSTRAINTS;
DROP TABLE Sucursal1 CASCADE CONSTRAINTS;
DROP TABLE Cliente1 CASCADE CONSTRAINTS;
DROP TABLE Vino1 CASCADE CONSTRAINTS;
DROP TABLE Productor CASCADE CONSTRAINTS;
DROP TABLE SucursalVendeVino1 CASCADE CONSTRAINTS;
DROP TABLE ClienteSolicitaSuministro1 CASCADE CONSTRAINTS;
DROP TABLE SucursalPideSuministro CASCADE CONSTRAINTS;  


-- TABLAS

CREATE TABLE Empleado1 (
    cod_empleado          NUMBER(6) PRIMARY KEY, --TRPK hecho
    DNI_empleado          VARCHAR2(9) NOT NULL, -- DNI son (8 números + letra) y NIE (letra + 7 números + letra)
    nombre_empleado       VARCHAR2(50) NOT NULL,
    fecha_inicio_contrato DATE NOT NULL,
    direccion_empleado    VARCHAR2(100),
    salario               NUMBER(8,2) DEFAULT 0 NOT NULL,
    cod_sucursal          NUMBER(6) NOT NULL -- Se referenciará después a Sucursal (TRFK)
--TRFK cod_sucursal hecho (7)
);

CREATE TABLE Sucursal1 (
    cod_sucursal     NUMBER(6) PRIMARY KEY, --TRPK hecho
    nombre_sucursal  VARCHAR2(50) NOT NULL,
    ciudad_sucursal  VARCHAR2(50) NOT NULL,
    ca_sucursal      VARCHAR2(20) NOT NULL,
    cod_director     NUMBER(6),
	UNIQUE (cod_director) --TR Unico (globalmente) hecho -NO FUNCIONAN PROCEDIMIENTOS (6) CON ESTE TRIGGER HABILITADO!
	--FOREIGN KEY (cod_director) REFERENCES Empleado1(cod_empleado) 
  --deberia referenciar cualquier empleado de la compañia. comprobarlo en trigger

--TRFK cod_director hecho
);


--ALTER TABLE Empleado1 
    --ADD CONSTRAINT fk_sucursal
    --FOREIGN KEY (cod_sucursal) REFERENCES Sucursal1(cod_sucursal); -- ya tenemos trigger para esto
  --debe poder ser cualquier sucursal de la compañia. comprobarlo en trigger

CREATE TABLE Cliente1 (
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

CREATE TABLE Vino1 (
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
   -- FOREIGN KEY (cod_productor) REFERENCES Productor(cod_productor)
   --TRFK cod_productor hecho (13)
);

-- Tablas de relaciones

CREATE TABLE SucursalVendeVino1 (
    cod_sucursal NUMBER(6) NOT NULL,
    cod_vino     NUMBER(6) NOT NULL,
    PRIMARY KEY (cod_sucursal, cod_vino) --TRPK hecho
    --FOREIGN KEY (cod_sucursal) REFERENCES Sucursal1(cod_sucursal),
    --FOREIGN KEY (cod_vino) REFERENCES Vino1(cod_vino)
    --comprobar en trigger

--TRFK codsucursal hecho 
--TRFK codvino hecho
);

CREATE TABLE ClienteSolicitaSuministro1 (
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
    PRIMARY KEY (cod_sucursal_solicita, cod_vino, cod_sucursal_provee, fecha_pedido)
    --FOREIGN KEY (cod_sucursal_provee, cod_vino)
        --REFERENCES SucursalVendeVino1(cod_sucursal, cod_vino),
    --FOREIGN KEY (cod_sucursal_provee)
        --REFERENCES Sucursal1(cod_sucursal) --no se puede poner aqui con las tablas de Luna1 ya q deben ser globales
--TRFK (cod_sucursal_provee, cod_vino)  hecho!
--TRFK cod_sucursal_provee hecho

--TRFK cod_vino hecho (12)
);

COMMIT;

-- GRANTS
-- Para conectar las cuatro “localidades” y poder acceder desde cualquiera de ellas a los datos almacenados en las demás localidades
-- debemos conceder permisos desde cada cuenta 

GRANT SELECT, INSERT, UPDATE, DELETE ON Empleado1 TO luna2, luna3, luna4;
COMMIT;

GRANT SELECT, INSERT, UPDATE, DELETE ON Sucursal1 TO luna2, luna3, luna4;
COMMIT;

GRANT SELECT, INSERT, UPDATE, DELETE ON Cliente1 TO luna2, luna3, luna4;
COMMIT;

GRANT SELECT, INSERT, UPDATE, DELETE ON Vino1 TO luna2, luna3, luna4;
COMMIT;

GRANT SELECT, INSERT, UPDATE, DELETE ON SucursalVendeVino1 TO luna2, luna3, luna4;
COMMIT;

GRANT SELECT, INSERT, UPDATE, DELETE ON ClienteSolicitaSuministro1 TO luna2, luna3, luna4;
COMMIT;

GRANT SELECT, INSERT, UPDATE, DELETE ON SucursalPideSuministro TO luna2, luna3, luna4;
COMMIT;

GRANT SELECT, INSERT, UPDATE, DELETE ON Productor TO luna2, luna3, luna4;       
COMMIT;



-- Insercciones de productores en todas las localidades

INSERT INTO Productor (cod_productor, DNI_productor, nombre_productor, direccion_productor)
VALUES (1, '35353535A', 'Justiniano Briñón', 'Ramón y Cajal 9, Valladolid');

INSERT INTO Productor (cod_productor, DNI_productor, nombre_productor, direccion_productor)
VALUES (2, '36363636B', 'Marcelino Peña', 'San Francisco 7, Pamplona');

INSERT INTO Productor (cod_productor, DNI_productor, nombre_productor, direccion_productor)
VALUES (3, '37373737C', 'Paloma Riquelme', 'Antonio Gaudí 23, Barcelona');

INSERT INTO Productor (cod_productor, DNI_productor, nombre_productor, direccion_productor)
VALUES (4, '38383838D', 'Amador Laguna', 'Juan Ramón Jiménez 17, Córdoba');

INSERT INTO Productor (cod_productor, DNI_productor, nombre_productor, direccion_productor)
VALUES (5, '39393939E', 'Ramón Esteban', 'Gran Vía de Colón 121, Madrid');

INSERT INTO Productor (cod_productor, DNI_productor, nombre_productor, direccion_productor)
VALUES (6, '40404040F', 'Carlota Fuentes', 'Cruz de los Ángeles 29, Oviedo');


-- Inserciones localidad 1 (MADRID: Castilla-León, Castilla-La Mancha, Aragón, Madrid y La Rioja)

INSERT INTO Sucursal (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal)
VALUES (4, 'Almudena', 'Madrid', 'Madrid');

INSERT INTO Sucursal (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal)
VALUES (5, 'El Cid', 'Burgos', 'Castilla-León');

INSERT INTO Sucursal (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal)
VALUES (6, 'Puente la Reina', 'Logroño', 'La Rioja');


INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (7, '77777777G', 'Agustín', 'Pablo Neruda 84, Madrid', TO_DATE('5-05-2025', 'DD-MM-YYYY'), 2000, 4);

INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (8, '88888888H', 'Eduardo', 'Alcalá 8, Madrid', TO_DATE('6-06-2025', 'DD-MM-YYYY'), 1800, 4);

-- Burgos está en Castilla-León
INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (9, '99999999I', 'Alberto', 'Las Huelgas 15, Burgos', TO_DATE('5-09-2020', 'DD-MM-YYYY'), 2000, 5);

INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (10, '10101010J', 'Soraya', 'Jimena 2, Burgos', TO_DATE('4-10-2017', 'DD-MM-YYYY'), 1800, 5);

-- Logroño está en La Rioja
INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (11, '01010101K', 'Manuel', 'Estrella 26, Logroño', TO_DATE('6-07-2016', 'DD-MM-YYYY'), 2000, 6);

INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (12, '12121212L', 'Emilio', 'Constitución 3, Logroño', TO_DATE('5-11-2018', 'DD-MM-YYYY'), 1800, 6);

UPDATE Sucursal SET cod_director = 7 WHERE cod_sucursal = 4;
UPDATE Sucursal SET cod_director = 9 WHERE cod_sucursal = 5;
UPDATE Sucursal SET cod_director = 11 WHERE cod_sucursal = 6;


INSERT INTO Cliente (cod_cliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, ca_cliente)
VALUES(7, '32323232G', 'Restaurante Cándido', 'Acueducto 1, Segovia', 'C', 'Castilla-León');

INSERT INTO Cliente (cod_cliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, ca_cliente)
VALUES(8, '34343434H', 'Restaurante Las Vidrieras', 'Cervantes 16, Almagro', 'C', 'Castilla-La Mancha');


-- Inicialmente, la cantidad en stock es la cantidad producida.
INSERT INTO Vino (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (1, 'Vega Sicilia', 2008, 'Ribera del Duero', 12.5, 'Castillo Blanco', 200, 200, 'Castilla-León', 1);

INSERT INTO Vino (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (2, 'Vega Sicilia', 2015, 'Ribera del Duero', 12.5, 'Castillo Blanco', 100, 100, 'Castilla-León', 1);

INSERT INTO Vino (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (3, 'Marqués de Cáceres', 2025, 'Rioja', 11, 'Santo Domingo', 200, 200, 'Castilla-León', 2);

INSERT INTO Vino (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (4, 'Marqués de Cáceres', 2022, 'Rioja', 11.5, 'Santo Domingo', 250, 250, 'La Rioja', 2);

INSERT INTO Vino (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (17, 'Estela', 2022, 'Cariñena', 10.5, 'San Millán', 200, 200, 'Aragón', 3);

INSERT INTO Vino (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (14, 'Tablas de Daimiel', 2018, 'Valdepeñas', 11.5, 'Laguna Azul', 300, 300, 'Castilla-La Mancha',  5);

/* ESTO LO HE PENSADO YO A PARTIR DE LO QUE YA TENEMOS
INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)
VALUES (5, 1);(cod_sucursal, cod_vino)
        REFERENCES SucursalVendeVino(cod_sucursal,cod_vino),

INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)
VALUES (5, 2);

INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)
VALUES (5, 3);

INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)
VALUES (6, 4);
*/

-- Datos tabla pedidos a otras sucursales (aparecen sucursales que venden esos vinos)
INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)
VALUES (4, 4);

INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)
VALUES (5, 2);

INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)
VALUES (6, 14);

INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)
VALUES (4, 3);

INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)
VALUES (4, 17);


INSERT INTO ClienteSolicitaSuministro (cod_cliente, cod_sucursal, cod_vino, cantidad_suministro, fecha_suministro)
VALUES (7, 4, 1, 80, TO_DATE('15-02-2025', 'DD-MM-YYYY'));

INSERT INTO ClienteSolicitaSuministro (cod_cliente, cod_sucursal, cod_vino, cantidad_suministro, fecha_suministro)
VALUES (7, 5, 7, 50, TO_DATE('17-04-2025', 'DD-MM-YYYY'));

INSERT INTO ClienteSolicitaSuministro (cod_cliente, cod_sucursal, cod_vino, cantidad_suministro, fecha_suministro)
VALUES (7, 4, 10, 70, TO_DATE('21-06-2025', 'DD-MM-YYYY'));

INSERT INTO ClienteSolicitaSuministro (cod_cliente, cod_sucursal, cod_vino, cantidad_suministro, fecha_suministro)
VALUES (7, 5, 12, 40, TO_DATE('23-07-2025', 'DD-MM-YYYY'));

INSERT INTO ClienteSolicitaSuministro (cod_cliente, cod_sucursal, cod_vino, cantidad_suministro, fecha_suministro)
VALUES (8, 6, 14, 50, TO_DATE('11-01-2025', 'DD-MM-YYYY'));

INSERT INTO ClienteSolicitaSuministro (cod_cliente, cod_sucursal, cod_vino, cantidad_suministro, fecha_suministro)
VALUES (8, 6, 4, 60, TO_DATE('14-03-2025', 'DD-MM-YYYY'));

INSERT INTO ClienteSolicitaSuministro (cod_cliente, cod_sucursal, cod_vino, cantidad_suministro, fecha_suministro)
VALUES (8, 4, 6, 70, TO_DATE('21-05-2025', 'DD-MM-YYYY'));


-- Inserciones localidad 2 (BARCELONA: Cataluña, Baleares, País Valenciano y Murcia)
/*
INSERT INTO Sucursal (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal, cod_director)

INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)

INSERT INTO Cliente (DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, ca_cliente)


INSERT INTO Vino (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)

INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)

INSERT INTO ClienteSolicitaSuministro (cod_vino, cod_sucursal, cod_cliente, fecha_suministro, cantidad_suministro)



-- Inserciones localidad 3 (La Coruña: Galicia, Asturias, Cantabria, País Vasco y Navarra)

INSERT INTO Sucursal (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal, cod_director)

INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)

INSERT INTO Cliente (DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, ca_cliente)


INSERT INTO Vino (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)

INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)

INSERT INTO ClienteSolicitaSuministro (cod_vino, cod_sucursal, cod_cliente, fecha_suministro, cantidad_suministro)



-- Inserciones localidad 4 (GRANADA: Andalucía, Extremadura, Canarias Ceuta y Melilla)

INSERT INTO Sucursal (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal, cod_director)

INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)

INSERT INTO Cliente (DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, ca_cliente)


INSERT INTO Vino (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)

INSERT INTO SucursalVendeVino (cod_sucursal, cod_vino)

INSERT INTO ClienteSolicitaSuministro (cod_vino, cod_sucursal, cod_cliente, fecha_suministro, cantidad_suministro)

*/
INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (4, 5, 4, TO_DATE('13-06-2025', 'DD-MM-YYYY'), 40);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (4, 5, 4, TO_DATE('14-06-2025', 'DD-MM-YYYY'), 50);
DELETE FROM SucursalPideSuministro WHERE cod_sucursal_solicita = 4 AND cod_sucursal_provee = 5 AND cod_vino = 4 AND fecha_pedido = TO_DATE('13-06-2025', 'DD-MM-YYYY');

select * from SucursalPideSuministro;
select * from ClienteSolicitaSuministro;
INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (1, 10, 7, TO_DATE('05-05-2025', 'DD-MM-YYYY'), 50);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (2, 7, 5, TO_DATE('12-07-2025', 'DD-MM-YYYY'), 150);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (2, 5, 2, TO_DATE('04-04-2025', 'DD-MM-YYYY'), 20);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (2, 8, 6, TO_DATE('16-09-2025', 'DD-MM-YYYY'), 40);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (3, 6, 14, TO_DATE('15-07-2025', 'DD-MM-YYYY'), 200);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (3, 9, 16, TO_DATE('21-09-2025', 'DD-MM-YYYY'), 100);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (4, 1, 10, TO_DATE('22-06-2025', 'DD-MM-YYYY'), 70);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (4, 7, 6, TO_DATE('22-05-2025', 'DD-MM-YYYY'), 70);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (5, 10, 7, TO_DATE('18-04-2025', 'DD-MM-YYYY'), 50);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (7, 2, 21, TO_DATE('18-09-2025', 'DD-MM-YYYY'), 200);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (8, 11, 15, TO_DATE('14-01-2025', 'DD-MM-YYYY'), 100);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (8, 2, 9, TO_DATE('20-02-2025', 'DD-MM-YYYY'), 150);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (9, 3, 18, TO_DATE('02-10-2025', 'DD-MM-YYYY'), 100);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (9, 12, 25, TO_DATE('28-06-2025', 'DD-MM-YYYY'), 160);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (10, 4, 3, TO_DATE('22-02-2025', 'DD-MM-YYYY'), 100);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (10, 8, 6, TO_DATE('02-08-2025', 'DD-MM-YYYY'), 90);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (11, 9, 13, TO_DATE('04-10-2025', 'DD-MM-YYYY'), 200);

INSERT INTO SucursalPideSuministro (cod_sucursal_solicita, cod_sucursal_provee, cod_vino, fecha_pedido, cantidad_pedido)
VALUES (12, 4, 17, TO_DATE('04-05-2025', 'DD-MM-YYYY'), 70);

COMMIT;
