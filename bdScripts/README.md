# Orden de ficheros a compilar

## 📝 Descripción
_BDD Distribuidora de Vinos_

---

## Pasos

1. Crear Tablas Luna1,2,.. en cada BD
2. Crear Vistas Luna1,2,.. en cada BD
3. Funciones Luna1,2,.. en cada BD
4. Triggers Luna1,2,.. en cada BD
5. Procedimientos Luna1,2,.. en cada BD
6. Insertar Datos (desde una bd)
7. Ejecutar consultas (en cualquiera)


---

## 📌  Observaciones importantes por comprobar
      (marcar la casilla [x] con una x cuando estén completadas)
              
- [x] Compilan triggers
- [ ] Funcionan triggers
<img width="851" height="269" alt="image" src="https://github.com/user-attachments/assets/ae397547-ad34-4e1c-93cb-f6b3cd0ac022" />
--falta 1 de los triggers
  
- [ ] Copiar fichero trigger con modificaciones para que funcione en luna2, luna3...
- 
- [x] Compilan procedimientos
- [ ] Funcionan procedimientos

- [X] Como se gestiona SucursalVendeVino:
  - cuando se insertan datos en ella? deberíamos insertar en SucursalVendeVino datos cuando se inserte un vino o
    una sucursal? De modo que busque los vinos/sucursales de la misma delegación y los incluya? -> A: Sí  (Por hacer)
  - SucursalPideSuministro debería referenciar a SucursalVendeVino? -> A: Sí (hecho)
  - [X] Cambiar procedimientos para insertar datos en SucursalVendeVino (cuando se inserte un vino o una sucursal)
  - [X] SucursalPideSuministro referencia SucursalVendeVino
        
  - [x] -- Si elimino Sucursal en la que trabaja un empleado, debería poner su sucursal a NULL-> NO.
  - [x] Si intento eliminar Suc en la que trabaja algún empleado, NO SE PERMITE ELIMINAR. (se deben primero trasladar los empleados o eliminarlos)


     
  - [x] Trigguer TRSucursalUnicoDirector da errores porque al ModificarDirectorSucursal me sale
        <img width="528" height="276" alt="image" src="https://github.com/user-attachments/assets/8bb63169-30cc-49e1-9b37-c65b4d1aaf62" />
        (se ha borrado trigger)

- [x] Que pasa con cantidad_stock de Vino
  - cuándo se actualiza?
  - [x] triggers para actualizar stock de vino (cuando se realiza un suministro) y comprueba que hay suficiente antes

- [x] Decidir como se queda crearTablasLuna1
- Eliminar PKs? LAS DEJAMOS, no estorban
- [ ] Copiar fichero crearTablasLuna1 con modificaciones para que funcione en luna2, luna3...
  
- [ ] Pasar datos de pdf a las tablas (EXEC...)
- [ ] Revisar datos correctos
- 
- [ ] Compilan consultas
- [ ] Funcionan consultas

- [ ] Por último, revisar pdf overleaf
