-- Autores: Lucía Cepeda González, Adriana Rubia Alcarria
-- Descripción: Script práctica 5
-- Implementar las siguientes consultas (sin usar procedimientos):

-- 1. Listar los clientes (nombre y dirección) de Andalucía o Castilla-La Mancha y las
--    sucursales (nombre y ciudad), a los que se le ha suministrado vino de marca 
--    “Tablas de Daimiel” entre el 1 de Enero de 2025 y el 1 de septiembre de 2025.

    SELECT c.nombre_cliente, c.direccion_cliente, s.nombre_sucursal, s.ciudad_sucursal
    FROM Cliente c, Sucursal s, ClienteSolicitaSuministro css, Vino v
    WHERE c.cod_cliente = css.cod_cliente
    AND s.cod_sucursal = css.cod_sucursal
    AND css.cod_vino = v.cod_vino
    AND v.marca = 'Tablas de Daimiel'
    AND css.fecha_suministro BETWEEN TO_DATE('2025-01-01', 'YYYY-MM-DD') AND TO_DATE('2025-09-01', 'YYYY-MM-DD')         
    AND (c.ca_cliente = 'Andalucía' OR c.ca_cliente = 'Castilla-La Mancha');
    

-- 2. Dado por teclado el código de un productor: 3
--    Listar la marca, el año de cosecha de cada uno de los vinos producidos por él 
--    y la cantidad total suministrada de cada uno de ellos a clientes de las 
--    comunidades autónomas de Baleares, Extremadura o País Valenciano.
    ACCEPT cod_productor_input NUMBER PROMPT 'Ingrese el código del productor: ';
    SELECT v.marca, v.anio_cosecha, SUM(css.cantidad_suministro) AS cantidad_total_suministrada
    FROM Vino v
    JOIN ClienteSolicitaSuministro css ON v.cod_vino = css.cod_vino
    JOIN Cliente c ON css.cod_cliente = c.cod_cliente
    WHERE v.cod_productor = &cod_productor_input
    AND (c.ca_cliente = 'Baleares' OR c.ca_cliente = 'Extremadura' OR c.ca_cliente = 'País Valenciano')
    GROUP BY v.marca, v.anio_cosecha;

-- 3. Dado por teclado el código de una sucursal: 5
--    Listar el nombre de cada uno de sus clientes, su tipo y la cantidad total de vino 
--    de Rioja o Albariño que se le ha suministrado a cada uno de ellos 
--    (solamente deberán aparecer aquellos clientes a los que se les ha suministrado 
--    vinos con esta denominación de origen).

    ACCEPT cod_sucursal_input NUMBER PROMPT 'Ingrese el código de la sucursal: ';
    SELECT c.nombre_cliente, c.tipo_cliente, SUM(css.cantidad_suministro) AS cantidad_total_suministrada
    FROM Cliente c
    JOIN ClienteSolicitaSuministro css ON c.cod_cliente = css.cod_cliente
    JOIN Vino v ON css.cod_vino = v.cod_vino
    WHERE css.cod_sucursal = &cod_sucursal_input
    AND (v.origen = 'Rioja' OR v.origen = 'Albariño')
    GROUP BY c.nombre_cliente, c.tipo_cliente;