-- 1)
SELECT r.*
FROM pedidos as p, renglones_pdo as r
WHERE p.id_pedido = r.id_pedido
AND p.id_pedido >= 110
AND r.precio_unitario > (
	SELECT precio_unitario
	FROM productos
	WHERE descripcion = 'Chocolate Garoto con Nougat'
	LIMIT 1
)
ORDER BY r.precio_unitario, r.id_producto;

-- 2) Mostrar apellidos y nombres de los clientes que se relacionan con la empresa a través de la
-- oficina de “Santa Fe”.

SELECT c.apellidos, c.nombres
FROM clientes as c, vendedores as v
WHERE c.id_vend = v.id_vend
AND v.id_oficina = (
	SELECT id_oficina
	FROM oficinas_vtas
	WHERE nombre = 'GOLOSINAS SUC. SANTA FE'
	LIMIT 1
);


--3) Mostrar todos los pedidos para los cuales el total de los renglones de pedido supere al total de
--los renglones del pedido número 113.
							  
SELECT id_pedido, count(id_renglon)
FROM renglones_pdo
GROUP BY id_pedido
HAVING count(id_pedido) > (
	SELECT count(id_pedido)
	FROM renglones_pdo
	WHERE id_pedido = 113
	GROUP BY id_pedido
);

--4) Mostrar el cargo que tiene, en promedio, el monto más bajo de ventas. 

SELECT cargo
FROM vendedores
WHERE id_vend = (	SELECT id_vend
					FROM pedidos
					GROUP BY id_vend
					HAVING avg(total) = (	SELECT avg(total) as vendio
											FROM pedidos
											GROUP BY id_vend
											ORDER BY vendio ASC
											LIMIT 1))


--5) Mostrar el apellido y nombre de los vendedores cuyo cargo tiene, en promedio, el monto más
--bajo de ventas. 

SELECT apellidos, nombres
FROM vendedores
WHERE id_vend = (
	SELECT id_vend
	FROM pedidos
	GROUP BY id_vend
	HAVING avg(total) = (
		SELECT avg(total) as vendio
		FROM pedidos
		GROUP BY id_vend
		ORDER BY vendio ASC
		LIMIT 1
	)
);

--6) Mostrar el apellido de los clientes a los cuales se les han entregado (cumplido) todos sus
--pedidos. 

SELECT apellidos
FROM clientes
WHERE id_cliente in (
	SELECT id_cliente
	FROM pedidos
	WHERE pedido_cumplido = 'V'
);

--7) Realizar las siguientes consultas:
--a) Mostrar el identificador y nombre de las oficinas que tienen en stock todos los productos.
--b) Haga lo mismo pero utilizando la cláusula NOT EXISTS.

SELECT id_oficina, nombre
FROM oficinas_vtas
WHERE id_oficina in (
	SELECT id_oficina
	FROM stock_local
	GROUP BY id_oficina
	HAVING count(id_producto) = (
		SELECT count(id_producto)
		FROM productos
	)
);

