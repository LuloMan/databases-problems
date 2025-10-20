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
   - Abrir navegador en: **http://localhost:8080**
   - Email: `admin@empresa.com`
   - Contraseña: `admin123`

4. **Conectar a la base de datos en pgAdmin**
   - Después del login, hacer clic en "Add New Server"
   - En la pestaña "General":
     - Name: `Empresa DB` (nombre descriptivo)
   - En la pestaña "Connection":
     - Host name/address: `postgres`
     - Port: `5432`
     - Database: `empresa_db`
     - Username: `admin`
     - Password: `admin123`
   - Hacer clic en "Save"

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
- PostgreSQL está disponible en el puerto 5432, pgAdmin en el puerto 8080

## Solución de Problemas

### Si ves Adminer en lugar de pgAdmin
- Asegúrate de acceder a **http://localhost:8080** (puerto correcto)
- Si el puerto 8080 está ocupado, cambiar el puerto en docker-compose.yml

### Si hay errores de puerto ocupado
```bash
# Detener todos los servicios
docker-compose down

# Cambiar puertos en docker-compose.yml si es necesario
# Luego reiniciar
docker-compose up -d
```

### Si no puedes conectar a la base de datos
- Verificar que ambos contenedores estén ejecutándose: `docker-compose ps`
- Usar exactamente estos valores en pgAdmin:
  - Host: `postgres`
  - Port: `5432` (interno del contenedor)
  - Username: `admin` (no el email)
  - Password: `admin123`

### Si ves errores de React en la consola del navegador
- **Error #200**: Es un problema común de pgAdmin con Chrome
- **Solución**: Limpiar caché del navegador (`Ctrl + Shift + Delete`)
- **Alternativa**: Usar Firefox o Edge
- **Otra opción**: Abrir en modo incógnito/privado
- **Nota**: El error no impide el funcionamiento de pgAdmin
