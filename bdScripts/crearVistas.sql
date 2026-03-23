-- Autores: Lucía Cepeda González, Adriana Rubia Alcarria
-- Descripción: Script práctica 3 - creación de vistas


-- Tenemos que crear las vistas para reconstruir tablas globales a partir de las fragmentaciones que hemos hecho en la base de datos.
-- Las tablas replicadas (Productor y SucursalPideSuministro) no necesitan vista, ya que están completas en cada fragmento.


-- DROPS VISTAS

DROP VIEW Empleado CASCADE CONSTRAINTS;
DROP VIEW Sucursal CASCADE CONSTRAINTS;
DROP VIEW Cliente CASCADE CONSTRAINTS;
DROP VIEW Vino CASCADE CONSTRAINTS;
DROP VIEW SucursalVendeVino CASCADE CONSTRAINTS;
DROP VIEW ClienteSolicitaSuministro CASCADE CONSTRAINTS;    


-- CREACIÓN VISTAS

CREATE OR REPLACE VIEW Empleado AS
SELECT * FROM luna1.Empleado1
UNION                               -- La UNION elimina duplicados automáticamente
SELECT * FROM luna2.Empleado2
UNION
SELECT * FROM luna3.Empleado3
UNION
SELECT * FROM luna4.Empleado4;


CREATE OR REPLACE VIEW Sucursal AS
SELECT * FROM luna1.Sucursal1
UNION
SELECT * FROM luna2.Sucursal2
UNION
SELECT * FROM luna3.Sucursal3
UNION
SELECT * FROM luna4.Sucursal4;

CREATE OR REPLACE VIEW Cliente AS
SELECT * FROM luna1.Cliente1
UNION
SELECT * FROM luna2.Cliente2
UNION
SELECT * FROM luna3.Cliente3
UNION
SELECT * FROM luna4.Cliente4;


CREATE OR REPLACE VIEW Vino AS
SELECT * FROM luna1.Vino1
UNION
SELECT * FROM luna2.Vino2
UNION
SELECT * FROM luna3.Vino3
UNION
SELECT * FROM luna4.Vino4;


CREATE OR REPLACE VIEW SucursalVendeVino AS
SELECT * FROM luna1.SucursalVendeVino1
UNION
SELECT * FROM luna2.SucursalVendeVino2
UNION
SELECT * FROM luna3.SucursalVendeVino3
UNION
SELECT * FROM luna4.SucursalVendeVino4;


CREATE OR REPLACE VIEW ClienteSolicitaSuministro AS
SELECT * FROM luna1.ClienteSolicitaSuministro1
UNION
SELECT * FROM luna2.ClienteSolicitaSuministro2
UNION
SELECT * FROM luna3.ClienteSolicitaSuministro3
UNION
SELECT * FROM luna4.ClienteSolicitaSuministro4;

COMMIT;
