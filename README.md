# Proyecto de Base de Datos PostgreSQL con pgAdmin

Este es un proyecto educativo simple para enseñar bases de datos usando PostgreSQL y pgAdmin con Docker.

## Requisitos

- Docker Desktop (debe estar ejecutándose)
- Docker Compose
- Navegador web

**Nota:** Asegúrate de que Docker Desktop esté ejecutándose antes de continuar.

## Estructura del Proyecto

```
databases-problems/
├── docker-compose.yml    # Configuración de servicios Docker
├── init.sql             # Script de inicialización de la base de datos
└── README.md            # Este archivo
```

## Cómo Ejecutar el Proyecto

1. **Clonar o descargar el proyecto**
   ```bash
   git clone <url-del-repositorio>
   cd databases-problems
   ```

2. **Ejecutar con Docker Compose**
   ```bash
   docker-compose up -d
   ```

3. **Acceder a pgAdmin**
   - Abrir navegador en: http://localhost:8080
   - Email: admin@empresa.com
   - Contraseña: admin123

4. **Conectar a la base de datos en pgAdmin**
   - Crear nueva conexión
   - Host: postgres (nombre del servicio)
   - Puerto: 5432
   - Base de datos: empresa_db
   - Usuario: admin
   - Contraseña: admin123

## Estructura de la Base de Datos

### Tablas Creadas

1. **sucursales**
   - id (SERIAL PRIMARY KEY)
   - nombre (VARCHAR)
   - direccion (VARCHAR)
   - telefono (VARCHAR)
   - ciudad (VARCHAR)
   - fecha_apertura (DATE)

2. **productos**
   - id (SERIAL PRIMARY KEY)
   - nombre (VARCHAR)
   - descripcion (TEXT)
   - precio (DECIMAL)
   - stock (INTEGER)
   - categoria (VARCHAR)
   - fecha_creacion (TIMESTAMP)

3. **empleados**
   - id (SERIAL PRIMARY KEY)
   - nombre (VARCHAR)
   - apellido (VARCHAR)
   - email (VARCHAR UNIQUE)
   - telefono (VARCHAR)
   - cargo (VARCHAR)
   - salario (DECIMAL)
   - fecha_contratacion (DATE)
   - sucursal_id (INTEGER FOREIGN KEY)

### Datos de Ejemplo

- **5 sucursales** en diferentes ciudades
- **8 productos** de diversas categorías
- **15 empleados** distribuidos en las sucursales

## Comandos Útiles

### Detener los servicios
```bash
docker-compose down
```

### Ver logs
```bash
docker-compose logs
```

### Reiniciar con datos frescos
```bash
docker-compose down -v
docker-compose up -d
```

## Consultas de Ejemplo

```sql
-- Ver todos los empleados con su sucursal
SELECT e.nombre, e.apellido, e.cargo, s.nombre as sucursal
FROM empleados e
JOIN sucursales s ON e.sucursal_id = s.id;

-- Productos por categoría
SELECT categoria, COUNT(*) as cantidad
FROM productos
GROUP BY categoria;

-- Empleados por sucursal
SELECT s.nombre as sucursal, COUNT(e.id) as empleados
FROM sucursales s
LEFT JOIN empleados e ON s.id = e.sucursal_id
GROUP BY s.id, s.nombre;
```

## Propósito Educativo

Este proyecto está diseñado para:
- Aprender conceptos básicos de bases de datos relacionales
- Practicar consultas SQL
- Entender relaciones entre tablas (claves foráneas)
- Familiarizarse con PostgreSQL y pgAdmin
- Experimentar con Docker para desarrollo

## Notas Importantes

- Los datos se crean automáticamente al iniciar el contenedor
- La base de datos persiste entre reinicios del contenedor
- Para empezar desde cero, usar `docker-compose down -v`
- El puerto 5432 está expuesto para conexiones externas si es necesario
