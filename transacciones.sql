-- Cargar el respaldo de la base de datos unidad2.sql.
CREATE DATABASE unidad2;
\c unidad2 
--a través de la terminal: 
psql -U postgres unidad2 < unidad2.sql

--a través de psql
\i 'C:/Users/Daniela/workspace/bootcamp/m5-transacciones-ev/unidad2.sql'
--reiniciar psql
\c unidad2
\dt --para ver las tablas ya cargadas

--El cliente usuario01 ha realizado la siguiente compra:
--● producto: producto9.
--● cantidad: 5.
--● fecha: fecha del sistema.

BEGIN TRANSACTION;
INSERT INTO compra (cliente_id, fecha) values (1, now());
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) values (9, (SELECT max(id) FROM compra), 5);
UPDATE producto p SET stock = stock-5 WHERE p.id = 9;
COMMIT;
SELECT * FROM producto;

--El cliente usuario02 ha realizado la siguiente compra:
--● producto: producto1, producto 2, producto 8.
--● cantidad: 3 de cada producto.
--● fecha: fecha del sistema.

BEGIN TRANSACTION;
INSERT INTO compra (cliente_id, fecha) values (2, now());
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) values (1,(SELECT max(id) FROM compra), 3);
UPDATE producto p SET stock = stock-3 WHERE p.id = 1;
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) values (2,(SELECT max(id) FROM compra), 3);
UPDATE producto p SET stock = stock-3 WHERE p.id = 2;
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) values (8,(SELECT max(id) FROM compra), 3);
UPDATE producto p SET stock = stock-3 WHERE p.id = 8;
COMMIT;
SELECT * FROM producto;

--Realizar las siguientes consultas (2 Puntos):
--a. Deshabilitar el AUTOCOMMIT 
\set AUTOCOMMIT off
--verificar que este desactivado
\echo :AUTOCOMMIT

--b. Insertar un nuevo cliente
BEGIN TRANSACTION;
INSERT INTO cliente (nombre, email) values ('usuario011', 'usuario011@gmail.com');

--c. Confirmar que fue agregado en la tabla cliente.
SELECT * FROM cliente;

--d. Realizar un ROLLBACK.
ROLLBACK;

--e. Confirmar que se restauró la información, sin considerar la inserción del punto b
SELECT * FROM cliente;

--f. Habilitar de nuevo el AUTOCOMMIT.
\set AUTOCOMMIT on
