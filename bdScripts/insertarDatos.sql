-- Autores: Lucía Cepeda González, Adriana Rubia Alcarria
-- Descripción: Script para la insercción de datos

--delete all data from tables EN ORDEN PARA EVITAR CONFLICTOS DE FK
DELETE FROM luna1.SucursalPideSuministro;
DELETE FROM luna1.ClienteSolicitaSuministro1;
DELETE FROM luna1.SucursalVendeVino1;
DELETE FROM luna1.Vino1;
DELETE FROM luna1.Productor;
DELETE FROM luna1.Empleado1;
DELETE FROM luna1.Sucursal1;
DELETE FROM luna1.Cliente1;


DELETE FROM luna2.SucursalPideSuministro;
DELETE FROM luna2.ClienteSolicitaSuministro2;
DELETE FROM luna2.SucursalVendeVino2;
DELETE FROM luna2.Vino2;
DELETE FROM luna2.Productor;
DELETE FROM luna2.Empleado2;
DELETE FROM luna2.Sucursal2;
DELETE FROM luna2.Cliente2;


DELETE FROM luna3.SucursalPideSuministro;
DELETE FROM luna3.ClienteSolicitaSuministro3;
DELETE FROM luna3.SucursalVendeVino3;
DELETE FROM luna3.Vino3;
DELETE FROM luna3.Productor;
DELETE FROM luna3.Empleado3;
DELETE FROM luna3.Sucursal3;
DELETE FROM luna3.Cliente3;

DELETE FROM luna4.SucursalPideSuministro;
DELETE FROM luna4.ClienteSolicitaSuministro4;
DELETE FROM luna4.SucursalVendeVino4;
DELETE FROM luna4.Vino4;
DELETE FROM luna4.Productor;
DELETE FROM luna4.Empleado4;
DELETE FROM luna4.Sucursal4;
DELETE FROM luna4.Cliente4;

SELECT * FROM Cliente;
SELECT * FROM Sucursal;
SELECT * FROM Empleado;
SELECT * FROM Vino;
SELECT * FROM SucursalVendeVino;    
SELECT * FROM ClienteSolicitaSuministro;

SELECT * FROM LUNA1.Productor;
SELECT * FROM LUNA2.Productor;
SELECT * FROM LUNA3.Productor;
SELECT * FROM LUNA4.Productor;

SELECT * FROM SucursalPideSuministro;

-- Insert data scripts

--copia:


--- Inserciones en todas las localidades.

--productores 
EXEC InsertarProductor(1, '35353535A', 'Justiniano Briñón', 'Ramón y Cajal 9, Valladolid');
--INSERT INTO Productor(codProductor, DNI_productor, nombre_productor, direccion_productor)
--VALUES (1, '35353535A', 'Justiniano Briñón', 'Ramón y Cajal 9, Valladolid');
EXEC InsertarProductor(2, '36363636B', 'Marcelino Peña', 'San Francisco 7, Pamplona');
--INSERT INTO Productor(codProductor, DNI_productor, nombre_productor, direccion_productor)
--VALUES (2, '36363636B', 'Marcelino Peña', 'San Francisco 7, Pamplona');
EXEC InsertarProductor(3, '37373737C', 'Paloma Riquelme', 'Antonio Gaudí 23, Barcelona');
--INSERT INTO Productor(codProductor, DNI_productor, nombre_productor, direccion_productor)
--VALUES (3, '37373737C', 'Paloma Riquelme', 'Antonio Gaudí 23, Barcelona');
EXEC InsertarProductor(4, '38383838D', 'Amador Laguna', 'Juan Ramón Jiménez 17, Córdoba');
--INSERT INTO Productor(codProductor, DNI_productor, nombre_productor, direccion_productor)
--VALUES (4, '38383838D', 'Amador Laguna', 'Juan Ramón Jiménez 17, Córdoba');
EXEC InsertarProductor(5, '39393939E', 'Ramón Esteban', 'Gran Vía de Colón 121, Madrid');
--INSERT INTO Productor(codProductor, DNI_productor, nombre_productor, direccion_productor)
--VALUES (5, '39393939E', 'Ramón Esteban', 'Gran Vía de Colón 121, Madrid');
EXEC InsertarProductor(6, '40404040F', 'Carlota Fuentes', 'Cruz de los Ángeles 29, Oviedo');    
--INSERT INTO Productor(codProductor, DNI_productor, nombre_productor, direccion_productor)
--VALUES (6, '40404040F', 'Carlota Fuentes', 'Cruz de los Ángeles 29, Oviedo');


------------------------------
--- Inserciones localidad 1
------------------------------

--sucursales 4, 5, 6

EXEC InsertarSucursal(4, 'Almudena', 'Madrid', 'Madrid');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (4, 'Almudena', 'Madrid', 'Madrid');
EXEC InsertarSucursal(5, 'El Cid', 'Burgos', 'Castilla-León');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (5, 'El Cid', 'Burgos', 'Castilla-León');
EXEC InsertarSucursal(6, 'Puente la Reina', 'Logroño', 'La Rioja');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (6, 'Puente la Reina', 'Logroño', 'La Rioja');


--empleados  7-12

EXEC InsertarEmpleado(7, '77777777G', 'Agustín', TO_DATE('5-05-2019', 'DD/MM/YYYY'), 'Pablo Neruda 84, Madrid', 2000, 4);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (7, '77777777G', 'Agustín', TO_DATE('5-05-2009', 'DD/MM/YYYY'), 2000, 'Pablo Neruda 84, Madrid', 4);
EXEC InsertarEmpleado(8, '88888888H', 'Eduardo', TO_DATE('6-06-2019', 'DD/MM/YYYY'), 'Alcalá 8, Madrid', 1800, 4);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (8, '88888888H', 'Eduardo', TO_DATE('6-06-2009', 'DD/MM/YYYY'), 1800, 'Alcalá 8, Madrid', 4);
EXEC InsertarEmpleado(9, '99999999I', 'Alberto', TO_DATE('5-09-2020', 'DD/MM/YYYY'), 'Las Huelgas 15, Burgos', 2000, 5);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (9, '99999999I', 'Alberto', TO_DATE('5-09-2010', 'DD/MM/YYYY'), 2000, 'Las Huelgas 15, Burgos', 5);
EXEC InsertarEmpleado(10, '10101010J', 'Soraya', TO_DATE('4-10-2017', 'DD/MM/YYYY'), 'Jimena 2, Burgos', 1800, 5);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (10, '10101010J', 'Soraya', TO_DATE('4-10-2007', 'DD/MM/YYYY'), 1800, 'Jimena 2, Burgos', 5);
EXEC InsertarEmpleado(11, '01010101K', 'Manuel', TO_DATE('6-07-2016', 'DD/MM/YYYY'), 'Estrella 26, Logroño', 2000, 6);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (11, '01010101K', 'Manuel', TO_DATE('6-07-2006', 'DD/MM/YYYY'), 2000, 'Estrella 26, Logroño', 6);
EXEC InsertarEmpleado(12, '12121212L', 'Emilio', TO_DATE('5-11-2018', 'DD/MM/YYYY'), 'Constitución 3, Logroño', 1800, 6);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (12, '12121212L', 'Emilio', TO_DATE('5-11-2008', 'DD/MM/YYYY'), 1800, 'Constitución 3, Logroño', 6);


--clientes 7, 8

EXEC InsertarCliente(7, '32323232G', 'Restaurante Cándido', 'Acueducto 1, Segovia', 'C', 'Castilla-León');
--INSERT INTO Cliente(codCliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, CA_cliente)
--VALUES(7, '32323232G', 'Restaurante Cándido', 'Acueducto 1, Segovia', 'C', 'Castilla-León');
EXEC InsertarCliente(8, '34343434H', 'Restaurante Las Vidrieras', 'Cervantes 16, Almagro', 'C', 'Castilla-La Mancha');
--INSERT INTO Cliente(codCliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, CA_cliente)
--VALUES(8, '34343434H', 'Restaurante Las Vidrieras', 'Cervantes 16, Almagro', 'C', 'Castilla-La Mancha');

--Vinos 1, 2

EXEC InsertarVino(1, 'Vega Sicilia', 2008, 'Ribera del Duero', 12.5, 'Castillo Blanco', 'Castilla-León', 200, 1);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (1, 'Vega Sicilia', 1998, 'Ribera del Duero', 12.5, 200, 'Castilla-León', 'Castillo Blanco', 200, 1);
EXEC InsertarVino(2, 'Vega Sicilia', 2015, 'Ribera del Duero', 12.5, 'Castillo Blanco', 'Castilla-León', 100, 1);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (2, 'Vega Sicilia', 2005, 'Ribera del Duero', 12.5, 100, 'Castilla-León', 'Castillo Blanco', 100, 1);
EXEC InsertarVino(3, 'Marqués de Cáceres', 2019, 'Rioja', 11, 'Santo Domingo', 'La Rioja', 200, 2);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (3, 'Marqués de Cáceres', 2009, 'Rioja', 11, 200, 'La Rioja', 'Santo Domingo', 200, 2);
EXEC InsertarVino(4, 'Marqués de Cáceres', 2022, 'Rioja', 11.5, 'Santo Domingo', 'La Rioja', 250, 2);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (4, 'Marqués de Cáceres', 2012, 'Rioja', 11.5, 250, 'La Rioja', 'Santo Domingo', 250, 2);
EXEC InsertarVino(14, 'Tablas de Daimiel', 2018, 'Valdepeñas', 11.5, 'Laguna Azul', 'Castilla-La Mancha', 300, 5);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (14, 'Tablas de Daimiel', 2008, 'Valdepeñas', 11.5, 300, 'Castilla-La Mancha', 'Laguna Azul', 300, 5);
EXEC InsertarVino(17, 'Estela', 2022, 'Cariñena', 10.5, 'San Millán', 'Aragón', 200, 3);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (17, 'Estela', 2012, 'Cariñena', 10.5, 200, 'Aragón', 'San Millán', 200, 3);

--director sucursal

--ModificarDirectorSucursal(suc, emp)

EXEC ModificarDirectorSucursal(4, 7);
EXEC ModificarDirectorSucursal(5, 9);
EXEC ModificarDirectorSucursal(6, 11);
--UPDATE Sucursal SET director_sucursal = '7' WHERE codSucursal = 4;
--UPDATE Sucursal SET director_sucursal = '9' WHERE codSucursal = 5;
--UPDATE Sucursal SET director_sucursal = '11' WHERE codSucursal = 6;

--sucursalvendevino se rellena automaticamente en nuestro caso
/*INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (4, 4);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (5, 2);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (6, 14);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (4, 3);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (4, 17);
*/
--hasta aqui se ha insertado todo bien

------------------------------
--- Inserciones localidad 2
------------------------------

--SUCURSALES 7, 8, 9

EXEC InsertarSucursal(7, 'Catedral del Mar', 'Barcelona', 'Cataluña');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (7, 'Catedral del Mar', 'Barcelona', 'Cataluña');
EXEC InsertarSucursal(8, 'Dama de Elche', 'Alicante', 'País Valenciano');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (8, 'Dama de Elche', 'Alicante', 'País Valenciano');
EXEC InsertarSucursal(9, 'La Cartuja', 'Palma de Mallorca', 'Baleares');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (9, 'La Cartuja', 'Palma de Mallorca', 'Baleares');


--empleados 13-18
EXEC InsertarEmpleado(13, '13131313M', 'Patricia', TO_DATE('4-12-2019', 'DD/MM/YYYY'), 'Diagonal 132, Barcelona', 2000, 7);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (13, '13131313M', 'Patricia', TO_DATE('4-11-2009', 'DD/MM/YYYY'), 2000, 'Diagonal 132, Barcelona', 7);
EXEC InsertarEmpleado(14, '14141414N', 'Inés', TO_DATE('7-03-2018', 'DD/MM/YYYY'), 'Colón 24, Barcelona', 1800, 7);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (14, '14141414N', 'Inés', TO_DATE('7-03-2008', 'DD/MM/YYYY'), 1800, 'Colón 24, Barcelona', 7);
EXEC InsertarEmpleado(15, '15151515O', 'Carlos', TO_DATE('16-06-2019', 'DD/MM/YYYY'), 'Palmeras 57, Alicante', 2000, 8);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (15, '15151515O', 'Carlos', TO_DATE('16-06-2009', 'DD/MM/YYYY'), 2000, 'Palmeras 57, Alicante', 8);
EXEC InsertarEmpleado(16, '16161616P', 'Dolores', TO_DATE('14-05-2018', 'DD/MM/YYYY'), 'Calatrava 9, Alicante', 1800, 8);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (16, '16161616P', 'Dolores', TO_DATE('14-05-2008', 'DD/MM/YYYY'), 1800, 'Calatrava 9, Alicante', 8);
EXEC InsertarEmpleado(17, '17171717Q', 'Elías', TO_DATE('13-06-2019', 'DD/MM/YYYY'), 'Arenal 17, P. Mallorca', 2000, 9);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (17, '17171717Q', 'Elías', TO_DATE('13-06-2009', 'DD/MM/YYYY'), 2000, 'Arenal 17, P. Mallorca', 9);
EXEC InsertarEmpleado(18, '18181818R', 'Concepción', TO_DATE('18-08-2020', 'DD/MM/YYYY'), 'Campastilla 14, P. Mallorca', 1800, 9);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (18, '18181818R', 'Concepción', TO_DATE('18-08-2010', 'DD/MM/YYYY'), 1800, 'Campastilla 14, P. Mallorca', 9);

--CLIENTES 5, 6
EXEC InsertarCliente(5, '30303030E', 'Restaurante El Payés', 'San Lucas 33, Mahón', 'C', 'Baleares');
--INSERT INTO Cliente(codCliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, CA_cliente)
--VALUES(5, '30303030E', 'Restaurante El Payés', 'San Lucas 33, Mahón', 'C', 'Baleares');
EXEC InsertarCliente(6, '31313131F', 'Mercadona', 'Desamparados 29, Castellón', 'A', 'País Valenciano');
--INSERT INTO Cliente(codCliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, CA_cliente)
--VALUES(6, '31313131F', 'Mercadona', 'Desamparados 29, Castellón', 'A', 'País Valenciano');

--VINOS 5, 6, 13, 16

EXEC InsertarVino(5, 'René Barbier', 2023, 'Penedés', 11.5, 'Virgen de Estrella', 'Cataluña', 200, 3);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (5, 'René Barbier', 2013, 'Penedés', 11.5, 200, 'Cataluña', 'Virgen de Estrella', 200, 3);
EXEC InsertarVino(6, 'René Barbier', 2020, 'Penedés', 11, 'Virgen de Estrella', 'Cataluña', 250, 3);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (6, 'René Barbier', 2010, 'Penedés', 11, 250, 'Cataluña', 'Virgen de Estrella', 250, 3);
EXEC InsertarVino(13, 'Vega Murciana', 2023, 'Jumilla', 11.5, 'Vega Verde', 'Murcia', 250, 5);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (13, 'Vega Murciana', 2013, 'Jumilla', 11.5, 250, 'Murcia', 'Vega Verde', 250, 5);
EXEC InsertarVino(16, 'Freixenet', 2024, 'Cava', 7.5, 'Valle Dorado', 'Cataluña', 250, 6);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (16, 'Freixenet', 2014, 'Cava', 7.5, 250, 'Cataluña', 'Valle Dorado', 250, 6);

--director sucursal
EXEC ModificarDirectorSucursal(7, 13);
EXEC ModificarDirectorSucursal(8, 15);
EXEC ModificarDirectorSucursal(9, 17);
/*
UPDATE Sucursal SET director_sucursal = '13' WHERE codSucursal = 7;
UPDATE Sucursal SET director_sucursal = '15' WHERE codSucursal = 8;
UPDATE Sucursal SET director_sucursal = '17' WHERE codSucursal = 9;
*/

/*
INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (7, 5);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (8, 6);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (9, 16);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (7, 6);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (9, 13);
*/
--se ejecuta bien hasta aqui
------------------------------
--- Inserciones localidad 3
------------------------------

EXEC InsertarSucursal(10, 'Meigas', 'La Coruña', 'Galicia');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (10, 'Meigas', 'La Coruña', 'Galicia');
EXEC InsertarSucursal(11, 'La Concha', 'San Sebastián', 'País Vasco');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (11, 'La Concha', 'San Sebastián', 'País Vasco');
EXEC InsertarSucursal(12, 'Don Pelayo', 'Oviedo', 'Asturias');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (12, 'Don Pelayo', 'Oviedo', 'Asturias');

--empleados 19-24

EXEC InsertarEmpleado(19, '19191919S', 'Gabriel', TO_DATE('19-09-2015', 'DD/MM/YYYY'), 'Hércules 19, La Coruña', 2000, 10);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (19, '19191919S', 'Gabriel', TO_DATE('19-09-2005', 'DD/MM/YYYY'), 2000, 'Hércules 19, La Coruña', 10);
EXEC InsertarEmpleado(20, '20202020T', 'Octavio', TO_DATE('20-10-2017', 'DD/MM/YYYY'), 'María Pita 45, La Coruña', 1800, 10);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (20, '20202020T', 'Octavio', TO_DATE('20-10-2007', 'DD/MM/YYYY'), 1800, 'María Pita 45, La Coruña', 10);
EXEC InsertarEmpleado(21, '21212121V', 'Cesar', TO_DATE('13-11-2021', 'DD/MM/YYYY'), 'Las Peñas 41, San Sebastián', 2000, 11);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (21, '21212121V', 'Cesar', TO_DATE('13-11-2011', 'DD/MM/YYYY'), 2000, 'Las Peñas 41, San Sebastián', 11);
EXEC InsertarEmpleado(22, '23232323W', 'Julia', TO_DATE('24-03-2020', 'DD/MM/YYYY'), 'San Cristóbal 5, San Sebastián', 1800, 11);   
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (22, '23232323W', 'Julia', TO_DATE('24-03-2010', 'DD/MM/YYYY'), 1800, 'San Cristóbal 5, San Sebastián', 11);
EXEC InsertarEmpleado(23, '24242424X', 'Claudia', TO_DATE('13-02-2022', 'DD/MM/YYYY'), 'Santa Cruz 97, Oviedo', 2000, 12);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (23, '24242424X', 'Claudia', TO_DATE('13-02-2012', 'DD/MM/YYYY'), 2000, 'Santa Cruz 97, Oviedo', 12);
EXEC InsertarEmpleado(24, '25252525Z', 'Mario', TO_DATE('23-04-2017', 'DD/MM/YYYY'), 'Naranco 21, Oviedo', 1800, 12);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (24, '25252525Z', 'Mario', TO_DATE('23-04-2007', 'DD/MM/YYYY'), 1800, 'Naranco 21, Oviedo', 12);


--CLIENTES 3, 4
EXEC InsertarCliente(3, '28282828C', 'Continente', 'San Francisco 37, Vigo', 'A', 'Galicia');
--INSERT INTO Cliente(codCliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, CA_cliente)
--VALUES(3, '28282828C', 'Continente', 'San Francisco 37, Vigo', 'A', 'Galicia');
EXEC InsertarCliente(4, '29292929D', 'Restaurante El Asturiano', 'Covadonga 24, Luarca', 'C', 'Asturias');
--INSERT INTO Cliente(codCliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, CA_cliente)
--VALUES(4, '29292929D', 'Restaurante El Asturiano', 'Covadonga 24, Luarca', 'C', 'Asturias');

--VINOS 7, 8, 15, 19, 20

EXEC InsertarVino(7, 'Rias Baixas', 2024, 'Albariño', 9.5, 'Santa Compaña', 'Galicia', 150, 4);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (7, 'Rias Baixas', 2014, 'Albariño', 9.5, 150, 'Galicia', 'Santa Compaña', 150, 4);
EXEC InsertarVino(8, 'Rias Baixas', 2023, 'Albariño', 9, 'Santa Compaña', 'Galicia', 100, 4);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (8, 'Rias Baixas', 2013, 'Albariño', 9, 100, 'Galicia', 'Santa Compaña', 100, 4);
EXEC InsertarVino(15, 'Santa María', 2023, 'Tierra de Cangas', 10, 'Monte Astur', 'Asturias', 200, 6);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (15, 'Santa María', 2013, 'Tierra de Cangas', 10, 200, 'Asturias', 'Monte Astur', 200, 6);
EXEC InsertarVino(19, 'Meigas Bellas', 2024, 'Ribeiro', 8.5, 'Mayor Santiago', 'Galicia', 250, 6);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (19, 'Meigas Bellas', 2014, 'Ribeiro', 8.5, 250, 'Galicia', 'Mayor Santiago', 250, 6);
EXEC InsertarVino(20, 'Altamira', 2024, 'Tierra de Liébana', 9.5, 'Cuevas', 'Cantabria', 300, 1);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (20, 'Altamira', 2014, 'Tierra de Liébana', 9.5, 300, 'Cantabria', 'Cuevas', 300, 1);

--director sucursal

EXEC ModificarDirectorSucursal(10, 19);
EXEC ModificarDirectorSucursal(11, 21);
EXEC ModificarDirectorSucursal(12, 23);
/*
UPDATE Sucursal SET director_sucursal = '19' WHERE codSucursal = 10;
UPDATE Sucursal SET director_sucursal = '21' WHERE codSucursal = 11;
UPDATE Sucursal SET director_sucursal = '23' WHERE codSucursal = 12;

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (10, 7);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (11, 15);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (12, 19);
*/

------------------------------
--- Inserciones localidad 4
------------------------------

--SUCURSALES 1, 2, 3
EXEC InsertarSucursal(1, 'Santa Cruz', 'Sevilla', 'Andalucía');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (1, 'Santa Cruz', 'Sevilla', 'Andalucía');
EXEC InsertarSucursal(2, 'Palacios Nazaries', 'Granada', 'Andalucía');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (2, 'Palacios Nazaries', 'Granada', 'Andalucía');
EXEC InsertarSucursal(3, 'Tacita de Plata', 'Cádiz', 'Andalucía');
--INSERT INTO Sucursal(codSucursal, nombre_sucursal, ciudad_sucursal, CA_sucursal)
--VALUES (3, 'Tacita de Plata', 'Cádiz', 'Andalucía');

--EMPLEADOS 1-6

EXEC InsertarEmpleado(1, '11111111A', 'Raúl', TO_DATE('21-09-2010', 'DD/MM/YYYY'), 'Sierpes 37, Sevilla', 2000, 1);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (1, '11111111A', 'Raúl', TO_DATE('21-09-2000', 'DD/MM/YYYY'), 2000, 'Sierpes 37, Sevilla', 1);
EXEC InsertarEmpleado(2, '22222222B', 'Federico', TO_DATE('25-08-2009', 'DD/MM/YYYY'), 'Emperatriz 25, Sevilla', 1800, 1);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (2, '22222222B', 'Federico', TO_DATE('25-08-1999', 'DD/MM/YYYY'), 1800, 'Emperatriz 25, Sevilla', 1);
EXEC InsertarEmpleado(3, '33333333C', 'Natalia', TO_DATE('30-01-2012', 'DD/MM/YYYY'), 'Ronda 126, Granada', 2000, 2);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (3, '33333333C', 'Natalia', TO_DATE('30-01-2002', 'DD/MM/YYYY'), 2000, 'Ronda 126, Granada', 2);
EXEC InsertarEmpleado(4, '44444444D', 'Amalia', TO_DATE('13-02-2013', 'DD/MM/YYYY'), 'San Matías 23, Granada', 1800, 2);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (4, '44444444D', 'Amalia', TO_DATE('13-02-2003', 'DD/MM/YYYY'), 1800, 'San Matías 23, Granada', 2);
EXEC InsertarEmpleado(5, '55555555E', 'Susana', TO_DATE('1-10-2018', 'DD/MM/YYYY'), 'Zoraida 5, Cádiz', 2000, 3);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (5, '55555555E', 'Susana', TO_DATE('1-10-2008', 'DD/MM/YYYY'), 2000, 'Zoraida 5, Cádiz', 3);
EXEC InsertarEmpleado(6, '66666666F', 'Gonzalo', TO_DATE('1-01-2007', 'DD/MM/YYYY'), 'Tartesos 9, Cádiz', 1800, 3);
--INSERT INTO Empleado(codEmpleado, DNI_empleado, nombre_empleado, fecha_comienzo_contrato, salario, direccion_empleado, codSucursal)
--VALUES (6, '66666666F', 'Gonzalo', TO_DATE('1-01-1997', 'DD/MM/YYYY'), 1800, 'Tartesos 9, Cádiz', 3);


--CLIENTES 1, 2

EXEC InsertarCliente(1, '26262626A', 'Hipercor', 'Virgen de la Capilla 32, Jaén', 'A', 'Andalucía');
--INSERT INTO Cliente(codCliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, CA_cliente)
--VALUES(1, '26262626A', 'Hipercor', 'Virgen de la Capilla 32, Jaén', 'A', 'Andalucía');
EXEC InsertarCliente(2, '27272727B', 'Restaurante Cacereño', 'San Marcos 41, Cáceres', 'C', 'Extremadura');
--INSERT INTO Cliente(codCliente, DNI_cliente, nombre_cliente, direccion_cliente, tipo_cliente, CA_cliente)
--VALUES(2, '27272727B', 'Restaurante Cacereño', 'San Marcos 41, Cáceres', 'C', 'Extremadura');

--VINOS 9, 10, 18, 21

--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (20, 'Altamira', 2014, 'Tierra de Liébana', 9.5, 300, 'Cantabria', 'Cuevas', 300, 1);
--NO!! AQUI NO VA. AÑADIDO EN LOCALIDAD 3 (Cantabria)

EXEC InsertarVino(9, 'Córdoba Bella', 2018, 'Montilla', 12, 'Mezquita Roja', 'Andalucía', 200, 4);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (9, 'Córdoba Bella', 2008, 'Montilla', 12, 200, 'Andalucía', 'Mezquita Roja', 200, 4);

EXEC InsertarVino(10, 'Tío Pepe', 2020, 'Jerez', 12.5, 'Campo Verde', 'Andalucía', 200, 4);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (10, 'Tío Pepe', 2010, 'Jerez', 12.5, 200, 'Andalucía', 'Campo Verde', 200, 4);

EXEC InsertarVino(18, 'Uva dorada', 2023, 'Málaga', 13, 'Axarquía', 'Andalucía', 200, 5);

--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (18, 'Uva dorada', 2013, 'Málaga', 13, 200, 'Andalucía', 'Axarquía', 200, 5);
EXEC InsertarVino(21, 'Virgen negra', 2024, 'Islas Canarias', 10.5, 'Guanche', 'Canarias', 300, 3);
--INSERT INTO Vino(codVino, marca_vino, anyo_vino, denominacion_origen, graduacion, cantidad_stock, CA_vino, vinedo_procedencia, cantidad_producida, codProductor)
--VALUES (21, 'Virgen negra', 2014, 'Islas Canarias', 10.5, 300, 'Canarias', 'Guanche', 300, 3);

--director sucursal

EXEC ModificarDirectorSucursal(1, 1);
EXEC ModificarDirectorSucursal(2, 3);
EXEC ModificarDirectorSucursal(3, 5);
/*
UPDATE Sucursal SET director_sucursal = '1' WHERE codSucursal = 1;
UPDATE Sucursal SET director_sucursal = '3' WHERE codSucursal = 2;
UPDATE Sucursal SET director_sucursal = '5' WHERE codSucursal = 3;



INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (1, 10);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (2, 21);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (2, 9);

INSERT INTO SucursalVendeVino (codSucursal, codVino)
VALUES (3, 18);
*/


--LOCALIDAD 1 SUMINISTROS:

--InsertarOActualizarSuministro

EXEC InsertarOActualizarSuministro(7, 4, 1, TO_DATE('15-02-2025', 'DD/MM/YYYY'), 80);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (7, 4, 1, TO_DATE('15-02-2019', 'DD/MM/YYYY'), 80);
EXEC InsertarOActualizarSuministro(7, 5, 7, TO_DATE('17-04-2025', 'DD/MM/YYYY'), 50);

--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (7, 5, 7, TO_DATE('17-05-2019', 'DD/MM/YYYY'), 50);
EXEC InsertarOActualizarSuministro(7, 4, 10, TO_DATE('21-06-2025', 'DD/MM/YYYY'), 70);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (7, 4, 10, TO_DATE('21-06-2019', 'DD/MM/YYYY'), 70);

--FALTA UN PEDIDO NUEVO DE ESE CLIENTE
--EXEC InsertarOActualizarSuministro(7, 5, 12, TO_DATE('23-07-2025', 'DD/MM/YYYY'), 40);
--CORRECCION: no existe vino 12 (cancelado por el foro de prado)

EXEC InsertarOActualizarSuministro(8, 6, 14, TO_DATE('11-01-2025', 'DD/MM/YYYY'), 50);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (8, 6, 14, TO_DATE('11-01-2019', 'DD/MM/YYYY'), 50);
EXEC InsertarOActualizarSuministro(8, 6, 4, TO_DATE('14-03-2025', 'DD/MM/YYYY'), 60);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (8, 6, 4, TO_DATE('14-03-2019', 'DD/MM/YYYY'), 60);
EXEC InsertarOActualizarSuministro(8, 4, 6, TO_DATE('21-05-2025', 'DD/MM/YYYY'), 70);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (8, 4, 6, TO_DATE('21-05-2019', 'DD/MM/YYYY'), 70);

--aun no existian esos vinos



--LOCALIDAD 2 SUMINISTROS:

--insertaroactualizarsuministro

EXEC InsertarOActualizarSuministro(5, 7, 16, TO_DATE('14-08-2025', 'DD/MM/YYYY'), 50);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (5, 7, 16, TO_DATE('14-08-2019', 'DD/MM/YYYY'), 50);
EXEC InsertarOActualizarSuministro(5, 9, 18, TO_DATE('01-10-2025', 'DD/MM/YYYY'), 100);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (5, 9, 18, TO_DATE('01-10-2019', 'DD/MM/YYYY'), 100);
EXEC InsertarOActualizarSuministro(6, 8, 15, TO_DATE('13-01-2025', 'DD/MM/YYYY'), 100);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (6, 8, 15, TO_DATE('13-01-2019', 'DD/MM/YYYY'), 100);
EXEC InsertarOActualizarSuministro(6, 8, 9, TO_DATE('19-02-2025', 'DD/MM/YYYY'), 150); 
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (6, 8, 9, TO_DATE('19-02-2019', 'DD/MM/YYYY'), 150);
EXEC InsertarOActualizarSuministro(6, 9, 19, TO_DATE('27-06-2025', 'DD/MM/YYYY'), 160);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (6, 9, 19, TO_DATE('27-06-2019', 'DD/MM/YYYY'), 160);
EXEC InsertarOActualizarSuministro(6, 7, 21, TO_DATE('17-09-2025', 'DD/MM/YYYY'), 200);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (6, 7, 21, TO_DATE('17-09-2019', 'DD/MM/YYYY'), 200);

--LOCALIDAD 3 SUMINISTROS:


--insertaroactualizarsuministro

EXEC InsertarOActualizarSuministro(3, 10, 3, TO_DATE('21-02-2025', 'DD/MM/YYYY'), 100);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (3, 10, 3, TO_DATE('21-02-2019', 'DD/MM/YYYY'), 100);
EXEC InsertarOActualizarSuministro(3, 10, 6, TO_DATE('02-08-2025', 'DD/MM/YYYY'), 90);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (3, 10, 6, TO_DATE('02-08-2019', 'DD/MM/YYYY'), 90);
EXEC InsertarOActualizarSuministro(3, 11, 13, TO_DATE('03-10-2025', 'DD/MM/YYYY'), 200);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (3, 11, 13, TO_DATE('03-10-2019', 'DD/MM/YYYY'), 200);
EXEC InsertarOActualizarSuministro(3, 12, 20, TO_DATE('04-11-2025', 'DD/MM/YYYY'), 150);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (3, 12, 20, TO_DATE('04-11-2019', 'DD/MM/YYYY'), 150);
EXEC InsertarOActualizarSuministro(4, 12, 8, TO_DATE('01-03-2025', 'DD/MM/YYYY'), 50);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (4, 12, 8, TO_DATE('01-03-2019', 'DD/MM/YYYY'), 50);
EXEC InsertarOActualizarSuministro(4, 12, 17, TO_DATE('03-05-2025', 'DD/MM/YYYY'), 70);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (4, 12, 17, TO_DATE('03-05-2019', 'DD/MM/YYYY'), 70);


--LOCALIDAD 4 SUMINISTROS:

--insertaroactualizarsuministro

EXEC InsertarOActualizarSuministro(1, 1, 4, TO_DATE('12-06-2025', 'DD/MM/YYYY'), 100);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (1, 1, 4, TO_DATE('12-06-2019', 'DD/MM/YYYY'), 100);
EXEC InsertarOActualizarSuministro(1, 2, 5, TO_DATE('11-07-2025', 'DD/MM/YYYY'), 150);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (1, 2, 5, TO_DATE('11-07-2019', 'DD/MM/YYYY'), 150);
EXEC InsertarOActualizarSuministro(1, 3, 14, TO_DATE('15-07-2025', 'DD/MM/YYYY'), 200);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (1, 3, 14, TO_DATE('15-07-2019', 'DD/MM/YYYY'), 200);
EXEC InsertarOActualizarSuministro(2, 2, 2, TO_DATE('03-04-2025', 'DD/MM/YYYY'), 20);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (2, 2, 2, TO_DATE('03-04-2015', 'DD/MM/YYYY'), 20);
EXEC InsertarOActualizarSuministro(2, 1, 7, TO_DATE('04-05-2025', 'DD/MM/YYYY'), 50);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (2, 1, 7, TO_DATE('04-05-2019', 'DD/MM/YYYY'), 50);
EXEC InsertarOActualizarSuministro(2, 2, 6, TO_DATE('15-09-2025', 'DD/MM/YYYY'), 40);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (2, 2, 6, TO_DATE('15-09-2019', 'DD/MM/YYYY'), 40);
EXEC InsertarOActualizarSuministro(2, 3, 16, TO_DATE('20-09-2025', 'DD/MM/YYYY'), 100);
--INSERT INTO ClienteSolicitaVinoASucursal (codCliente, codSucursal, codVino, fecha, cantidad)
--VALUES (2, 3, 16, TO_DATE('20-09-2019', 'DD/MM/YYYY'), 100);

-- inserciones en todas las localidades parte 2
EXEC InsertarPedido(1, 4, 4, TO_DATE('13-06-2025', 'DD/MM/YYYY'), 100);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (1, 4, 4, TO_DATE('12-06-2019', 'DD/MM/YYYY'), 100);
EXEC InsertarPedido(1, 10, 7, TO_DATE('05-05-2025', 'DD/MM/YYYY'), 50);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (1, 10, 7, TO_DATE('05-05-2019', 'DD/MM/YYYY'), 50);
EXEC InsertarPedido(2, 7, 5, TO_DATE('12-07-2025', 'DD/MM/YYYY'), 150);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (2, 7, 5, TO_DATE('12-06-2019', 'DD/MM/YYYY'), 150);
EXEC InsertarPedido(2, 5, 2, TO_DATE('04-04-2025', 'DD/MM/YYYY'), 20);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (2, 5, 2, TO_DATE('04-04-2019', 'DD/MM/YYYY'), 20);
EXEC InsertarPedido(2, 8, 6, TO_DATE('16-09-2025', 'DD/MM/YYYY'), 40);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (2, 8, 6, TO_DATE('16-09-2019', 'DD/MM/YYYY'), 40);
EXEC InsertarPedido(3, 6, 14, TO_DATE('15-07-2025', 'DD/MM/YYYY'), 200);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (3, 6, 14, TO_DATE('15-07-2019', 'DD/MM/YYYY'), 200);
EXEC InsertarPedido(3, 9, 16, TO_DATE('21-09-2025', 'DD/MM/YYYY'), 100);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (3, 9, 16, TO_DATE('21-09-2019', 'DD/MM/YYYY'), 100);
EXEC InsertarPedido(4, 1, 10, TO_DATE('22-06-2025', 'DD/MM/YYYY'), 70);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (4, 1, 10, TO_DATE('22-06-2019', 'DD/MM/YYYY'), 70);
EXEC InsertarPedido(4, 7, 6, TO_DATE('22-05-2025', 'DD/MM/YYYY'), 70);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (4, 7, 6, TO_DATE('22-05-2019', 'DD/MM/YYYY'), 70);
EXEC InsertarPedido(5, 10, 7, TO_DATE('18-04-2025', 'DD/MM/YYYY'), 50);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (5, 10, 7, TO_DATE('18-04-2019', 'DD/MM/YYYY'), 50);
EXEC InsertarPedido(7, 2, 21, TO_DATE('18-09-2025', 'DD/MM/YYYY'), 200);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (7, 2, 21, TO_DATE('18-09-2019', 'DD/MM/YYYY'), 200);
EXEC InsertarPedido(8, 11, 15, TO_DATE('14-01-2025', 'DD/MM/YYYY'), 100);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (8, 11, 15, TO_DATE('14-01-2019', 'DD/MM/YYYY'), 100);
EXEC InsertarPedido(8, 2, 9, TO_DATE('20-02-2025', 'DD/MM/YYYY'), 150);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (8, 2, 9, TO_DATE('20-02-2019', 'DD/MM/YYYY'), 150);
EXEC InsertarPedido(9, 3, 18, TO_DATE('02-10-2025', 'DD/MM/YYYY'), 100);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (9, 3, 18, TO_DATE('02-10-2019', 'DD/MM/YYYY'), 100);
EXEC InsertarPedido(9, 12, 19, TO_DATE('28-06-2025', 'DD/MM/YYYY'), 160);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (9, 12, 19, TO_DATE('28-06-2019', 'DD/MM/YYYY'), 160);
EXEC InsertarPedido(10, 4, 3, TO_DATE('22-02-2025', 'DD/MM/YYYY'), 100);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (10, 4, 3, TO_DATE('22-02-2019', 'DD/MM/YYYY'), 100) ;
EXEC InsertarPedido(10, 8, 6, TO_DATE('02-08-2025', 'DD/MM/YYYY'), 90);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (10, 8, 6, TO_DATE('02-08-2019', 'DD/MM/YYYY'), 90);
EXEC InsertarPedido(11, 9, 13, TO_DATE('04-10-2025', 'DD/MM/YYYY'), 200);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (11, 9, 13, TO_DATE('04-10-2019', 'DD/MM/YYYY'), 200);
EXEC InsertarPedido(12, 4, 17, TO_DATE('04-05-2025', 'DD/MM/YYYY'), 70);
--INSERT INTO SucursalSolicitaSucursal (codSucursalPide, codSucursalPedido, codVino, fecha, cantidad)
--VALUES (12, 4, 17, TO_DATE('04-05-2019', 'DD/MM/YYYY'), 70);

COMMIT;


