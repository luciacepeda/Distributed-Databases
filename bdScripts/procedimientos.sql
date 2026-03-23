-- Autores: Lucía Cepeda González, Adriana Rubia Alcarria
-- Descripción: Script páctica 4 - implementación de actualizaciones
SET SERVEROUTPUT ON;

-- 1. Dar de alta a un nuevo empleado. 
--    Argumentos: Código de empleado, DNI, nombre, fecha de inicio de contrato, 
--    salario, dirección, y código de la sucursal a la que está asignado.
CREATE OR REPLACE PROCEDURE InsertarEmpleado( cod_emp NUMBER,
                                               dni_emp VARCHAR2,
                                               nom_emp VARCHAR2,                                                                                                                          
                                               fecha_inicio DATE,
                                               dir_emp VARCHAR2,
                                               sal_emp NUMBER,                               
                                               cod_suc NUMBER) IS

comunidad_autonoma_sucursal Sucursal.ca_sucursal%TYPE;
delegacion_sucursal VARCHAR2(50);
cont NUMBER(3);
BEGIN

    SELECT COUNT(*) INTO cont FROM Empleado WHERE cod_empleado = cod_emp;
    IF (cont > 0) THEN
        RAISE_APPLICATION_ERROR(-20400,'El empleado con código ' || cod_emp || ' ya existe en la base de datos.');
    ELSE
        SELECT ca_sucursal INTO comunidad_autonoma_sucursal
        FROM Sucursal
        WHERE cod_sucursal = cod_suc;  

        delegacion_sucursal := obtener_delegacion_por_ca(comunidad_autonoma_sucursal);

        IF (delegacion_sucursal = 'Madrid') THEN 
            INSERT INTO luna1.Empleado1
            VALUES (cod_emp, dni_emp, nom_emp, fecha_inicio,dir_emp, sal_emp, cod_suc);
        ELSIF (delegacion_sucursal = 'Barcelona') THEN
            INSERT INTO luna2.Empleado2
            VALUES (cod_emp, dni_emp, nom_emp, fecha_inicio, dir_emp, sal_emp, cod_suc);
        ELSIF (delegacion_sucursal = 'La Coruña') THEN
            INSERT INTO luna3.Empleado3
            VALUES (cod_emp, dni_emp, nom_emp, fecha_inicio, dir_emp, sal_emp, cod_suc);
        ELSIF (delegacion_sucursal = 'Granada') THEN
            INSERT INTO luna4.Empleado4
            VALUES (cod_emp, dni_emp, nom_emp, fecha_inicio, dir_emp, sal_emp, cod_suc);
        ELSE
            RAISE_APPLICATION_ERROR(-20426,'La sucursal asignada al empleado no pertenece a ninguna delegación.');
        END IF;
        DBMS_OUTPUT.PUT_LINE('El empleado ' || nom_emp ||' fue dado de alta correctamente en la delegación de ' || delegacion_sucursal || '.');
    END IF;
END;
/

----------------------------------------------------------------------------

-- 2. Dar de baja a un empleado. 
--    Argumento: Código de empleado. 
--    Si el empleado que se da de baja es director de alguna sucursal, habrá que realizar 
--    las actualizaciones necesarias para dejar constancia de que ese empleado ya no trabaja en la compañía.

CREATE OR REPLACE PROCEDURE EliminarEmpleado(cod_emp NUMBER) IS

delegacion_empleado VARCHAR2(50);
cont NUMBER(3);
BEGIN
    
    SELECT COUNT(*) INTO cont 
    FROM Empleado
    WHERE cod_empleado = cod_emp;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20401,'El empleado con código ' || cod_emp || ' no existe en la base de datos.');
    ELSE

        -- obtener delegación del empleado
        SELECT obtener_delegacion_por_ca(ca_sucursal)
        INTO delegacion_empleado
        FROM Sucursal S
        JOIN Empleado E ON S.cod_sucursal = E.cod_sucursal
        WHERE E.cod_empleado = cod_emp;

        -- comprobar si es director de alguna sucursal
        SELECT COUNT(*) INTO cont
        FROM Sucursal
        WHERE cod_director = cod_emp;   


        IF (delegacion_empleado = 'Madrid') THEN 
            
            IF (cont > 0) THEN
                UPDATE luna1.Sucursal1
                SET cod_director = NULL
                WHERE cod_director = cod_emp;
            END IF;
            DELETE FROM luna1.Empleado1
            WHERE cod_empleado = cod_emp;

        ELSIF (delegacion_empleado = 'Barcelona') THEN
            
            IF (cont > 0) THEN
                UPDATE luna2.Sucursal2
                SET cod_director = NULL
                WHERE cod_director = cod_emp;
            END IF;
            DELETE FROM luna2.Empleado2
            WHERE cod_empleado = cod_emp;

        ELSIF (delegacion_empleado = 'La Coruña') THEN
            
            IF (cont > 0) THEN
                UPDATE luna3.Sucursal3
                SET cod_director = NULL
                WHERE cod_director = cod_emp;
            END IF;
            DELETE FROM luna3.Empleado3
            WHERE cod_empleado = cod_emp;

        ELSIF (delegacion_empleado = 'Granada') THEN
            
            IF (cont > 0) THEN
                UPDATE luna4.Sucursal4
                SET cod_director = NULL
                WHERE cod_director = cod_emp;
            END IF;
            DELETE FROM luna4.Empleado4
            WHERE cod_empleado = cod_emp;
        ELSE
            RAISE_APPLICATION_ERROR(-20422,'El empleado no pertenece a ninguna delegación.');
        END IF;

        IF (cont > 0 ) THEN 
            DBMS_OUTPUT.PUT_LINE('El empleado con código ' || cod_emp ||' era director de una sucursal, por lo que se ha actualizado la sucursal para dejar el campo de director a nulo.');
        END IF; 
        DBMS_OUTPUT.PUT_LINE('El empleado con código ' || cod_emp ||' fue dado de baja correctamente de la delegación de ' || delegacion_empleado || '.');
    END IF;
END;
/

----------------------------------------------------------------------------

-- 3. Modificar el salario de un empleado. 
--    Argumentos: Código de empleado y nuevo salario.

CREATE OR REPLACE PROCEDURE ModificarSalarioEmpleado(cod_emp NUMBER, nuevo_salario NUMBER) IS

cont NUMBER(3);
delegacion_empleado VARCHAR2(50);

BEGIN
    SELECT COUNT(*) INTO cont 
    FROM Empleado
    WHERE cod_empleado = cod_emp;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20402,'El empleado con código ' || cod_emp || ' no existe en la base de datos.');
    ELSE
        
        SELECT obtener_delegacion_por_ca(ca_sucursal)
        INTO delegacion_empleado
        FROM Sucursal S
        JOIN Empleado E ON S.cod_sucursal = E.cod_sucursal
        WHERE E.cod_empleado = cod_emp;

        IF (delegacion_empleado = 'Madrid') THEN 
            UPDATE luna1.Empleado1
            SET salario = nuevo_salario
            WHERE cod_empleado = cod_emp;
        ELSIF (delegacion_empleado = 'Barcelona') THEN
            UPDATE luna2.Empleado2
            SET salario = nuevo_salario
            WHERE cod_empleado = cod_emp;
        ELSIF (delegacion_empleado = 'La Coruña') THEN
            UPDATE luna3.Empleado3
            SET salario = nuevo_salario
            WHERE cod_empleado = cod_emp;
        ELSIF (delegacion_empleado = 'Granada') THEN
            UPDATE luna4.Empleado4
            SET salario = nuevo_salario
            WHERE cod_empleado = cod_emp;
        ELSE
            RAISE_APPLICATION_ERROR(-20423,'El empleado no pertenece a ninguna delegación.');
        END IF;
    END IF;
    DBMS_OUTPUT.PUT_LINE('El salario del empleado con código ' || cod_emp || ' ha sido modificado a ' || nuevo_salario);
END;
/

----------------------------------------------------------------------------

-- 4. Trasladar de sucursal a un empleado. 
--    Argumentos: Código de empleado, código de la sucursal a la que es trasladado y, opcionalmente, la nueva dirección. 
--    Si este último argumento no se indica, el valor para el atributo correspondiente debe ponerse a nulo. 
--    La fecha de inicio de contrato y el sueldo tendrán los mismos valores.

CREATE OR REPLACE PROCEDURE TrasladarEmpleado( cod_emp NUMBER,
                                               cod_suc NUMBER,
                                               nueva_dir VARCHAR2 DEFAULT NULL) IS
comunidad_autonoma_sucursal Sucursal.ca_sucursal%TYPE;
comunidad_autonoma_nueva_sucursal Sucursal.ca_sucursal%TYPE;
delegacion_sucursal VARCHAR2(50);
delegacion_nueva_sucursal VARCHAR2(50);
dni Empleado.DNI_empleado%TYPE;
nombre Empleado.nombre_empleado%TYPE;
fecha Empleado.fecha_inicio_contrato%TYPE;
salario_emp Empleado.salario%TYPE;

cont NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO cont 
    FROM Empleado
    WHERE cod_empleado = cod_emp;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20403,'El empleado con código ' || cod_emp || ' no existe en la base de datos.');
    END IF; 

    SELECT COUNT(*) INTO cont
    FROM Sucursal
    WHERE cod_sucursal = cod_suc;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20439,'La sucursal con código ' || cod_suc || ' no existe en la base de datos.');
    END IF;

    SELECT ca_sucursal, DNI_empleado, nombre_empleado, fecha_inicio_contrato, salario
    INTO comunidad_autonoma_sucursal, dni, nombre, fecha, salario_emp
    FROM Sucursal S
    JOIN Empleado E ON S.cod_sucursal = E.cod_sucursal
    WHERE E.cod_empleado = cod_emp;

    delegacion_sucursal := obtener_delegacion_por_ca(comunidad_autonoma_sucursal);

    SELECT ca_sucursal INTO comunidad_autonoma_nueva_sucursal
    FROM Sucursal
    WHERE cod_sucursal = cod_suc;   

    delegacion_nueva_sucursal := obtener_delegacion_por_ca(comunidad_autonoma_nueva_sucursal);


    -- Eliminamos empleado 
    
    EliminarEmpleado(cod_emp);
    
    -- Insertamos empleado en nueva sucursal
    IF (delegacion_nueva_sucursal = 'Madrid') THEN 
        INSERT INTO luna1.Empleado1
        VALUES (cod_emp, dni, nombre, fecha, nueva_dir, salario_emp, cod_suc);
    ELSIF (delegacion_nueva_sucursal = 'Barcelona') THEN
        INSERT INTO luna2.Empleado2
        VALUES (cod_emp, dni, nombre, fecha, nueva_dir, salario_emp, cod_suc);
    ELSIF (delegacion_nueva_sucursal = 'La Coruña') THEN
        INSERT INTO luna3.Empleado3
        VALUES (cod_emp, dni, nombre, fecha, nueva_dir, salario_emp, cod_suc);
    ELSIF (delegacion_nueva_sucursal = 'Granada') THEN
        INSERT INTO luna4.Empleado4
        VALUES (cod_emp, dni, nombre, fecha, nueva_dir, salario_emp, cod_suc);  
    ELSE 
        RAISE_APPLICATION_ERROR(-20427,'La sucursal a la que se traslada el empleado no pertenece a ninguna delegación.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('El empleado con código ' || cod_emp || ' ha sido trasladado correctamente a la sucursal ' || cod_suc || ' de la delegación: ' || delegacion_nueva_sucursal || '.');

END;
/   

----------------------------------------------------------------------------

-- 5. Dar de alta una nueva sucursal. 
--    Argumentos: Código de sucursal, nombre, ciudad y comunidad autónoma y, opcionalmente, el código de empleado que va a ser director de la sucursal. 
--    Si este último argumento no se indica, el valor para el correspondiente atributo debe ponerse a nulo.

--actualizar tambien SucursalVendeVino si esta sucursal está en una CA que tenga vinos prducidos ahi.

CREATE OR REPLACE PROCEDURE InsertarSucursal( cod_suc NUMBER,
                                               nom_suc VARCHAR2,
                                               ciudad_suc VARCHAR2,
                                               ca_suc VARCHAR2,
                                               cod_dir NUMBER DEFAULT NULL) IS  
delegacion_sucursal VARCHAR2(50);
cont NUMBER(10);
contVinos NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO cont
    FROM Sucursal
    WHERE cod_sucursal = cod_suc;       
    IF (cont > 0) THEN
        RAISE_APPLICATION_ERROR(-20404,'La sucursal con código ' || cod_suc || ' ya existe en la base de datos.');
    ELSE

        delegacion_sucursal := obtener_delegacion_por_ca(ca_suc);

        IF (delegacion_sucursal = 'Madrid') THEN 
            INSERT INTO luna1.Sucursal1
            VALUES (cod_suc, nom_suc, ciudad_suc, ca_suc, cod_dir);
            FOR vinos IN (SELECT cod_vino FROM luna1.Vino1 WHERE ca_vino = ca_suc) LOOP
                INSERT INTO luna1.SucursalVendeVino1 (cod_sucursal, cod_vino)
                VALUES (cod_suc, vinos.cod_vino);
            END LOOP; --PARA CADA VINO, poner en la tabla que esta sucursal VENDE este vino
        
        ELSIF (delegacion_sucursal = 'Barcelona') THEN
            INSERT INTO luna2.Sucursal2
            VALUES (cod_suc, nom_suc, ciudad_suc, ca_suc, cod_dir);
            FOR vinos IN (SELECT cod_vino FROM luna2.Vino2 WHERE ca_vino = ca_suc) LOOP 
                INSERT INTO luna2.SucursalVendeVino2 (cod_sucursal, cod_vino)
                VALUES (cod_suc, vinos.cod_vino);
            END LOOP;
        ELSIF (delegacion_sucursal = 'La Coruña') THEN
            INSERT INTO luna3.Sucursal3
            VALUES (cod_suc, nom_suc, ciudad_suc, ca_suc, cod_dir);
            FOR vinos IN (SELECT cod_vino FROM luna3.Vino3 WHERE ca_vino = ca_suc) LOOP
                INSERT INTO luna3.SucursalVendeVino3 (cod_sucursal, cod_vino)
                VALUES (cod_suc, vinos.cod_vino);
            END LOOP;
        ELSIF (delegacion_sucursal = 'Granada') THEN
            INSERT INTO luna4.Sucursal4
            VALUES (cod_suc, nom_suc, ciudad_suc, ca_suc, cod_dir);
            FOR vinos IN (SELECT cod_vino FROM luna4.Vino4 WHERE ca_vino = ca_suc) LOOP
                INSERT INTO luna4.SucursalVendeVino4 (cod_sucursal, cod_vino)
                VALUES (cod_suc, vinos.cod_vino);
            END LOOP;
        ELSE
            RAISE_APPLICATION_ERROR(-20428,'La comunidad autónoma asignada a la sucursal no pertenece a ninguna delegación.');
        END IF;
        DBMS_OUTPUT.PUT_LINE('La sucursal ' || nom_suc ||' fue dada de alta correctamente en la delegación de ' || delegacion_sucursal || '.
                Se ha actualizado la tabla de vinos que vende la sucursal si procede.');

    END IF;
END;
/

----------------------------------------------------------------------------

-- 6. Cambiar el director de una sucursal. 
--    Esta operación debe servir también para nombrar director inicial de una sucursal. 
--    Argumentos: Código de sucursal y el código de empleado que será nuevo (o primer) director.

CREATE OR REPLACE PROCEDURE ModificarDirectorSucursal( cod_suc NUMBER,
                                                        cod_emp NUMBER) IS
delegacion_sucursal VARCHAR2(50);
cont NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO cont
    FROM Sucursal
    WHERE cod_sucursal = cod_suc;       
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20405,'La sucursal con código ' || cod_suc || ' no existe en la base de datos.');
    END IF;

    SELECT COUNT(*) INTO cont
    FROM Empleado
    WHERE cod_empleado = cod_emp;       
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20406,'El empleado con código ' || cod_emp || ' no existe en la base de datos.');
    END IF;

    -- pongo esto aquí porque el trigger no me va
    SELECT COUNT(*)
    INTO cont
    FROM Sucursal
    WHERE cod_director = cod_emp
    AND cod_sucursal <> cod_suc;

    IF cont > 0 THEN
        RAISE_APPLICATION_ERROR(-20407,'Este empleado ya dirige otra sucursal.');
    ELSE


        SELECT obtener_delegacion_por_ca(ca_sucursal)
        INTO delegacion_sucursal
        FROM Sucursal
        WHERE cod_sucursal = cod_suc;

        IF (delegacion_sucursal = 'Madrid') THEN 
            UPDATE luna1.Sucursal1
            SET cod_director = cod_emp
            WHERE cod_sucursal = cod_suc;
        ELSIF (delegacion_sucursal = 'Barcelona') THEN
            UPDATE luna2.Sucursal2
            SET cod_director = cod_emp
            WHERE cod_sucursal = cod_suc;
        ELSIF (delegacion_sucursal = 'La Coruña') THEN
            UPDATE luna3.Sucursal3
            SET cod_director = cod_emp
            WHERE cod_sucursal = cod_suc;
        ELSIF (delegacion_sucursal = 'Granada') THEN
            UPDATE luna4.Sucursal4
            SET cod_director = cod_emp
            WHERE cod_sucursal = cod_suc;
        ELSE
            RAISE_APPLICATION_ERROR(-20429,'La sucursal no pertenece a ninguna delegación.');
        END IF;
        DBMS_OUTPUT.PUT_LINE('El empleado con código ' || cod_emp || ' es ahora director de la sucursal con código ' || cod_suc || '.');
    END IF;
END;
/

----------------------------------------------------------------------------
-- 7. Dar de alta a un nuevo cliente. 
--    Argumentos: Código de cliente, DNI (o CIF), nombre, dirección, tipo y comunidad autónoma.

CREATE OR REPLACE PROCEDURE InsertarCliente( cod_cli NUMBER,
                                               dni_cliente VARCHAR2,
                                               nom_cliente VARCHAR2,                                                                                                                          
                                               dir_cliente VARCHAR2,
                                               tipo_cliente CHAR,
                                               ca_cliente VARCHAR2) IS  

delegacion_sucursal VARCHAR2(50);   
cont NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO cont
    FROM Cliente
    WHERE cod_cli = cod_cliente;       
    IF (cont > 0) THEN
        RAISE_APPLICATION_ERROR(-20408,'El cliente con código ' || cod_cli || ' ya existe en la base de datos.');
    ELSE

        delegacion_sucursal := obtener_delegacion_por_ca(ca_cliente);

        IF (delegacion_sucursal = 'Madrid') THEN 
            INSERT INTO luna1.Cliente1
            VALUES (cod_cli, dni_cliente, nom_cliente, dir_cliente, tipo_cliente, ca_cliente);
        ELSIF (delegacion_sucursal = 'Barcelona') THEN
            INSERT INTO luna2.Cliente2
            VALUES (cod_cli, dni_cliente, nom_cliente, dir_cliente, tipo_cliente, ca_cliente);
        ELSIF (delegacion_sucursal = 'La Coruña') THEN
            INSERT INTO luna3.Cliente3
            VALUES (cod_cli, dni_cliente, nom_cliente, dir_cliente, tipo_cliente, ca_cliente);
        ELSIF (delegacion_sucursal = 'Granada') THEN
            INSERT INTO luna4.Cliente4
            VALUES (cod_cli, dni_cliente, nom_cliente, dir_cliente, tipo_cliente, ca_cliente);
        ELSE
            RAISE_APPLICATION_ERROR(-20430,'La comunidad autónoma asignada al cliente no pertenece a ninguna delegación.');
        END IF;
        DBMS_OUTPUT.PUT_LINE('El cliente ' || nom_cliente ||' fue dado de alta correctamente en la delegación de ' || delegacion_sucursal || '.');
    END IF;
END;
/

----------------------------------------------------------------------------

-- 8. Dar de alta o actualizar un suministro. 
--    Argumentos: Código de cliente, código de la sucursal que va a gestionar el suministro, 
--    código de vino a suministrar, fecha de solicitud de suministro y cantidad a suministrar 
--    (puede ser negativa, lo cual significa que se devuelve el suministro). 
--    Si existiera una solicitud de suministro a la misma sucursal, del mismo vino y en la misma fecha, 
--    se actualizaría en la forma adecuada la cantidad a suministrar.

CREATE OR REPLACE PROCEDURE InsertarOActualizarSuministro( ncod_cli NUMBER,  
                                                          ncod_suc NUMBER,
                                                          ncod_v NUMBER,
                                                          nfecha_sum DATE,
                                                          ncantidad_nueva NUMBER) IS
cont NUMBER(3);
cantidad_actual NUMBER(6);
comunidad_autonoma_sucursal Sucursal.ca_sucursal%TYPE;
comunidad_autonoma_vino Vino.ca_vino%TYPE;
delegacion_vino VARCHAR2(50);   
delegacion_sucursal VARCHAR2(50);
BEGIN

    SELECT COUNT(*) INTO cont 
    FROM Sucursal
    WHERE cod_sucursal = ncod_suc;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20409,'La sucursal con código ' || ncod_suc || ' no existe en la base de datos.');
    END IF;

    SELECT COUNT(*) INTO cont
    FROM Cliente
    WHERE cod_cliente = ncod_cli;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20410,'El cliente con código ' || ncod_cli
        || ' no existe en la base de datos.');
    END IF; 

    SELECT COUNT(*) INTO cont
    FROM Vino
    WHERE cod_vino = ncod_v;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20411,'El vino con código ' || ncod_v
        || ' no existe en la base de datos.');      
    END IF; 

      -- COMPROBAMOS QUE NO EXISTE OTRO PEDIDO IGUAL

    SELECT COUNT(*), NVL(MAX(cantidad_suministro), 0)
    INTO cont, cantidad_actual
    FROM ClienteSolicitaSuministro
    WHERE cod_cliente = ncod_cli
    AND cod_sucursal = ncod_suc
    AND cod_vino = ncod_v
    AND fecha_suministro = nfecha_sum;


    -- ajustar stock del vino
    select ca_vino INTO comunidad_autonoma_vino 
        FROM Vino WHERE cod_vino = ncod_v;

    -- si cantidad es positiva, resta y si es negativa, suma
    delegacion_vino :=  obtener_delegacion_por_ca(comunidad_autonoma_vino);
    IF (delegacion_vino = 'Madrid') THEN 
        UPDATE luna1.Vino1
        SET cantidad_stock = cantidad_stock - ncantidad_nueva
        WHERE cod_vino = ncod_v;
    ELSIF (delegacion_vino = 'Barcelona') THEN
        UPDATE luna2.Vino2
        SET cantidad_stock = cantidad_stock - ncantidad_nueva
        WHERE cod_vino = ncod_v;
    ELSIF (delegacion_vino = 'La Coruña') THEN
        UPDATE luna3.Vino3
        SET cantidad_stock = cantidad_stock - ncantidad_nueva
        WHERE cod_vino = ncod_v;
    ELSIF (delegacion_vino = 'Granada') THEN
        UPDATE luna4.Vino4
        SET cantidad_stock = cantidad_stock - ncantidad_nueva
        WHERE cod_vino = ncod_v;
    ELSE
        RAISE_APPLICATION_ERROR(-20412,'La comunidad autónoma asignada al vino no pertenece a ninguna delegación.');
    END IF;    

    -- obtener delegación de la sucursal
    SELECT ca_sucursal INTO comunidad_autonoma_sucursal FROM Sucursal WHERE cod_sucursal = ncod_suc;
    delegacion_sucursal := obtener_delegacion_por_ca(comunidad_autonoma_sucursal);


    -- existía ese suministro
    IF (cont >0) THEN 

    
        -- actualizar suministro existente
        IF (delegacion_sucursal = 'Madrid') THEN 
            UPDATE luna1.ClienteSolicitaSuministro1
            SET cantidad_suministro = cantidad_actual + ncantidad_nueva
            WHERE cod_cliente = ncod_cli
            AND cod_sucursal = ncod_suc
            AND cod_vino = ncod_v
            AND fecha_suministro = nfecha_sum;

        ELSIF (delegacion_sucursal = 'Barcelona') THEN
            UPDATE luna2.ClienteSolicitaSuministro2
            SET cantidad_suministro = cantidad_actual + ncantidad_nueva
            WHERE cod_cliente = ncod_cli
            AND cod_sucursal = ncod_suc
            AND cod_vino = ncod_v
            AND fecha_suministro = nfecha_sum;
        ELSIF (delegacion_sucursal = 'La Coruña') THEN
            UPDATE luna3.ClienteSolicitaSuministro3
            SET cantidad_suministro = cantidad_actual + ncantidad_nueva
            WHERE cod_cliente = ncod_cli
            AND cod_sucursal = ncod_suc
            AND cod_vino = ncod_v
            AND fecha_suministro = nfecha_sum;
        ELSIF (delegacion_sucursal = 'Granada') THEN
            UPDATE luna4.ClienteSolicitaSuministro4
            SET cantidad_suministro = cantidad_actual + ncantidad_nueva
            WHERE cod_cliente = ncod_cli
            AND cod_sucursal = ncod_suc
            AND cod_vino = ncod_v
            AND fecha_suministro = nfecha_sum;
        ELSE
            RAISE_APPLICATION_ERROR(-20413,'La sucursal no pertenece a ninguna delegación.');
        END IF;
        DBMS_OUTPUT.PUT_LINE('El suministro ha sido actualizado correctamente. 
                            El stock del vino ha sido actualizado.');

    ELSE -- no existia sum

        -- insertar nuevo suministro
        IF (delegacion_sucursal = 'Madrid') THEN 
            INSERT INTO luna1.ClienteSolicitaSuministro1
            VALUES (ncod_cli, ncod_suc, ncod_v, nfecha_sum, ncantidad_nueva);
        ELSIF (delegacion_sucursal = 'Barcelona') THEN
            INSERT INTO luna2.ClienteSolicitaSuministro2
            VALUES (ncod_cli, ncod_suc, ncod_v, nfecha_sum, ncantidad_nueva);
        ELSIF (delegacion_sucursal = 'La Coruña') THEN
            INSERT INTO luna3.ClienteSolicitaSuministro3
            VALUES (ncod_cli, ncod_suc, ncod_v, nfecha_sum, ncantidad_nueva);
        ELSIF (delegacion_sucursal = 'Granada') THEN
            INSERT INTO luna4.ClienteSolicitaSuministro4
            VALUES (ncod_cli, ncod_suc, ncod_v, nfecha_sum, ncantidad_nueva);
        ELSE
            RAISE_APPLICATION_ERROR(-20414,'La sucursal no pertenece a ninguna delegación.');
        END IF;
        DBMS_OUTPUT.PUT_LINE('El suministro ha sido insertado correctamente. 
                            El stock del vino ha sido actualizado.');
    END IF;

    IF (delegacion_sucursal != delegacion_vino) THEN
    DBMS_OUTPUT.PUT_LINE('Advertencia: La sucursal y el vino pertenecen a delegaciones diferentes.
                            Hay que pedir la cantidad a otra Sucursal que suministre el vino.');
    END IF;
END;    
/

----------------------------------------------------------------------------

-- 9. Dar de baja suministros. 
--    Argumentos: Código de cliente, código de la sucursal que gestionó el suministro, 
--    código del vino que se suministró y, opcionalmente, fecha del suministro. 
--    Si este último argumento no se indica, se eliminarán todos los suministros de ese vino proporcionados 
--    por la sucursal al cliente en cualquier fecha.

CREATE OR REPLACE PROCEDURE EliminarSuministro (ncod_cliente NUMBER,  
                                                ncod_sucursal NUMBER,
                                                ncod_vino NUMBER,
                                                nfecha_suministro DATE) IS
cont NUMBER(5);
comunidad_autonoma_sucursal Sucursal.ca_sucursal%TYPE;
delegacion_sucursal VARCHAR2(50);

BEGIN
    SELECT COUNT(*) INTO cont 
    FROM ClienteSolicitaSuministro 
    WHERE cod_vino = ncod_vino 
    AND cod_cliente = ncod_cliente 
    AND cod_sucursal = ncod_sucursal;

    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20415, 'El suministro no existe.');
    ELSE
    
        -- obtener delegación de la sucursal
        SELECT ca_sucursal INTO comunidad_autonoma_sucursal FROM Sucursal WHERE cod_sucursal = ncod_sucursal;
        delegacion_sucursal := obtener_delegacion_por_ca(comunidad_autonoma_sucursal);

        IF (nfecha_suministro IS NULL) THEN
              --eliminar todos los suministros de ese vino proporcionados por la sucursal al cliente en cualquier fecha
       
            IF (delegacion_sucursal = 'Madrid') THEN 
                DELETE FROM luna1.ClienteSolicitaSuministro1
                WHERE cod_cliente = ncod_cliente
                AND cod_sucursal = ncod_sucursal
                AND cod_vino = ncod_vino;
            ELSIF (delegacion_sucursal = 'Barcelona') THEN
                DELETE FROM luna2.ClienteSolicitaSuministro2
                WHERE cod_cliente = ncod_cliente
                AND cod_sucursal = ncod_sucursal
                AND cod_vino = ncod_vino;
            ELSIF (delegacion_sucursal = 'La Coruña') THEN
                DELETE FROM luna3.ClienteSolicitaSuministro3
                WHERE cod_cliente = ncod_cliente
                AND cod_sucursal = ncod_sucursal
                AND cod_vino = ncod_vino;
            ELSIF (delegacion_sucursal = 'Granada') THEN
                DELETE FROM luna4.ClienteSolicitaSuministro4
                WHERE cod_cliente = ncod_cliente
                AND cod_sucursal = ncod_sucursal
                AND cod_vino = ncod_vino;
            ELSE
                RAISE_APPLICATION_ERROR(-20416,'La sucursal no pertenece a ninguna delegación.');
            END IF;
            

            DBMS_OUTPUT.PUT_LINE('Todos los suministros del vino ' || ncod_vino ||' por parte de la sucursal ' 
                || ncod_sucursal || ' al cliente ' || ncod_cliente || ' han sido eliminados correctamente.');

        ELSIF (nfecha_suministro IS NOT NULL) THEN
            --eliminar el suministro de ese vino en esa fecha
        
            IF (delegacion_sucursal = 'Madrid') THEN 
                DELETE FROM luna1.ClienteSolicitaSuministro1
                WHERE cod_cliente = ncod_cliente
                AND cod_sucursal = ncod_sucursal
                AND cod_vino = ncod_vino
                AND fecha_suministro = nfecha_suministro;
            ELSIF (delegacion_sucursal = 'Barcelona') THEN
                DELETE FROM luna2.ClienteSolicitaSuministro2
                WHERE cod_cliente = ncod_cliente
                AND cod_sucursal = ncod_sucursal
                AND cod_vino = ncod_vino
                AND fecha_suministro = nfecha_suministro;
            ELSIF (delegacion_sucursal = 'La Coruña') THEN
                DELETE FROM luna3.ClienteSolicitaSuministro3
                WHERE cod_cliente = ncod_cliente
                AND cod_sucursal = ncod_sucursal
                AND cod_vino = ncod_vino
                AND fecha_suministro = nfecha_suministro;
            ELSIF (delegacion_sucursal = 'Granada') THEN
                DELETE FROM luna4.ClienteSolicitaSuministro4
                WHERE cod_cliente = ncod_cliente
                AND cod_sucursal = ncod_sucursal
                AND cod_vino = ncod_vino
                AND fecha_suministro = nfecha_suministro;
            ELSE
                RAISE_APPLICATION_ERROR(-20416,'La sucursal no pertenece a ninguna delegación.');
            END IF;
        
             DBMS_OUTPUT.PUT_LINE('El suministro del vino ' || ncod_vino ||' por parte de la sucursal ' 
                || ncod_sucursal || ' al cliente ' || ncod_cliente || ' en la fecha ' || nfecha_suministro || 
                ' ha sido eliminado correctamente.');     
        END IF; 
    END IF;
END;
/

----------------------------------------------------------------------------

-- 10. Dar de alta un pedido de una sucursal. 
--     Argumentos: Código de la sucursal que realiza el pedido, código de la sucursal que recibe el pedido, 
--     código de vino, fecha de pedido, y cantidad pedida.

CREATE OR REPLACE PROCEDURE InsertarPedido( ncod_suc_solicita NUMBER, 
                                               ncod_suc_provee NUMBER,                                                                                                                          
                                               ncod_vino NUMBER,
                                               nfecha_pedido DATE,
                                               ncantidad_pedido NUMBER) IS
cont NUMBER(3);
comunidad_autonoma_sucursal Sucursal.ca_sucursal%TYPE;
delegacion_sucursal VARCHAR2(50);
comunidad_autonoma_vino Vino.ca_vino%TYPE;
delegacion_vino VARCHAR2(50);
comunidad_autonoma_sucursal_provee Sucursal.ca_sucursal%TYPE;
delegacion_sucursal_provee VARCHAR2(50);

BEGIN
    --REPLICACIÓN EN LAS 4 

    SELECT COUNT(*) INTO cont 
    FROM Sucursal
    WHERE cod_sucursal = ncod_suc_solicita;
    IF (cont = 0) THEN  
        RAISE_APPLICATION_ERROR(-20417,'La sucursal que realiza el pedido con código ' || ncod_suc_solicita || ' no existe en la base de datos.');
    END IF; 
    SELECT COUNT(*) INTO cont
    FROM Sucursal
    WHERE cod_sucursal = ncod_suc_provee;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20418,'La sucursal que recibe el pedido con código ' || ncod_suc_provee || ' no existe en la base de datos.');
    END IF; 
    SELECT COUNT(*) INTO cont
    FROM Vino       
    WHERE cod_vino = ncod_vino;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20419,'El vino con código ' || ncod_vino
        || ' no existe en la base de datos.');    
    END IF; 

    -- comprobamos si existen ya pedidos iguales
    SELECT COUNT(*) INTO cont
    FROM SucursalPideSuministro
    WHERE cod_sucursal_solicita = ncod_suc_solicita
    AND cod_sucursal_provee = ncod_suc_provee
    AND cod_vino = ncod_vino
    AND fecha_pedido = nfecha_pedido;   

    IF (cont > 0) THEN
        -- sumamos cantidades
        UPDATE luna1.SucursalPideSuministro
        SET cantidad_pedido = cantidad_pedido + ncantidad_pedido
        WHERE cod_sucursal_solicita = ncod_suc_solicita
        AND cod_sucursal_provee = ncod_suc_provee
        AND cod_vino = ncod_vino
        AND fecha_pedido = nfecha_pedido;

        UPDATE luna2.SucursalPideSuministro
        SET cantidad_pedido = cantidad_pedido + ncantidad_pedido
        WHERE cod_sucursal_solicita = ncod_suc_solicita
        AND cod_sucursal_provee = ncod_suc_provee
        AND cod_vino = ncod_vino
        AND fecha_pedido = nfecha_pedido;

        UPDATE luna3.SucursalPideSuministro
        SET cantidad_pedido = cantidad_pedido + ncantidad_pedido
        WHERE cod_sucursal_solicita = ncod_suc_solicita
        AND cod_sucursal_provee = ncod_suc_provee
        AND cod_vino = ncod_vino
        AND fecha_pedido = nfecha_pedido;

        UPDATE luna4.SucursalPideSuministro
        SET cantidad_pedido = cantidad_pedido + ncantidad_pedido
        WHERE cod_sucursal_solicita = ncod_suc_solicita
        AND cod_sucursal_provee = ncod_suc_provee
        AND cod_vino = ncod_vino
        AND fecha_pedido = nfecha_pedido;
        DBMS_OUTPUT.PUT_LINE('El pedido ya existía y ha sido actualizado correctamente.');

    ELSE
        -- insertar nuevo pedido
        INSERT INTO luna1.SucursalPideSuministro
        VALUES (ncod_suc_solicita, ncod_suc_provee, ncod_vino, nfecha_pedido, ncantidad_pedido);
        INSERT INTO luna2.SucursalPideSuministro
        VALUES (ncod_suc_solicita, ncod_suc_provee, ncod_vino, nfecha_pedido, ncantidad_pedido);
        INSERT INTO luna3.SucursalPideSuministro
        VALUES (ncod_suc_solicita, ncod_suc_provee, ncod_vino, nfecha_pedido, ncantidad_pedido);
        INSERT INTO luna4.SucursalPideSuministro
        VALUES (ncod_suc_solicita, ncod_suc_provee, ncod_vino, nfecha_pedido, ncantidad_pedido);
        
        DBMS_OUTPUT.PUT_LINE('El pedido ha sido realizado correctamente.');

    END IF;
END;
/
----------------------------------------------------------------------------

-- 11. Dar de baja pedidos de una sucursal. 
--     Argumentos: Código de la sucursal que realizó el pedido, código de la sucursal que recibió el pedido, 
--     código del vino que se solicitó y, opcionalmente, fecha del pedido. 
--     Si este último argumento no se indica, se eliminarán todos los pedidos de ese vino solicitados 
--     por la sucursal a la otra sucursal.


CREATE OR REPLACE PROCEDURE EliminarPedido (cod_suc_solicita NUMBER, --SucursalPideSuministro
                                            cod_suc_provee NUMBER,
                                            cod_vino NUMBER,
                                            fecha_pedido DATE) IS
cont NUMBER(5);
BEGIN
    SELECT COUNT(*) INTO cont FROM SucursalPideSuministro WHERE cod_vino = cod_vino 
    AND cod_sucursal_solicita = cod_suc_solicita AND cod_sucursal_provee = cod_suc_provee;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20420, 'El pedido no existe.');
    ELSIF (fecha_pedido IS NULL) THEN
    --eliminar todos los pedidos de ese vino solicitados por la sucursal a la otra sucursal
        DELETE FROM luna1.SucursalPideSuministro
        WHERE cod_sucursal_solicita = cod_suc_solicita
        AND cod_sucursal_provee = cod_suc_provee
        AND cod_vino = cod_vino;
        
        DELETE FROM luna2.SucursalPideSuministro
        WHERE cod_sucursal_solicita = cod_suc_solicita
        AND cod_sucursal_provee = cod_suc_provee
        AND cod_vino = cod_vino;
        
        DELETE FROM luna3.SucursalPideSuministro
        WHERE cod_sucursal_solicita = cod_suc_solicita
        AND cod_sucursal_provee = cod_suc_provee
        AND cod_vino = cod_vino;
        
        DELETE FROM luna4.SucursalPideSuministro
        WHERE cod_sucursal_solicita = cod_suc_solicita
        AND cod_sucursal_provee = cod_suc_provee
        AND cod_vino = cod_vino;
        DBMS_OUTPUT.PUT_LINE('Todos los pedidos entre esas sucursales han sido eliminados correctamente.');
   
    ELSIF (fecha_pedido IS NOT NULL) THEN
    --eliminar el pedido de ese vino en esa fecha
        -- comprobamos si existe ese pedido en esa fecha
        SELECT COUNT(*) INTO cont
        FROM SucursalPideSuministro
        WHERE cod_sucursal_solicita = cod_suc_solicita
        AND cod_sucursal_provee = cod_suc_provee
        AND cod_vino = cod_vino
        AND fecha_pedido = fecha_pedido;
        IF (cont = 0) THEN
            RAISE_APPLICATION_ERROR(-20421, 'El pedido en esa fecha no existe.');
        END IF;

        DELETE FROM luna1.SucursalPideSuministro
        WHERE cod_sucursal_solicita = cod_suc_solicita
        AND cod_sucursal_provee = cod_suc_provee
        AND cod_vino = cod_vino
        AND fecha_pedido = fecha_pedido;
        
        DELETE FROM luna2.SucursalPideSuministro
        WHERE cod_sucursal_solicita = cod_suc_solicita
        AND cod_sucursal_provee = cod_suc_provee
        AND cod_vino = cod_vino
        AND fecha_pedido = fecha_pedido;
        
        DELETE FROM luna3.SucursalPideSuministro
        WHERE cod_sucursal_solicita = cod_suc_solicita
        AND cod_sucursal_provee = cod_suc_provee
        AND cod_vino = cod_vino
        AND fecha_pedido = fecha_pedido;
        
        DELETE FROM luna4.SucursalPideSuministro
        WHERE cod_sucursal_solicita = cod_suc_solicita
        AND cod_sucursal_provee = cod_suc_provee
        AND cod_vino = cod_vino
        AND fecha_pedido = fecha_pedido;
        DBMS_OUTPUT.PUT_LINE('El pedido en la fecha ' || fecha_pedido || ' ha sido eliminado correctamente.');
    END IF; 
END;
/


-- 12. Dar de alta un nuevo vino. 
--     Argumentos: Código de vino, marca, año de cosecha, denominación de origen (si la tiene), 
--     graduación, viñedo de procedencia, comunidad autónoma, cantidad producida y código de productor. 
--     Será necesario también almacenar el stock (inicialmente es la cantidad producida).

--actualizar tambien SucursalVendeVino si este vino está en una CA que tenga sucursales ahí que lo vayan a vender.
CREATE OR REPLACE PROCEDURE InsertarVino( cod_vino NUMBER,
                                               marca VARCHAR2,
                                               anio_cosecha NUMBER,                                                                                                                          
                                               origen VARCHAR2,
                                               graduacion NUMBER,
                                               procedencia VARCHAR2,
                                               ca_vino VARCHAR2,
                                               cantidad_producida NUMBER,
                                               cod_productor NUMBER) IS
delegacion_sucursal VARCHAR2(50);

BEGIN
    delegacion_sucursal := obtener_delegacion_por_ca(ca_vino);


    IF (delegacion_sucursal = 'Madrid') THEN 
        INSERT INTO luna1.Vino1
        VALUES (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cod_productor, cantidad_producida, ca_vino);
        
        -- actualizar SucursalVendeVino si es necesario
        FOR sucursales IN (SELECT cod_sucursal FROM luna1.Sucursal1 WHERE ca_sucursal = ca_vino) LOOP
            INSERT INTO luna1.SucursalVendeVino1 (cod_sucursal, cod_vino)
            VALUES (sucursales.cod_sucursal, cod_vino);
        END LOOP; --PARA CADA SUC en la ca, poner en la tabla que este vino SE VENDE en esa sucursal
        
    ELSIF (delegacion_sucursal = 'Barcelona') THEN
        INSERT INTO luna2.Vino2
        VALUES (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cod_productor, cantidad_producida, ca_vino);
        FOR sucursales IN (SELECT cod_sucursal FROM luna2.Sucursal2 WHERE ca_sucursal = ca_vino) LOOP
                INSERT INTO luna2.SucursalVendeVino2 (cod_sucursal, cod_vino)
                VALUES (sucursales.cod_sucursal, cod_vino);
        END LOOP; 
    ELSIF (delegacion_sucursal = 'La Coruña') THEN
        INSERT INTO luna3.Vino3
        VALUES (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cod_productor, cantidad_producida, ca_vino);
        FOR sucursales IN (SELECT cod_sucursal FROM luna3.Sucursal3 WHERE ca_sucursal = ca_vino) LOOP
            INSERT INTO luna3.SucursalVendeVino3 (cod_sucursal, cod_vino)
            VALUES (sucursales.cod_sucursal, cod_vino);
        END LOOP;
    ELSIF (delegacion_sucursal = 'Granada') THEN
        INSERT INTO luna4.Vino4
        VALUES (cod_vino, marca, anio_cosecha, origen, graduacion, procedencia, cantidad_producida, cod_productor, cantidad_producida, ca_vino);
        FOR sucursales IN (SELECT cod_sucursal FROM luna4.Sucursal4 WHERE ca_sucursal = ca_vino) LOOP
            INSERT INTO luna4.SucursalVendeVino4 (cod_sucursal, cod_vino)
            VALUES (sucursales.cod_sucursal, cod_vino);
        END LOOP;
    ELSE
        RAISE_APPLICATION_ERROR(-20422,'La comunidad autónoma asignada al vino no pertenece a ninguna delegación.');
    END IF;


    DBMS_OUTPUT.PUT_LINE('El vino ' || cod_vino ||' fue dado de alta correctamente en la delegación de ' || delegacion_sucursal || '.
        Se han actualizado las sucursales que venden este vino si procede. ');

END;
/

----------------------------------------------------------------------------

-- 13. Dar de baja un vino. 
--     Argumento: Código de vino.
CREATE OR REPLACE PROCEDURE EliminarVino (cod_v NUMBER) IS

    cont NUMBER(3);
    comunidad_autonoma_vino Vino.ca_vino%TYPE;
    delegacion_vino VARCHAR2(50);

BEGIN
    SELECT COUNT(*) INTO cont FROM Vino WHERE cod_vino = cod_v;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20423, 'El vino no existe.');
    ELSE 


    SELECT ca_vino INTO comunidad_autonoma_vino 
    FROM Vino 
    WHERE cod_vino = cod_v;

    delegacion_vino:= obtener_delegacion_por_ca(comunidad_autonoma_vino);

    SELECT COUNT(*) INTO cont
    FROM SucursalPideSuministro
    WHERE cod_vino = cod_v;
    IF (cont > 0) THEN
        DELETE FROM luna1.SucursalPideSuministro WHERE cod_vino = cod_v;
        DELETE FROM luna2.SucursalPideSuministro WHERE cod_vino = cod_v;
        DELETE FROM luna3.SucursalPideSuministro WHERE cod_vino = cod_v;
        DELETE FROM luna4.SucursalPideSuministro WHERE cod_vino = cod_v;
    END IF;

    SELECT COUNT(*) INTO cont
    FROM ClienteSolicitaSuministro
    WHERE cod_vino = cod_v;
    IF (cont > 0) THEN
        DELETE FROM luna1.ClienteSolicitaSuministro1 WHERE cod_vino = cod_v;
        DELETE FROM luna2.ClienteSolicitaSuministro2 WHERE cod_vino = cod_v;
        DELETE FROM luna3.ClienteSolicitaSuministro3 WHERE cod_vino = cod_v;
        DELETE FROM luna4.ClienteSolicitaSuministro4 WHERE cod_vino = cod_v;
    END IF;

    IF (delegacion_vino = 'Madrid') THEN 
        DELETE FROM luna1.SucursalVendeVino1 WHERE cod_vino = cod_v;
        DELETE FROM luna1.Vino1 WHERE cod_vino = cod_v;
    ELSIF (delegacion_vino = 'Barcelona') THEN
        DELETE FROM luna2.SucursalVendeVino2 WHERE cod_vino = cod_v;
        DELETE FROM luna2.Vino2 WHERE cod_vino = cod_v;
    ELSIF (delegacion_vino = 'La Coruña') THEN
        DELETE FROM luna3.SucursalVendeVino3 WHERE cod_vino = cod_v;
        DELETE FROM luna3.Vino3 WHERE cod_vino = cod_v;
    ELSIF (delegacion_vino = 'Granada') THEN
        DELETE FROM luna4.SucursalVendeVino4 WHERE cod_vino = cod_v;
        DELETE FROM luna4.Vino4 WHERE cod_vino = cod_v;
    ELSE
        RAISE_APPLICATION_ERROR(-20424,'La comunidad autónoma asignada al vino no pertenece a ninguna delegación.');
    END IF;
        
        DBMS_OUTPUT.PUT_LINE('El vino ' || cod_v ||' ha sido dado de baja correctamente. Se han eliminado las relaciones pertinentes.');
    END IF;
END;
/

----------------------------------------------------------------------------
   
-- 14. Dar de alta un productor. 
--     Argumentos: Código de productor, DNI (o CIF), nombre, y dirección.

CREATE OR REPLACE PROCEDURE InsertarProductor( cod_prod NUMBER,  
                                            DNI VARCHAR2,
                                            nuevo_nombre VARCHAR2,
                                            nueva_dir VARCHAR2) IS

BEGIN
    INSERT INTO luna1.Productor
    VALUES (cod_prod, DNI, nuevo_nombre, nueva_dir);
    INSERT INTO luna2.Productor
    VALUES (cod_prod, DNI, nuevo_nombre, nueva_dir);
    INSERT INTO luna3.Productor
    VALUES (cod_prod, DNI, nuevo_nombre, nueva_dir);
    INSERT INTO luna4.Productor
    VALUES (cod_prod, DNI, nuevo_nombre, nueva_dir);
    DBMS_OUTPUT.PUT_LINE('El productor ' || nuevo_nombre ||' fue dado de alta correctamente.');

END;
/

----------------------------------------------------------------------------

-- 15. Dar de baja un productor. 
--     Argumento: Código de productor.
   
CREATE OR REPLACE PROCEDURE EliminarProductor (cod_prod NUMBER) IS

    cont NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO cont FROM Productor WHERE cod_productor = cod_prod;
    IF (cont = 0) THEN
        RAISE_APPLICATION_ERROR(-20425, 'El productor no existe.');
    ELSE 
        DELETE FROM luna1.Productor WHERE cod_productor = cod_prod;
        DELETE FROM luna2.Productor WHERE cod_productor = cod_prod;
        DELETE FROM luna3.Productor WHERE cod_productor = cod_prod;
        DELETE FROM luna4.Productor WHERE cod_productor = cod_prod;
        DBMS_OUTPUT.PUT_LINE('El productor ' || cod_prod ||' ha sido dado de baja correctamente.');
    END IF;
END;
/

COMMIT;
