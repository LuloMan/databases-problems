SELECT p.nombre, SUM(v.total) as total_vendido
FROM public.ventas as v inner join productos as p
ON v.producto_id = p.id
GROUP BY p.nombre
ORDER BY total_vendido
