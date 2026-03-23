-- Autores: Lucía Cepeda González, Adriana Rubia Alcarria
-- Descripción: Script práctica 3 - creación de triggers para verificar la integridad

--1. Restricciones de llave única (hechos globalmente y en tablas)
-- Restricciones no nulas que se consideren oportunas. (hemos contemplado esto con los NOT NULL en tablas)

-- 2. Restricciones de integridad referencial (FOREIGN KEY) que se consideren oportunas. (hechas)
-- 4. Un empleado, al mismo tiempo, solamente puede ser director de una sucursal. (contemplado en tablas)
 
-- =========================================================
--                EMPLEADO  
-- ========================================================

-- PRIMARY KEY Empleado
CREATE OR REPLACE TRIGGER TRPKEmpleado
BEFORE INSERT OR UPDATE ON Empleado3
FOR EACH ROW
DECLARE cont NUMBER(3);
BEGIN
    IF INSERTING THEN
        SELECT COUNT(cod_empleado) INTO cont
        FROM Empleado
        WHERE cod_empleado = :NEW.cod_empleado;
        IF cont > 0 THEN
            RAISE_APPLICATION_ERROR(-20005,'Ya existe un empleado con esa clave.');
        END IF;
    END IF;

    IF UPDATING('cod_empleado') THEN
        RAISE_APPLICATION_ERROR(-20010,'No se puede cambiar el código de un empleado.');
    END IF;
END;
/

------------------------------------------------------------

-- 5. Un empleado, al mismo tiempo, solamente puede trabajar en una sucursal. 
CREATE OR REPLACE TRIGGER TREmpleadoUnaSucursal
BEFORE INSERT OR UPDATE ON Empleado3
FOR EACH ROW
DECLARE cont NUMBER(3);
BEGIN
    IF INSERTING OR UPDATING('cod_sucursal') THEN
        SELECT COUNT(*) INTO cont
        FROM Empleado
        WHERE cod_sucursal != :NEW.cod_sucursal
          AND DNI_empleado = :NEW.DNI_empleado; 
        IF cont > 0 THEN
            RAISE_APPLICATION_ERROR(
                -20105,
                'Un empleado solo puede trabajar en una sucursal.'
            );
        END IF;
    END IF;
END;
/

-- Entonces hay que poner que el dni de empleado es unico en la tabla empleados
CREATE OR REPLACE TRIGGER TRUniqueDNIEmpleado   
BEFORE INSERT OR UPDATE ON Empleado3
FOR EACH ROW
DECLARE cont NUMBER(3);
BEGIN
    IF INSERTING THEN
        SELECT COUNT(DNI_empleado) INTO cont
        FROM Empleado
        WHERE DNI_empleado = :NEW.DNI_empleado;
        IF cont > 0 THEN
            RAISE_APPLICATION_ERROR(-20107,'Ya existe un empleado con ese DNI.');
        END IF;
    END IF;

    IF UPDATING('DNI_empleado') THEN
        RAISE_APPLICATION_ERROR(-20108,'No se puede cambiar el DNI de un empleado.');
    END IF;
END;
/

------------------------------------------------------------

-- 6. El salario de un empleado nunca puede disminuir.
CREATE OR REPLACE TRIGGER TRSalarioNoDisminuye
BEFORE INSERT OR UPDATE ON Empleado3
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.salario < 0 THEN
            RAISE_APPLICATION_ERROR(
                -20110,
                'El salario de un empleado no puede ser negativo.'
            );
        END IF;
    END IF;

    IF UPDATING('salario') THEN
        IF :NEW.salario < :OLD.salario THEN
            RAISE_APPLICATION_ERROR(
                -20115,
                'El salario de un empleado no puede disminuir. Salario actual: '
                || :OLD.salario || ' euros.'
            );
        END IF;
    END IF;
END;
/

------------------------------------------------------------

-- 7. La sucursal en la que trabaja un empleado debe existir.
-- ADD CONSTRAINT fk_sucursal FOREIGN KEY (cod_sucursal) REFERENCES Sucursal3(cod_sucursal);
CREATE OR REPLACE TRIGGER TREmpleadoFKSucursal
BEFORE INSERT OR UPDATE ON Empleado3
FOR EACH ROW
DECLARE cont NUMBER(3);
BEGIN
    IF INSERTING OR UPDATING('cod_sucursal') THEN
        SELECT COUNT(cod_sucursal) INTO cont
        FROM Sucursal
        WHERE cod_sucursal = :NEW.cod_sucursal;
        IF cont = 0 THEN
            RAISE_APPLICATION_ERROR(
                -20120,
                'La sucursal en la que trabaja un empleado debe existir.'
            );
        END IF;
    END IF;
END;
/

-- =========================================================
--                 SUCURSAL
-- =========================================================

-- PRIMARY KEY Sucursal
CREATE OR REPLACE TRIGGER TRPKSucursal
BEFORE INSERT OR UPDATE ON Sucursal3
FOR EACH ROW
DECLARE cont NUMBER(3);
BEGIN
    IF INSERTING THEN
        SELECT COUNT(cod_sucursal) INTO cont
        FROM Sucursal
        WHERE cod_sucursal = :NEW.cod_sucursal;
        IF cont > 0 THEN
            RAISE_APPLICATION_ERROR(-20015,'Ya existe una sucursal con esa clave.');
        END IF;
    END IF;

    IF UPDATING('cod_sucursal') THEN
        RAISE_APPLICATION_ERROR(-20020,'No se puede cambiar el código de una sucursal.');
    END IF;
END;
/

------------------------------------------------------------

-- 3. El director de una sucursal es empleado de la compañía (no tiene que ser empleado de la sucursal).
--FOREIGN KEY (cod_director) REFERENCES Empleado3(cod_empleado) en Sucursal
CREATE OR REPLACE TRIGGER TRSucursalFKEmpleado
BEFORE INSERT OR UPDATE ON Sucursal3
FOR EACH ROW
DECLARE cont NUMBER(3);
BEGIN
    IF INSERTING OR UPDATING('cod_director') THEN
        IF :NEW.cod_director IS NOT NULL THEN
            SELECT COUNT(*) INTO cont
            FROM Empleado
            WHERE cod_empleado = :NEW.cod_director;
            IF cont = 0 THEN
                RAISE_APPLICATION_ERROR(
                    -20096,
                    'El director de una sucursal debe ser empleado de la compañía.'
                );
            END IF;
        END IF;
    END IF;
END;
/

------------------------------------------------------------

-- Si elimino Sucursal en la que trabaja un empleado o más, no deja eliminarla
CREATE OR REPLACE TRIGGER TREliminarSucursalEmpleado
BEFORE DELETE ON Sucursal3
FOR EACH ROW
DECLARE 
    cont NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO cont
    FROM Empleado
    WHERE cod_sucursal = :OLD.cod_sucursal; 
    IF cont > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20210,
            'No se puede eliminar una sucursal en la que trabajan empleados.'
        );
    END IF;
END;
/

------------------------------------------------------------

-- Si existen pedidos o suministros relacionados con una sucursal, no deja eliminarla
CREATE OR REPLACE TRIGGER TREliminarSucursalPedidosSuministros
BEFORE DELETE ON Sucursal3
FOR EACH ROW
DECLARE 
    cont_pedidos NUMBER(3);     
    cont_suministros NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO cont_pedidos
    FROM SucursalPideSuministro         
    WHERE cod_sucursal_solicita = :OLD.cod_sucursal
       OR cod_sucursal_provee = :OLD.cod_sucursal;
    SELECT COUNT(*) INTO cont_suministros
    FROM ClienteSolicitaSuministro         
    WHERE cod_sucursal = :OLD.cod_sucursal;
    IF cont_pedidos > 0 OR cont_suministros > 0 THEN            
        RAISE_APPLICATION_ERROR(                
            -20215,                
            'No se puede eliminar una sucursal con pedidos o suministros relacionados.'            
        );        
    END IF;
END;
/

-- =========================================================
--                  CLIENTE
-- =========================================================

-- PRIMARY KEY Cliente  
CREATE OR REPLACE TRIGGER TRPKCliente
BEFORE INSERT OR UPDATE ON Cliente3
FOR EACH ROW
DECLARE cont NUMBER(3);
BEGIN
    IF INSERTING THEN
        SELECT COUNT(cod_cliente) INTO cont
        FROM Cliente
        WHERE cod_cliente = :NEW.cod_cliente;
        IF cont > 0 THEN
            RAISE_APPLICATION_ERROR(-20025,'Ya existe un cliente con esa clave.');
        END IF;
    END IF;

    IF UPDATING('cod_cliente') THEN
        RAISE_APPLICATION_ERROR(-20030,'No se puede cambiar el código de un cliente.');
    END IF;
END;
/

------------------------------------------------------------

-- 8. Los clientes solamente pueden ser de tipo ‘A’ (supermercados e hipermercados), 
--    ‘B’ (tiendas de alimentación y particulares) o ‘C’ (restaurantes).                    
CREATE OR REPLACE TRIGGER TRTipoCliente
BEFORE INSERT OR UPDATE ON Cliente3
FOR EACH ROW
BEGIN
    IF INSERTING OR UPDATING('tipo_cliente') THEN
        IF :NEW.tipo_cliente NOT IN ('A','B','C') THEN
            RAISE_APPLICATION_ERROR(
                -20125,
                'Los clientes solamente pueden ser de tipo A (supermercados e hipermercados), 
                B (tiendas de alimentación y particulares)
                o C (restaurantes).'
            );
        END IF;
    END IF;
END;
/

-- =========================================================
--                      PRODUCTOR
-- =========================================================

-- PRIMARY KEY Productor    
CREATE OR REPLACE TRIGGER TRPKProductor
BEFORE INSERT OR UPDATE ON Productor
FOR EACH ROW
DECLARE cont NUMBER(3);
BEGIN
    IF INSERTING THEN
        SELECT COUNT(cod_productor) INTO cont
        FROM Productor
        WHERE cod_productor = :NEW.cod_productor;
        IF cont > 0 THEN
            RAISE_APPLICATION_ERROR(-20235,'Ya existe un productor con esa clave.');
        END IF;
    END IF;

    IF UPDATING('cod_productor') THEN
        RAISE_APPLICATION_ERROR(-20240,'No se puede cambiar el código de un productor.');
    END IF;
END;
/

-- 16. Los datos referentes a un productor solamente podrán eliminarse si para cada vino que produce,
--     la cantidad total suministrada es 0 o no existe ningún suministro.

CREATE OR REPLACE TRIGGER TREliminarProductorVinoSuministrado
BEFORE DELETE ON Productor
FOR EACH ROW
DECLARE 
    cantidad_suministrada NUMBER(8);
    cantidad_pedida NUMBER(8);
    cont NUMBER(3);
    CURSOR c_vinos_productor IS 
        SELECT cod_vino 
        FROM Vino 
        WHERE cod_productor = :OLD.cod_productor;
BEGIN
    FOR vino IN c_vinos_productor LOOP
        SELECT COUNT(*) INTO cantidad_suministrada
        FROM ClienteSolicitaSuministro 
        WHERE cod_vino = vino.cod_vino;

        SELECT COUNT(*) INTO cantidad_pedida
        FROM SucursalPideSuministro 
        WHERE cod_vino = vino.cod_vino;

        IF cantidad_suministrada > 0 OR cantidad_pedida > 0 THEN
            RAISE_APPLICATION_ERROR(
                -20270,
                'No se puede eliminar un productor cuyos vinos han sido suministrados.'
            );
        END IF;
    END LOOP;

    -- Si no hay suministros, comprobamos si hay vinos producidos por el productor (ya que no tiene sentido la existencia de un vino sin su productor)
    SELECT COUNT(*) INTO cont
    FROM Vino
    WHERE cod_productor = :OLD.cod_productor;
    IF cont > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20171,
            'No se puede eliminar un productor que tiene vinos asociados.'
        );
    END IF;
END;
/

-- =========================================================    
--                    VINO                  
-- =========================================================

-- PRIMARY KEY Vino
CREATE OR REPLACE TRIGGER TRPKVino
BEFORE INSERT OR UPDATE ON Vino3
FOR EACH ROW
DECLARE cont NUMBER(3);
BEGIN
    IF INSERTING THEN
        SELECT COUNT(cod_vino) INTO cont
        FROM Vino
        WHERE cod_vino = :NEW.cod_vino;
        IF cont > 0 THEN
            RAISE_APPLICATION_ERROR(-20045,'Ya existe un vino con esa clave.');
        END IF;
    END IF;

    IF UPDATING('cod_vino') THEN
        RAISE_APPLICATION_ERROR(-20050,'No se puede cambiar el código de un vino.');
    END IF;
END;
/
------------------------------------------------------------

-- 12. Un vino solamente puede producirlo un productor.                      
CREATE OR REPLACE TRIGGER TRMarcaUnicaProductor
BEFORE INSERT OR UPDATE ON Vino3
FOR EACH ROW
DECLARE 
    cont NUMBER(3);
BEGIN
    IF INSERTING OR UPDATING('marca') THEN
        SELECT COUNT(*) INTO cont
        FROM Vino
        WHERE marca = :NEW.marca 
          AND cod_productor != :NEW.cod_productor;

        IF cont > 0 THEN
            RAISE_APPLICATION_ERROR(
                -20150,
                'Esa marca pertenece a otro productor.'
            );
        END IF;
    END IF;
END;
/

------------------------------------------------------------

-- 13. Un vino no puede existir si no existe un productor que lo produzca.
-- Cod_productor debe ser un productor
-- El código de productor debe corresponder a un productor existente
-- FOREIGN KEY (cod_productor) REFERENCES Productor(cod_productor) en Vino3
CREATE OR REPLACE TRIGGER TRVinoFKProductor
BEFORE INSERT OR UPDATE ON Vino3
FOR EACH ROW
DECLARE 
    cont NUMBER(3);
BEGIN
    IF INSERTING OR UPDATING('cod_productor') THEN
        SELECT COUNT(cod_productor) INTO cont
        FROM Productor
        WHERE cod_productor = :NEW.cod_productor;

        IF cont = 0 THEN
            RAISE_APPLICATION_ERROR(
                -20155,
                'El productor de un vino debe ser un productor existente.'
            );
        END IF;
    END IF;
END;
/

------------------------------------------------------------

-- 14. El stock de un vino nunca puede ser negativo ni mayor que la cantidad producida.
CREATE OR REPLACE TRIGGER TRStockVinoValido
BEFORE INSERT OR UPDATE ON Vino3
FOR EACH ROW
BEGIN
    IF INSERTING OR UPDATING('cantidad_stock') THEN
        IF :NEW.cantidad_stock < 0 
           OR :NEW.cantidad_stock > :NEW.cantidad_producida THEN

            RAISE_APPLICATION_ERROR(
                -20160,
                'El stock de un vino no puede ser negativo ni mayor que la cantidad producida.'
            );
        END IF;
    END IF;
END;
/

------------------------------------------------------------

-- 15. Los datos referentes a un vino solamente podrán eliminarse de la base de datos si la cantidad total suministrada es 0
-- (o nunca ha sido suministrado)
CREATE OR REPLACE TRIGGER TREliminarVinoSuministrado
BEFORE DELETE ON Vino3
FOR EACH ROW
DECLARE 
    cantidad_suministrada NUMBER(8);
    cantidad_pedida NUMBER(8);
BEGIN
    SELECT COUNT(*) INTO cantidad_suministrada
    FROM ClienteSolicitaSuministro 
    WHERE cod_vino = :OLD.cod_vino;

    SELECT COUNT(*) INTO cantidad_pedida
    FROM SucursalPideSuministro 
    WHERE cod_vino = :OLD.cod_vino;

    IF cantidad_suministrada > 0 OR cantidad_pedida > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20165,
            'No se puede eliminar un vino que ha sido suministrado.'
        );
    END IF;
END;
/

-- =========================================================
--      SUCURSAL VENDE VINO
-- =========================================================

-- PRIMARY KEY (cod_sucursal, cod_vino)
CREATE OR REPLACE TRIGGER TRPKSucursalVendeVino
BEFORE INSERT OR UPDATE ON SucursalVendeVino3
FOR EACH ROW
DECLARE cont NUMBER(3);
BEGIN
    IF INSERTING THEN
        SELECT COUNT(*) INTO cont
        FROM SucursalVendeVino
        WHERE cod_sucursal = :NEW.cod_sucursal
          AND cod_vino     = :NEW.cod_vino;
        IF cont > 0 THEN
            RAISE_APPLICATION_ERROR(-20055,'Ya existe esa relación sucursal-vino.');
        END IF;
    END IF;

    IF UPDATING('cod_sucursal') OR UPDATING('cod_vino') THEN
        RAISE_APPLICATION_ERROR(-20060,'No se puede cambiar la clave sucursal-vino.');
    END IF;
END;
/

------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRSucursalVendeVinoMismaDelegacion
BEFORE INSERT OR UPDATE ON SucursalVendeVino3
FOR EACH ROW
DECLARE

    comunidad_autonoma_sucursal  Sucursal.ca_sucursal%TYPE;
    comunidad_autonoma_vino      Vino.ca_vino%TYPE;
    delegacion_sucursal VARCHAR2(50);
    delegacion_vino     VARCHAR2(50);
    contS NUMBER(3);
    contV NUMBER(3);
BEGIN   
    
    --añadidos TR FKs aqui para enseñar bien el error al usuario

    -- FK Sucursal
    IF INSERTING OR UPDATING('cod_sucursal') THEN
        SELECT COUNT(*) INTO contS
        FROM Sucursal
        WHERE cod_sucursal = :NEW.cod_sucursal;
        IF contS = 0 THEN
            RAISE_APPLICATION_ERROR(-20065,'La sucursal debe ser una sucursal existente.');
        END IF;
    END IF;

    -- FK Vino
    IF INSERTING OR UPDATING('cod_vino') THEN
        SELECT COUNT(*) INTO contV
        FROM Vino
        WHERE cod_vino = :NEW.cod_vino;
        IF contV = 0 THEN
            RAISE_APPLICATION_ERROR(-20070,'El vino debe ser un vino existente.');
        END IF;
    END IF;

    SELECT ca_sucursal INTO comunidad_autonoma_sucursal
    FROM Sucursal
    WHERE cod_sucursal = :NEW.cod_sucursal;

    delegacion_sucursal :=
        obtener_delegacion_por_ca(comunidad_autonoma_sucursal);

    SELECT ca_vino INTO comunidad_autonoma_vino
    FROM Vino
    WHERE cod_vino = :NEW.cod_vino;

    delegacion_vino :=
        obtener_delegacion_por_ca(comunidad_autonoma_vino);

    IF delegacion_sucursal != delegacion_vino THEN
        RAISE_APPLICATION_ERROR(
            -20100,
            'Una sucursal solo puede vender vinos de su misma delegación: '
            || delegacion_sucursal || '. Vino pertenece a la delegación: '
            || delegacion_vino || '.'
        );
    END IF;
END;
/

-- =======================================================================
--      CLIENTE SOLICITA SUMINISTRO
-- =======================================================================

CREATE OR REPLACE TRIGGER TRPKClienteSolicitaSuministro
BEFORE INSERT OR UPDATE ON ClienteSolicitaSuministro3
FOR EACH ROW
BEGIN

    IF UPDATING('cod_sucursal')
       OR UPDATING('cod_vino')
       OR UPDATING('cod_cliente')
       OR UPDATING('fecha_suministro') THEN
        RAISE_APPLICATION_ERROR(-20080,'No se puede cambiar la clave de la relación.');
    END IF;
END;
/
------------------------------------------------------------

-- 9. Un cliente puede solicitar a la compañía suministros de cualquier vino, pero siempre
--    tendrá que hacerlo a través de sucursales de la delegación a la que pertenece su comunidad autónoma.
CREATE OR REPLACE TRIGGER TRClienteSolicitaSuministroDelegacionCorrecta
BEFORE INSERT OR UPDATE ON ClienteSolicitaSuministro3
FOR EACH ROW
DECLARE
    comunidad_autonoma_cliente  Cliente.ca_cliente%TYPE;
    comunidad_autonoma_sucursal Sucursal.ca_sucursal%TYPE;
    delegacion_sucursal VARCHAR2(50);
    delegacion_cliente  VARCHAR2(50);
    contC NUMBER(3);
    contS NUMBER(3);
BEGIN

    -- FK CLiente
    IF INSERTING OR UPDATING('cod_cliente') THEN
        SELECT COUNT(*) INTO contC
        FROM Cliente
        WHERE cod_cliente = :NEW.cod_cliente;
        IF contC = 0 THEN
            RAISE_APPLICATION_ERROR(-20085,'El cliente debe ser un cliente existente.');
        END IF;
    END IF;

    -- FK Sucursal
    IF INSERTING OR UPDATING('cod_sucursal') THEN
        SELECT COUNT(*) INTO contS
        FROM Sucursal
        WHERE cod_sucursal = :NEW.cod_sucursal;
        IF contS = 0 THEN
            RAISE_APPLICATION_ERROR(-20090,'La sucursal debe ser una existente.');
        END IF;
    END IF;


    SELECT ca_sucursal INTO comunidad_autonoma_sucursal
    FROM Sucursal
    WHERE cod_sucursal = :NEW.cod_sucursal;

    delegacion_sucursal :=
        obtener_delegacion_por_ca(comunidad_autonoma_sucursal);

    SELECT ca_cliente INTO comunidad_autonoma_cliente
    FROM Cliente
    WHERE cod_cliente = :NEW.cod_cliente;

    delegacion_cliente :=
        obtener_delegacion_por_ca(comunidad_autonoma_cliente);

    IF delegacion_sucursal != delegacion_cliente THEN
        RAISE_APPLICATION_ERROR(
            -20130,
            'Un cliente solo puede solicitar suministros a sucursales de su misma delegación: '
            || delegacion_cliente || '. Sucursal pertenece a la delegación: '
            || delegacion_sucursal || '.'
        );
    END IF;
END;
/

------------------------------------------------------------

-- 10. Para cada cliente, la fecha de un suministro tendrá que ser siempre igual o posterior
--     a la fecha de su último suministro.

CREATE OR REPLACE TRIGGER TRFechaSuministroClientePosterior
BEFORE INSERT OR UPDATE ON ClienteSolicitaSuministro3
FOR EACH ROW
DECLARE fecha_ultimo_suministro DATE;
BEGIN
    IF INSERTING OR UPDATING('fecha_suministro') THEN
        SELECT MAX(fecha_suministro)
        INTO fecha_ultimo_suministro
        FROM ClienteSolicitaSuministro
        WHERE cod_cliente = :NEW.cod_cliente;

        IF fecha_ultimo_suministro IS NOT NULL
           AND :NEW.fecha_suministro < fecha_ultimo_suministro THEN
            RAISE_APPLICATION_ERROR(
                -20135,
                'La fecha de un suministro debe ser igual o posterior a '
                || TO_CHAR(fecha_ultimo_suministro,'DD-MM-YYYY') || '.'
            );
        END IF;
    END IF;
END;
/
------------------------------------------------------------


--- 11. No se puede suministrar un vino que no existe.
CREATE OR REPLACE TRIGGER TRClienteSolicitaSuministroVinoExiste
BEFORE INSERT OR UPDATE ON ClienteSolicitaSuministro3
FOR EACH ROW
DECLARE     
    cont NUMBER(1);

BEGIN
    IF INSERTING OR UPDATING('cod_vino') THEN
        SELECT COUNT(*) INTO cont FROM Vino WHERE cod_vino = :NEW.cod_vino;
        IF cont = 0 THEN
            RAISE_APPLICATION_ERROR(-20140,'No se puede suministrar un vino que no existe.');
        END IF;
    END IF;

END;
/


-- =================================================================
--      SUCURSAL PIDE SUMINISTRO
-- =================================================================  

--  PRIMARY KEY (cod_sucursal_solicita, cod_vino, cod_sucursal_provee, fecha_pedido)
CREATE OR REPLACE TRIGGER TRPKSucursalPideSuministro
BEFORE INSERT OR UPDATE ON SucursalPideSuministro
FOR EACH ROW
BEGIN

    IF UPDATING('cod_sucursal_solicita')
       OR UPDATING('cod_vino')
       OR UPDATING('cod_sucursal_provee')
       OR UPDATING('fecha_pedido') THEN
        RAISE_APPLICATION_ERROR(-20291,'No se puede cambiar la clave de la relación.');
    END IF;
END;
/
------------------------------------------------------------
--TRFK (cod_sucursal_provee, cod_vino) 

-- 12. No se puede solicitar un vino que no existe.

-- 19. La sucursal a la que otra se dirige para hacer pedidos de vinos que ella no distribuye,
--     tiene que suministrar directamente el vino que se solicita.
CREATE OR REPLACE TRIGGER TRSucursalPideVinoASucursalCorrecta
BEFORE INSERT OR UPDATE ON SucursalPideSuministro
FOR EACH ROW
DECLARE 
    comunidad_autonoma_vino Vino.ca_vino%TYPE;
    comunidad_autonoma_proveedora Sucursal.ca_sucursal%TYPE;
    delegacion_vino VARCHAR2(50);
    delegacion_proveedora VARCHAR2(50);
    cont NUMBER(3);
BEGIN
    IF INSERTING OR UPDATING('cod_sucursal_solicita') THEN
        SELECT COUNT(*) INTO cont FROM Sucursal WHERE cod_sucursal = :NEW.cod_sucursal_solicita;
        IF cont = 0 THEN 
            RAISE_APPLICATION_ERROR(-20189,'La sucursal que solicita el pedido debe existir.');
        END IF;
    END IF;
    IF INSERTING OR UPDATING('cod_sucursal_provee') THEN    
        SELECT COUNT(*) INTO cont FROM Sucursal WHERE cod_sucursal = :NEW.cod_sucursal_provee;
        IF cont = 0 THEN 
            RAISE_APPLICATION_ERROR(-20191,'La sucursal que provee el pedido debe existir.');
        END IF;
    END IF;

    IF INSERTING OR UPDATING('cod_vino') THEN
        SELECT COUNT(*) INTO cont FROM Vino WHERE cod_vino = :NEW.cod_vino;
        IF cont = 0 THEN
            RAISE_APPLICATION_ERROR(-20192,'No se puede solicitar un vino que no existe.');
        END IF;
    END IF;

    -- ESTO PODRÍA COMPROBARSE EN LA TABLA SucursalVendeVino, viendo si existe la relación sucursal_provee - cod_vino
    SELECT ca_sucursal INTO comunidad_autonoma_proveedora FROM Sucursal WHERE cod_sucursal = :NEW.cod_sucursal_provee;
    delegacion_proveedora := obtener_delegacion_por_ca(comunidad_autonoma_proveedora);

    SELECT ca_vino INTO comunidad_autonoma_vino FROM Vino WHERE cod_vino = :NEW.cod_vino;
    delegacion_vino := obtener_delegacion_por_ca(comunidad_autonoma_vino);

    IF (delegacion_vino != delegacion_proveedora) THEN
        RAISE_APPLICATION_ERROR(
            -20195,
            'La sucursal a la que se pide el vino debe suministrarlo. Delegación vino: ' || delegacion_vino || '.'
        );
    END IF;
END;
/
------------------------------------------------------------

-- 17. Una sucursal no puede realizar pedidos a sucursales de su misma delegación.  
CREATE OR REPLACE TRIGGER TRSucursalPideSuministroDelegacionCorrecta
BEFORE INSERT OR UPDATE ON SucursalPideSuministro
FOR EACH ROW
DECLARE 
    comunidad_autonoma_solicitante Sucursal.ca_sucursal%TYPE;
    comunidad_autonoma_proveedora Sucursal.ca_sucursal%TYPE;
    delegacion_solicitante VARCHAR2(50);
    delegacion_proveedora VARCHAR2(50);
    cont NUMBER(3);
BEGIN

    IF INSERTING OR UPDATING('cod_sucursal_solicita') THEN
        SELECT COUNT(*) INTO cont FROM Sucursal WHERE cod_sucursal = :NEW.cod_sucursal_solicita;
        IF cont = 0 THEN 
            RAISE_APPLICATION_ERROR(-20372,'La sucursal que solicita el pedido debe existir.');
        END IF;
    END IF;
    IF INSERTING OR UPDATING('cod_sucursal_provee') THEN    
        SELECT COUNT(*) INTO cont FROM Sucursal WHERE cod_sucursal = :NEW.cod_sucursal_provee;
        IF cont = 0 THEN 
            RAISE_APPLICATION_ERROR(-20373,'La sucursal que provee el pedido debe existir.');
        END IF;
    END IF;

    SELECT ca_sucursal INTO comunidad_autonoma_solicitante
    FROM Sucursal 
    WHERE cod_sucursal = :NEW.cod_sucursal_solicita;

    delegacion_solicitante := obtener_delegacion_por_ca(comunidad_autonoma_solicitante);

    SELECT ca_sucursal INTO comunidad_autonoma_proveedora
    FROM Sucursal 
    WHERE cod_sucursal = :NEW.cod_sucursal_provee;

    delegacion_proveedora := obtener_delegacion_por_ca(comunidad_autonoma_proveedora);

    IF (delegacion_solicitante = delegacion_proveedora) THEN
        RAISE_APPLICATION_ERROR(
            -20375,
            'Una sucursal no puede realizar pedidos a sucursales de su misma delegación: ' || delegacion_solicitante || '.'
        );
    END IF;
END;
/

------------------------------------------------------------

-- 18. La cantidad total de cada vino que las sucursales piden a otras sucursales, 
--     no puede exceder la cantidad total que de ese vino solicitan los clientes.
CREATE OR REPLACE TRIGGER TRCantidadPedidoNoExcedeSuministrado
BEFORE INSERT OR UPDATE ON SucursalPideSuministro
FOR EACH ROW
DECLARE 
    cantidad_suministrada NUMBER(8);
    cantidad_pedida NUMBER(8);
    contador NUMBER(3);
BEGIN
    IF INSERTING OR UPDATING THEN
        SELECT COUNT(*) INTO contador
        FROM ClienteSolicitaSuministro 
        WHERE cod_vino = :NEW.cod_vino 
          AND cod_sucursal = :NEW.cod_sucursal_solicita;

        IF contador = 0 THEN
            RAISE_APPLICATION_ERROR(
                -20380,
                'Ningún cliente ha solicitado este vino en esta sucursal.'
            );
        END IF;
        
        SELECT SUM(cantidad_suministro) INTO cantidad_suministrada
        FROM ClienteSolicitaSuministro
        WHERE cod_vino = :NEW.cod_vino 
            AND cod_sucursal = :NEW.cod_sucursal_solicita
        GROUP BY cod_vino, cod_sucursal;

        IF (:NEW.cantidad_pedido > cantidad_suministrada) THEN
            RAISE_APPLICATION_ERROR(
                -20385,
                'La cantidad total pedida de un vino no puede exceder la cantidad total suministrada. ' ||
                'Cantidad suministrada: ' || cantidad_suministrada || 
                '. Cantidad pedida actual: ' || :NEW.cantidad_pedido || '.'
            );
        END IF;
    END IF;
END;
/
------------------------------------------------------------

-- 20. La fecha del pedido de una sucursal S1 a otra S2 de un determinado vino, 
--     tiene que ser posterior a la fecha del último pedido que S1 haya cursado a S2 de ese vino.

CREATE OR REPLACE TRIGGER TRSucursalPideSuministroFechaPosteriorPedido
BEFORE INSERT OR UPDATE ON SucursalPideSuministro
FOR EACH ROW
DECLARE fecha_reciente SucursalPideSuministro.fecha_pedido%TYPE;
BEGIN
    IF INSERTING OR UPDATING('fecha_pedido') THEN
        SELECT MAX(fecha_pedido) INTO fecha_reciente
        FROM SucursalPideSuministro
        WHERE cod_sucursal_solicita = :NEW.cod_sucursal_solicita
          AND cod_sucursal_provee   = :NEW.cod_sucursal_provee
          AND cod_vino               = :NEW.cod_vino;
        IF (fecha_reciente > :NEW.fecha_pedido) THEN
            RAISE_APPLICATION_ERROR(
                -20300,
                'La fecha del pedido de una sucursal S1 a otra S2 de un determinado vino,
                tiene que ser posterior a la fecha del último pedido que S1 haya cursado a S2 de ese vino.'
            );
        END IF;
    END IF;
END;
/
------------------------------------------------------------

-- 21. La fecha de pedido de un vino de una sucursal S1 a otra S2, tiene que ser posterior 
--     a la última fecha de solicitud de suministro de ese mismo vino recibida en S1 por un cliente. 
--     Por ejemplo, si un cliente de Andalucía solicita suministro de vino de Rioja a la sucursal S1 
--     en fecha F, y esa solicitud es la última que S1 ha recibido de vino de Rioja, 
--     el pedido de S1 a la sucursal de la delegación de Madrid correspondiente tiene que ser de fecha posterior a F.

CREATE OR REPLACE TRIGGER TRSucursalPideSuministroFechaPosteriorSuministro
BEFORE INSERT OR UPDATE ON SucursalPideSuministro
FOR EACH ROW
DECLARE fecha_reciente ClienteSolicitaSuministro.fecha_suministro%TYPE;
BEGIN
    IF INSERTING OR UPDATING('fecha_pedido') THEN
        SELECT MAX(fecha_suministro) INTO fecha_reciente
        FROM ClienteSolicitaSuministro --suministros de clientes recibidos en S1
        WHERE cod_sucursal = :NEW.cod_sucursal_solicita
          AND cod_vino = :NEW.cod_vino;
        IF fecha_reciente > :NEW.fecha_pedido THEN
            RAISE_APPLICATION_ERROR(
                -20305,
                'La fecha del pedido de un vino de una sucursal S1 a otra S2, tiene que ser posterior 
                a la última fecha de solicitud de suministro de ese mismo vino recibida en S1 por un cliente.'
            );
        END IF;
    END IF;
END;
/

------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRCantidadPedidoMayorQueCero
BEFORE INSERT OR UPDATE ON SucursalPideSuministro
FOR EACH ROW
BEGIN
    IF INSERTING OR UPDATING('cantidad_pedido') THEN 
        
        IF :NEW.cantidad_pedido <= 0 THEN
            RAISE_APPLICATION_ERROR(
                -20322,
                'La cantidad pedida debe ser mayor que 0.'
            );
        END IF;
    END IF;
END;
/

commit;
