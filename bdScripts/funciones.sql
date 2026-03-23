-- Autores: Lucía Cepeda González
-- Descripción: Script función auxiliar 

-- Eliminar funcion
DROP FUNCTION obtener_delegacion_por_ca;

-- Crear función auxiliar para obtener delegación
CREATE OR REPLACE FUNCTION obtener_delegacion_por_ca
(ca IN VARCHAR2) 
RETURN VARCHAR2 IS
BEGIN
  IF ca IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN
    RETURN 'Madrid';
  ELSIF ca IN ('Cataluña','Baleares','País Valenciano','Murcia') THEN
    RETURN 'Barcelona';
  ELSIF ca IN ('Galicia','Asturias','Cantabria','País Vasco','Navarra') THEN
    RETURN 'La Coruña';
  ELSIF ca IN ('Canarias','Andalucía','Extremadura','Melilla','Ceuta') THEN
    RETURN 'Granada';
  ELSE
    RAISE_APPLICATION_ERROR(-20099,'La comunidad autónoma no pertenece a ninguna delegación');
  END IF;
END;
/
COMMIT;

-- compila y funciona bien

