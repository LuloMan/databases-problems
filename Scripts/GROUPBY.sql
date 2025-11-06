select p.nombre as producto, count(v.id) as cantidad_ventas
from ventas v join productos p on v.producto_id = p.id
group by p.nombre