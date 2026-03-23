

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
    direccion_empleado    VARCHAR2(100) NOT NULL,
    fecha_inicio_contrato DATE NOT NULL,
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
    cantidad_stock      NUMBER(6) DEFAULT 0 NOT NULL,
    ca_vino             VARCHAR2(20) NOT NULL,
    cod_productor       NUMBER(6) NOT NULL,
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
    cod_vino            NUMBER(6) NOT NULL,
    cod_sucursal        NUMBER(6) NOT NULL,
    cod_cliente         NUMBER(6) NOT NULL,
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
    cod_vino              NUMBER(6) NOT NULL,
    cod_sucursal_provee   NUMBER(6) NOT NULL,
    fecha_pedido          DATE NOT NULL,
    cantidad_pedido       NUMBER(6) DEFAULT 0 NOT NULL,
    PRIMARY KEY (cod_sucursal_solicita, cod_vino, cod_sucursal_provee, fecha_pedido),
    FOREIGN KEY (cod_sucursal_solicita, cod_vino)
        REFERENCES SucursalVendeVino(cod_sucursal, cod_vino),
    FOREIGN KEY (cod_sucursal_provee)
        REFERENCES Sucursal(cod_sucursal)
);

COMMIT; 

-- Eliminar trigger
DROP TRIGGER TRTipoCliente;



INSERT INTO Cliente1 (cod_cliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, ca_cliente)
VALUES(4, '32323232G', 'Restaurante Cándido', 'Acueducto 1, Segovia', 'G', 'Castilla-León');

INSERT INTO Cliente (cod_cliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, ca_cliente)
VALUES(8, '34343434H', 'Restaurante Las Vidrieras', 'Cervantes 16, Almagro', 'C', 'Castilla-La Mancha');

UPDATE Cliente SET TIPO_CLIENTE = 'C' WHERE COD_CLIENTE IN (7,8);
UPDATE Cliente SET TIPO_CLIENTE = 'D' WHERE COD_CLIENTE IN (7);
Select * from Cliente;



INSERT INTO Productor (cod_productor, DNI_productor, nombre_productor, direccion_productor)
VALUES (1, 'P12345678', 'Bodegas Torres', 'Calle Falsa 123, Barcelona');

INSERT INTO Vino1 (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (1, 'Vega Sicilia', 2008, 'Ribera del Duero', 12.5, 'Castillo Blanco', 200, 200, 'Castilla-León', 1);

INSERT INTO Vino1 (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (1, 'Vega Sicilia', 2007, 'Ribera del Duero', 12.5, 'Castillo Blanco', 200, 200, 'Castilla-León', 1);


/*********************************************************************************************/


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

INSERT INTO Sucursal1 (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal)
VALUES (4, 'Almudena', 'Madrid', 'Madrid');

INSERT INTO Sucursal1 (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal, cod_director)
VALUES (8, 'El Cid', 'Burgos', 'Castilla-León', 3);

INSERT INTO Sucursal1 (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal, cod_director)
VALUES (6, 'Puente la Reina', 'Logroño', 'La Rioja', 11);

select * from Empleado;
select * from Sucursal;
INSERT INTO Empleado1 (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (8, '77777777G', 'Agustín', 'Pablo Neruda 84, Madrid', TO_DATE('5-05-2025', 'DD-MM-YYYY'), 2000, 4);

INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (8, '88888888H', 'Eduardo', 'Alcalá 8, Madrid', TO_DATE('6-06-2025', 'DD-MM-YYYY'), 1800, 4);

-- Burgos está en Castilla-León
INSERT INTO Empleado1 (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
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


/****************************************************************************************/

-- --------------------------------------
--COMPROBACIONES DE TRIGGERS DE PK y FK
-- --------------------------------------


INSERT INTO luna1.Sucursal1 (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal)
VALUES (5, 'Almudena', 'Madrid', 'Madrid');
INSERT INTO luna4.SUCURSAL4 (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal)
VALUES (44, 'Granada', 'Granada', 'Andalucía');
COMMIT;
INSERT INTO luna1.Sucursal1 (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal, cod_director)
VALUES (8, 'El Cid', 'Burgos', 'Castilla-León', 8);

INSERT INTO luna1.Sucursal1 (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal, cod_director)
VALUES (6, 'Puente la Reina', 'Logroño', 'La Rioja', 11);
DELETE FROM luna1.Sucursal1 where cod_director=11;
commit;
--comprobado TRSucursalFKEmpleado FUNCIONA BIEN
--triggers solo en luna1
--insertamos sucursales 4 en luna1 y 5 en luna4
--si (desde cualquier conexion) intentamos insertar sucursal con cod 5 en luna1, se activa el trigger

select * from Sucursal; --5, 8, 6 (mad) , 44 (gra)
select * from luna1.Sucursal1;
select * from luna4.SUCURSAL4;


select * from Empleado; --8 (Madrid), 9(gra)
SELECT * FROM luna1.Empleado1; 
SELECT * FROM luna4.Empleado4;


INSERT INTO luna1.Empleado1 (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (8, '88888888G', 'Agus', 'Pablo, Madrid', TO_DATE('6-05-2025', 'DD-MM-YYYY'), 2000, 5);
COMMIT;
INSERT INTO luna4.Empleado4 (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (9, '99999999H', 'Eduardo', 'Alcalá 8, Granada', TO_DATE('6-06-2025', 'DD-MM-YYYY'), 1800, 5);
--comprobado TRPKEmpleado, TRPKSucursal y TREmpleadoUnaSucursal FUNCIONAN BIEN
DELETE FROM luna1.Empleado1;
--TREmpleadoFKSucursal funciona bien
INSERT INTO luna1.Empleado1 (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (55, '88555588G', 'Agusy', 'Pably, Madrid', TO_DATE('6-05-2025', 'DD-MM-YYYY'), 2000, 80);
COMMIT;

-- comprobar TRPKCliente

select * from Cliente; -- 15(mad), 14(gra))
select * from luna1.Cliente1;
select * from luna4.Cliente4;


INSERT INTO luna4.Cliente4 (cod_cliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, ca_cliente)
VALUES(14, '46464646J', 'Restaurante El Olivo', 'Plaza España 5, Granada', 'B', 'Andalucía');
COMMIT;
INSERT INTO luna1.Cliente1 (cod_cliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, ca_cliente)
VALUES(15, '45454545I', 'Restaurante El Laurel', 'Calle Mayor 10, Segovia', 'A', 'Castilla-León');
COMMIT;
--comprobado TRPKCliente FUNCIONA BIEN
--INSERT INTO luna1.Cliente1 (cod_cliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, ca_cliente)
--VALUES(16, '45454545I', 'Restaurante El ', 'Calle, Segovia', 'D', 'Castilla-León');
--TRTipoCliente funciona bien

--comprobar TRPKProductor

select * from luna1.Productor; --7, 8
--select * from luna1.Productor;
--select * from luna4.Productor;
DELETE FROM luna4.Productor;
INSERT INTO luna1.Productor (cod_productor, DNI_productor, nombre_productor, direccion_productor)
VALUES (7, '41414141G', 'Lucía Márquez', 'Calle Luna 12, Sevilla');
COMMIT;
INSERT INTO luna1.Productor (cod_productor, DNI_productor, nombre_productor, direccion_productor)
VALUES (8, '42424242H', 'Diego Torres', 'Avenida Sol 8, Valladolid');
COMMIT;
--comprobado TRPKProductor FUNCIONA BIEN

-- Comprobar TRPKVino

select * from Vino; --21 (mad), 20 (gra)
select * from luna1.Vino1;
select * from luna4.Vino4;
INSERT INTO luna4.Vino4 (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (20, 'Carmenere', 2023, 'Andes', 13.5, 'Valle Central', 150, 150, 'Andalucía', 7);
COMMIT;
INSERT INTO luna1.Vino1 (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (21, 'Alb', 2022, 'Rí', 11.5, 'Va', 180, 180, 'Madrid', 7);
COMMIT;
DELETE FROM luna1.Vino1;
--comprobado TRPKVino FUNCIONA BIEN

-- Comprobar TRPKSucursalVendeVino y TRSucursalVendeVinoFKVino y TRSucursalVendeVinoFKSucursal
select * from SucursalVendeVino; -- 5-21(mad), 44-20(gra)
select * from luna1.SucursalVendeVino1;
select * from luna4.SucursalVendeVino4;
INSERT INTO luna4.SucursalVendeVino4 (cod_sucursal, cod_vino)
VALUES (44, 20);
COMMIT;
INSERT INTO luna1.SucursalVendeVino1 (cod_sucursal, cod_vino)
VALUES (5, 21);
COMMIT;
select * from vino;
DELETE FROM luna4.SucursalVendeVino4;
-- comprobados TRPKSucursalVendeVino Y TRSucursalVendeVinoFKVino Y TRSucursalVendeVinoFKSucursal FUNCIONAN BIEN
--no se comprueba que el vino y la sucursal sean de la misma CA!!!!!!!!!!! comprobar esto?


--comprobar TRPKClienteSolicitaSuministro

select * from ClienteSolicitaSuministro;
select * from luna1.ClienteSolicitaSuministro1;
select * from luna4.ClienteSolicitaSuministro4;
INSERT INTO luna4.ClienteSolicitaSuministro4 (cod_cliente, cod_sucursal, cod_vino, fecha_suministro, cantidad_suministro)
VALUES (15, 5, 21, TO_DATE('10-10-2025', 'DD-MM-YYYY'), 30);
COMMIT;
INSERT INTO luna1.ClienteSolicitaSuministro1 (cod_cliente, cod_sucursal, cod_vino, fecha_suministro, cantidad_suministro)
VALUES (10, 4, 20, TO_DATE('12-12-2025', 'DD-MM-YYYY'), 40);
COMMIT;
select * from Sucursal; --4, 5, 44(gra)
select * from Empleado; --7, 8 (madrid), 9 (granada)
select * from Cliente; -- 9, 10(mad), 14(gra))
select * from Productor; --7
select * from Vino; --20
select * from SucursalVendeVino; -- 5-20
-- TRClienteSolicitaSuministroDelegacionCorrecta funciona bien
-- TRPKClienteSolicitaSuministro funciona bien
-- FKs solo enseña el mensaje el FK vino
--falta FK sucursal y FK cliente MENSAJE DE ERROR!!
--arreglado en TRiggers

--comprobar TRSucursalPideSuministroFKSucursalVendeVino
select * from luna1.SucursalPideSuministro;

INSERT INTO luna1.SucursalPideSuministro
(cod_sucursal_solicita, cod_vino, cod_sucursal_provee, fecha_pedido, cantidad_pedido)
VALUES (44, 44, 5, TO_DATE('15-11-2025', 'DD-MM-YYYY'), 10);
COMMIT;
INSERT INTO luna1.SucursalPideSuministro
(cod_sucursal_solicita, cod_vino, cod_sucursal_provee, fecha_pedido, cantidad_pedido)
VALUES (4, 20, 6, TO_DATE('18-09-2025', 'DD-MM-YYYY'), 70);
COMMIT;
--añadir antes a cliente solicita suministro (por requisitos p3)
INSERT INTO luna1.ClienteSolicitaSuministro1 
(cod_cliente, cod_sucursal, cod_vino, fecha_suministro, cantidad_suministro)
VALUES (14, 44, 21, TO_DATE('10-10-2025', 'DD-MM-YYYY'), 30);
COMMIT;
------------
select * from Sucursal; --5, 8, 6 (mad) , 44 (gra)
select * from Empleado; --8 (Madrid), 9(gra)
select * from Cliente; -- 15(mad), 14(gra))
select * from luna1.Productor; --7, 8
select * from Vino; --21 (mad), 20 (gra)
select * from SucursalVendeVino; -- 5-21(mad), 44-20(gra)
--FK sucursalvendevino FUNCIONA BIEN
--TRSucursalPideVinoASucursalCorrecta funciona bien
--TRCantidadPedidoNoExcedeSuministrado FUNCIONA BIEN ambas partes


--comprobar TRSalarioNoDisminuye 
select * from empleado;

UPDATE luna1.Empleado1 SET salario = -2030 WHERE cod_empleado = 8;
INSERT INTO luna1.Empleado1 (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (8, '88888888G', 'Agus', 'Pablo, Madrid', TO_DATE('6-05-2025', 'DD-MM-YYYY'), -30, 5);
COMMIT;

--funciona bien trsalario no disminuye
select * from luna1.SucursalPideSuministro; --44 pide a 5 vino 21
select * from luna1.ClienteSolicitaSuministro1; --cli14 pide a suc44 vino21
--10-10-2025
INSERT INTO luna1.ClienteSolicitaSuministro1 
(cod_cliente, cod_sucursal, cod_vino, fecha_suministro, cantidad_suministro)
VALUES (14, 44, 21, TO_DATE('10-10-2025', 'DD-MM-YYYY'), 30);
COMMIT;
INSERT INTO luna1.ClienteSolicitaSuministro1 
(cod_cliente, cod_sucursal, cod_vino, fecha_suministro, cantidad_suministro)
VALUES (14, 44, 21, TO_DATE('10-11-2025', 'DD-MM-YYYY'), 30);
COMMIT;
--como hacer que acepte fechas iguales? dos pedidos el mismo dia -> deberian sumarse las cantidades?
--mirar comentarios TRFechaSuministroClientePosterior

select * from luna1.Productor; --7, 8
UPDATE luna1.vino1 set cod_productor = 80 where cod_vino =21;
COMMIT;
UPDATE luna1.vino1 set cantidad_stock = 200 where cod_vino =21;

--funciona TRStockVinoValido y TRVinoFKProductor
select * from vino;
select * from clientesolicitasuministro;
delete from luna1.vino1 where cod_vino = 21;
--funciona TREliminarVinoSuministrado
INSERT INTO luna1.clientesolicitasuministro1 
(cod_cliente, cod_sucursal, cod_vino, fecha_suministro, cantidad_suministro)
VALUES (15, 5, 21, TO_DATE('10-01-2025', 'DD-MM-YYYY'), 10);
COMMIT;
INSERT INTO luna1.SucursalPideSuministro
(cod_sucursal_solicita, cod_vino, cod_sucursal_provee, fecha_pedido, cantidad_pedido)
VALUES (5, 21, 8, TO_DATE('18-09-2025', 'DD-MM-YYYY'), 10);
--TRSucursalPideSuministroDelegacionCorrecta funciona

--TRSucursalPideSuministroFechaPosteriorPedido
select * from luna1.SucursalPideSuministro;
insert into luna1.SucursalPideSuministro
(cod_sucursal_solicita, cod_vino, cod_sucursal_provee, fecha_pedido, cantidad_pedido)
VALUES (44, 21, 5, TO_DATE('11-11-2025', 'DD-MM-YYYY'), 10);
COMMIT;
-- funciona TRSucursalPideSuministroFechaPosteriorSuministro y 
-- funciona TRSucursalPideSuministroFechaPosteriorPedido

select * from empleado;
delete from luna1.sucursal1 where cod_sucursal = 5;

--TRMarcaUnicaProductor
select * from vino; --marca Alb (21) prod7, marca camere(20) prod7
select * from luna1.Productor;
INSERT INTO luna1.Productor (cod_productor, DNI_productor, nombre_productor, direccion_productor)
VALUES (7, '41414141G', 'Lucía Márquez', 'Calle Luna 12, Sevilla');
COMMIT;
INSERT INTO luna1.Vino1 (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cantidad_stock, ca_vino, cod_productor)
VALUES (22, 'Alb', 2023, 'Ríy', 11.5, 'Vay', 180, 180, 'Madrid', 8);
COMMIT;

delete from luna1.productor where cod_productor =7;



--probar el procedimiento InsertarOActualizarSuministro
select * from cliente;
select * from sucursal; 
select * from vino;
EXEC InsertarOActualizarSuministro(15, 2, 21, TO_DATE('10-01-2025', 'DD-MM-YYYY'), 1);
EXEC InsertarOActualizarSuministro(5, 21, 5, TO_DATE('20-12-2025', 'DD-MM-YYYY'), 30);
select * from luna1.ClienteSolicitaSuministro1;
select * from ClienteSolicitaSuministro;
EXEC EliminarSuministro(2, 5, 21, TO_DATE('10-01-2025', 'DD-MM-YYYY'));

commit;
-- probar InsertarPedido( cod_suc_solicita NUMBER, --SucursalPideSuministro
--                                         cod_suc_provee NUMBER,                                                                                                                          
--                                           cod_vino NUMBER,
--                                             fecha_pedido DATE,
--                                               cantidad_pedido NUMBER) IS
EXEC InsertarPedido(2,5,21,TO_DATE('16-12-2025', 'DD-MM-YYYY'), 1);--ha funcionado

select * from vino;
select COUNT(*)
        FROM Vino
        WHERE cod_vino = 21;
SELECT constraint_name,
       constraint_type,
       table_name,
       r_constraint_name
FROM user_constraints
WHERE table_name = 'SUCURSALVENDEVINO';
--WHERE constraint_name = 'LUNA2.SYS_C00394730';
SELECT owner,
       constraint_name,
       constraint_type,
       table_name,
       r_constraint_name
FROM all_constraints
WHERE constraint_name = 'SYS_C00394730';
COMMIT;

EXEC EliminarPedido(2,5,21,TO_DATE('15-12-2025', 'DD-MM-YYYY'));
select * from vino;
select * from luna2.SucursalPideSuministro;
commit;


-- OTRAS PRUEBAS LUCIA
INSERT INTO Sucursal1 (cod_sucursal, nombre_sucursal, ciudad_sucursal, ca_sucursal)
VALUES (5, 'Almudena', 'Madrid', 'Madrid');
DELETE FROM luna4.Sucursal4 WHERE cod_sucursal = 5;
COMMIT;
EXEC InsertarEmpleado(7, '77777777G', 'Agustín',TO_DATE('5-05-2025', 'DD-MM-YYYY') ,'Pablo Neruda 84, Madrid', 2000, 4);
EXEC InsertarEmpleado(4, '88888888H', 'Beatriz',TO_DATE('5-05-2025', 'DD-MM-YYYY') ,'Pablo Neruda 84, Madrid', 2000, 5);
DELETE FROM luna1.Empleado1 WHERE cod_empleado = 8;
COMMIT; 
UPDATE Sucursal1 SET cod_director = 7 WHERE cod_sucursal = 5;
EXEC EliminarEmpleado(7);
EXEC EliminarEmpleado(8);
EXEC InsertarSucursal(2, 'Almudena', 'Madrid', 'Madrid',6);
EXEC InsertarProductor(7, '45454545I', 'Restaurante El Laurel', 'Calle Mayor 10, Segovia');
EXEC EliminarProductor(8);
exec EliminarProductor(9);
EXEC InsertarVino(25, 'Alba', 2022, 'Rí', 11.5, 'Va', 'Madrid', 180, 9);
EXEC EliminarVino(22);
exec InsertarCliente(1, '45454545I', 'Restaurante El Laurel', 'Calle Mayor 10, Segovia', 'A', 'Aragón');
exec InsertarPedido(5,25,2,TO_DATE('15-11-2025', 'DD-MM-YYYY'),50);
EXEC ModificarDirectorSucursal(44,4);
select * from sucursal, empleado;
select * from luna1.empleado1;
select * from luna3.empleado3;
select * from luna4.empleado4;
delete from luna4.Empleado4 where cod_empleado = 9;
select  * from luna2.empleado2;
select * from sucursal;
delete from sucursal1 where cod_sucursal = 44;
select * from empleado;
select * from vino;
select * from sucursalvendevino s join sucursal suc on s.cod_sucursal = suc.cod_sucursal;
select * from sucursalvendevino;
select * from cliente;
select * from clientesolicitasuministro;
select * from sucursalpidesuministro;
select * from productor;


select * from  Sucursal S JOIN Empleado E ON S.cod_sucursal = E.cod_sucursal;


update luna1.sucursal1 set cod_director = 8 where cod_sucursal = 4;
EXEC TrasladarEmpleado(8,44,'Calle Lucia');
COMMIT;
INSERT INTO Empleado (cod_empleado, DNI_empleado, nombre_empleado, direccion_empleado, fecha_inicio_contrato, salario, cod_sucursal)
VALUES (7, '77777777G', 'Agustín', 'Pablo Neruda 84, Madrid', TO_DATE('5-05-2025', 'DD-MM-YYYY'), 2000, 4);
COMMIT;

-- modificar salario
EXEC ModificarSalarioEmpleado(8, 2000);
