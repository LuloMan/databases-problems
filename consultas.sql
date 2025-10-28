 SELECT id,
    nombre,
    apellido,
    comision
   FROM empleados
  WHERE comision IS NOT NULL
  ORDER BY salario DESC;