-- 1) Mostrar los pedidos ordenados según la fecha de recepción.
SELECT *
FROM pedidos
ORDER BY fecha_recepcion;

-- 2) Mostrar todos los vendedores cuyo apellido sea “Díaz”

SELECT *
FROM vendedores
WHERE apellidos = 'Díaz'

-- 3) Mostrar la clave de identificación y el apellido de todos los vendedores que ingresaron a la 
-- empresa después de 1998 ordenados por fecha de ingreso. 

SELECT ID_VEND, APELLIDOS
FROM vendedores
WHERE FECHA_INGRESO > '1998-01-01'
ORDER BY FECHA_INGRESO;

-- 4) Mostrar los renglones de pedidos cuyos importes (cantidad * precio unitario) están entre $200 
-- y $300.

SELECT *, p.cantidad * p.precio_unitario as total
FROM renglones_pdo p
WHERE p.cantidad * p.precio_unitario > 300;

-- 5) Mostrar toda la información de los clientes cuyo apellido comience con la letra “R”. 

SELECT *
FROM clientes
WHERE apellidos LIKE 'R%'

-- 6) Mostrar el código de los productos cuyo stock sea inferior o igual al punto de repedido y sean 
-- abastecidos por el proveedor 1.

SELECT *
FROM stock_local as sl
join productos as prod on prod.ID_PRODUCTO = sl.ID_PRODUCTO
WHERE stock < punto_repedido
AND ID_proveedor = 1;

-- 7) Mostrar los productos cuyo precio unitario sea mayor a 10 o el proveedor sea el 3.

SELECT *
FROM productos
WHERE precio_unitario > 10 OR id_proveedor = 3

-- 8) Mostrar los vendedores que no tienen establecido a quién responden.

SELECT apellidos
FROM vendedores
WHERE id_vend_responde_a IS NULL;

-- 9) Mostrar el nombre de las oficinas y los apellidos de los vendedores que dependen de cada 
-- una de ellas. Ordenar la consulta por oficina y vendedor. 

SELECT ov.nombre, v.apellidos
FROM oficinas_vtas ov
join vendedores as v on v.id_oficina = ov.id_oficina
ORDER BY ov.nombre;

-- ejemplo 2
SELECT ov.nombre, v.apellidos,  v.id_oficina , ov.id_oficina
FROM oficinas_vtas as ov ,vendedores as v
WHERE v.id_oficina = ov.id_oficina
ORDER BY ov.nombre;


-- 10) Mostrar los pedidos presentados en la primera quincena de Marzo de 2000, incluyendo el 
-- apellido del vendedor que recibió el pedido y el apellido del cliente. 

SELECT p.id_pedido, p.fecha_recepcion, v.apellidos as vendedor, c.apellidos as cliente
FROM pedidos as p, vendedores as v, clientes as c
WHERE p.fecha_recepcion BETWEEN '2000-03-01' AND '2000-03-15'
AND p.id_vend = v.id_vend
AND p.id_cliente = c.id_cliente


-- 11) Mostrar los pedidos realizados por el cliente “DANIEL DELPONTE” y recibidos por la 
-- empresa durante el año 2000. 

SELECT c.nombres as nombre_cliente,c.apellidos as apellido_cliente , p.fecha_recepcion
FROM clientes as c, pedidos as p
WHERE p.fecha_recepcion BETWEEN '2000-01-01' AND '2000-12-31'
AND c.nombres = 'DANIEL'
AND c.apellidos = 'DELPONTE'
AND p.id_cliente = c.id_cliente


-- 12) Mostrar la cantidad de productos distintos que comercializa la empresa, del proveedor 2. 

SELECT pr.id_producto, pr.descripcion, pv.id_proveedor, pv.nombre
FROM productos as pr, proveedores as pv
WHERE pv.id_proveedor = 2
AND pr.id_proveedor = pv.id_proveedor;

-- 13) Mostrar el promedio de los importes (cantidad * precio unitario) de los renglones del pedido 
-- 111. 

select ((r.cantidad*precio_unitario)/3) as promedio
from pedidos as p, renglones_pdo as r
where p.id_pedido = r.id_pedido
and p.id_pedido = 111


-- 14) Mostrar la cantidad de pedidos recibidos de los clientes, clasificados por oficina y localidad 
-- del cliente. Ordenar la consulta por localidad del cliente.

select ov.nombre, l.nombre, count(*) as cant_pedidos
from pedidos as p
join clientes as c on p.id_cliente = c.id_cliente
join vendedores as v on p.id_vend = v.id_vend
join localidades as l on c.cod_post = l.cod_post
join oficinas_vtas as ov on v.id_oficina = ov.id_oficina
group by ov.nombre, l.nombre
;

-- 15) Mostrar el máximo, el mínimo y el promedio del importe de los renglones de pedidos 
-- realizados por cada cliente. 

select c.id_cliente, min(p.total), max(p.total)
from clientes as c, pedidos as p
where c.id_cliente = p.id_cliente
group by c.id_cliente
;

-- 16) Ídem anterior pero de cada vendedor. Ordenar la consulta por vendedor en forma descendente.
SELECT v.id_vend, MIN(p.total), MAX(p.total), AVG(p.total)
FROM vendedores as v, pedidos as p
WHERE v.id_vend = p.id_vend
GROUP BY v.id_vend
;

-- --17) Mostrar el importe total de los renglones de pedidos, para aquellos pedidos en donde la suma 
-- de los renglones supere los $ 800. 
SELECT id_pedido, sum(cantidad*precio_unitario)
FROM renglones_pdo
group by ID_PEDIDO
having sum(cantidad*precio_unitario) > 800
;