# Proyecto de Base de Datos PostgreSQL con pgAdmin

Este es un proyecto educativo simple para enseñar bases de datos usando PostgreSQL y pgAdmin con Docker.

## Requisitos

### Software Necesario
- **Docker Desktop** (debe estar ejecutándose)
- **Docker Compose** (incluido con Docker Desktop)
- **Navegador web** (Chrome, Firefox, Edge, Safari)

### Requisitos del Sistema
- **Windows 10/11** (versión 1903 o superior) con WSL 2 habilitado
- **macOS** (versión 10.15 o superior)
- **Linux** (Ubuntu 18.04+, CentOS 7+, RHEL 7+)
- **RAM:** Mínimo 4GB, recomendado 8GB
- **Espacio en disco:** Mínimo 2GB libres

## Instalación de Docker

### Windows
1. **Descargar Docker Desktop:**
   - Ir a: https://www.docker.com/products/docker-desktop/
   - Descargar "Docker Desktop for Windows"

2. **Instalar Docker Desktop:**
   - Ejecutar el instalador descargado
   - Seguir las instrucciones del asistente
   - **Importante:** Aceptar instalar WSL 2 cuando se solicite

3. **Configurar WSL 2 (si es necesario):**
   ```powershell
   # Ejecutar en PowerShell como Administrador
   wsl --install
   wsl --set-default-version 2
   ```

4. **Iniciar Docker Desktop:**
   - Buscar "Docker Desktop" en el menú inicio
   - Hacer clic para iniciar
   - Esperar a que aparezca el ícono de Docker en la bandeja del sistema
   - Verificar que el estado sea "Running"

### macOS
1. **Descargar Docker Desktop:**
   - Ir a: https://www.docker.com/products/docker-desktop/
   - Descargar "Docker Desktop for Mac"

2. **Instalar Docker Desktop:**
   - Abrir el archivo .dmg descargado
   - Arrastrar Docker a la carpeta Applications
   - Ejecutar Docker Desktop desde Applications

3. **Iniciar Docker Desktop:**
   - Buscar Docker en Spotlight (Cmd + Espacio)
   - Hacer clic para iniciar
   - Aceptar los permisos de seguridad si se solicitan

### Linux (Ubuntu/Debian)
1. **Actualizar el sistema:**
   ```bash
   sudo apt update
   sudo apt upgrade
   ```

2. **Instalar dependencias:**
   ```bash
   sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release
   ```

3. **Agregar la clave GPG de Docker:**
   ```bash
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   ```

4. **Agregar el repositorio de Docker:**
   ```bash
   echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```

5. **Instalar Docker:**
   ```bash
   sudo apt update
   sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
   ```

6. **Agregar usuario al grupo docker:**
   ```bash
   sudo usermod -aG docker $USER
   ```

7. **Reiniciar la sesión** para aplicar los cambios

### Verificar la Instalación
```bash
# Verificar que Docker esté instalado y funcionando
docker --version
docker-compose --version

# Probar Docker con un contenedor simple
docker run hello-world
```

**Nota:** Asegúrate de que Docker Desktop esté ejecutándose antes de continuar con el proyecto.

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
     - Maintenance database: `empresa_db`
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
   - costo (DECIMAL) - *Nuevo*
   - margen_ganancia (DECIMAL) - *Nuevo*
   - unidades_vendidas (INTEGER) - *Nuevo*
   - fecha_creacion (TIMESTAMP)

3. **empleados**
   - id (SERIAL PRIMARY KEY)
   - nombre (VARCHAR)
   - apellido (VARCHAR)
   - email (VARCHAR UNIQUE)
   - telefono (VARCHAR)
   - cargo (VARCHAR)
   - salario (DECIMAL)
   - comision (DECIMAL) - *Nuevo*
   - horas_trabajadas (INTEGER) - *Nuevo*
   - ventas_realizadas (INTEGER) - *Nuevo*
   - fecha_contratacion (DATE)
   - sucursal_id (INTEGER FOREIGN KEY)

4. **ventas** - *Nueva tabla*
   - id (SERIAL PRIMARY KEY)
   - fecha_venta (DATE)
   - producto_id (INTEGER FOREIGN KEY)
   - empleado_id (INTEGER FOREIGN KEY)
   - sucursal_id (INTEGER FOREIGN KEY)
   - cantidad (INTEGER)
   - precio_unitario (DECIMAL)
   - total (DECIMAL)
   - descuento (DECIMAL)
   - metodo_pago (VARCHAR)

### Datos de Ejemplo

- **5 sucursales** en diferentes ciudades
- **12 productos** de diversas categorías con costos y márgenes
- **20 empleados** distribuidos en las sucursales con métricas de rendimiento
- **60 ventas** de ejemplo con diferentes productos, empleados y métodos de pago

## Comandos Útiles

### Gestión de Contenedores
```bash
# Iniciar los servicios
docker-compose up -d

# Detener los servicios
docker-compose down

# Reiniciar los servicios
docker-compose restart

# Ver estado de los contenedores
docker-compose ps

# Ver logs de todos los servicios
docker-compose logs

# Ver logs de un servicio específico
docker-compose logs postgres
docker-compose logs pgadmin
```

### Gestión de Datos
```bash
# Reiniciar con datos frescos (elimina todos los datos)
docker-compose down -v
docker-compose up -d

# Hacer backup de la base de datos
docker-compose exec postgres pg_dump -U admin empresa_db > backup.sql

# Restaurar backup
docker-compose exec -T postgres psql -U admin empresa_db < backup.sql
```

### Comandos de Diagnóstico
```bash
# Ver uso de recursos
docker stats

# Limpiar contenedores e imágenes no utilizadas
docker system prune -a

# Ver información detallada de los contenedores
docker-compose config

# Ejecutar comandos dentro del contenedor PostgreSQL
docker-compose exec postgres psql -U admin -d empresa_db
```

### Comandos de Desarrollo
```bash
# Reconstruir las imágenes
docker-compose build

# Ver logs en tiempo real
docker-compose logs -f

# Ejecutar comandos SQL directamente
docker-compose exec postgres psql -U admin -d empresa_db -c "SELECT * FROM productos;"
```

## Consultas de Ejemplo

### Consultas Básicas
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

### Funciones Agregadas (AVG, SUM, COUNT, MAX, MIN)
```sql
-- Promedio de salarios por cargo
SELECT cargo, AVG(salario) as salario_promedio, COUNT(*) as cantidad
FROM empleados
GROUP BY cargo;

-- Suma total de ventas por empleado
SELECT e.nombre, e.apellido, SUM(v.total) as total_ventas, COUNT(v.id) as ventas_realizadas
FROM empleados e
JOIN ventas v ON e.id = v.empleado_id
GROUP BY e.id, e.nombre, e.apellido
ORDER BY total_ventas DESC;

-- Estadísticas de productos por categoría
SELECT categoria, 
       COUNT(*) as cantidad_productos,
       AVG(precio) as precio_promedio,
       MIN(precio) as precio_minimo,
       MAX(precio) as precio_maximo,
       SUM(unidades_vendidas) as total_vendido
FROM productos
GROUP BY categoria;

-- Ventas por mes
SELECT DATE_TRUNC('month', fecha_venta) as mes,
       COUNT(*) as cantidad_ventas,
       SUM(total) as total_ingresos,
       AVG(total) as promedio_venta
FROM ventas
GROUP BY DATE_TRUNC('month', fecha_venta)
ORDER BY mes;

-- Top 5 productos más vendidos
SELECT p.nombre, p.categoria, SUM(v.cantidad) as total_vendido, SUM(v.total) as ingresos
FROM productos p
JOIN ventas v ON p.id = v.producto_id
GROUP BY p.id, p.nombre, p.categoria
ORDER BY total_vendido DESC
LIMIT 5;

-- Análisis de descuentos
SELECT metodo_pago,
       COUNT(*) as cantidad_ventas,
       AVG(descuento) as descuento_promedio,
       SUM(total) as total_con_descuento
FROM ventas
WHERE descuento > 0
GROUP BY metodo_pago;

-- Rendimiento de empleados (ventas vs horas trabajadas)
SELECT e.nombre, e.apellido, e.cargo,
       e.horas_trabajadas,
       e.ventas_realizadas,
       ROUND(e.ventas_realizadas::DECIMAL / e.horas_trabajadas, 2) as ventas_por_hora
FROM empleados e
WHERE e.cargo = 'Vendedor' OR e.cargo = 'Vendedora'
ORDER BY ventas_por_hora DESC;
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

### Problemas de Instalación de Docker

#### Windows - Error "WSL 2 installation is incomplete"
```powershell
# Ejecutar en PowerShell como Administrador
wsl --install
wsl --set-default-version 2
# Reiniciar el sistema
```

#### Windows - Docker Desktop no inicia
- Verificar que la virtualización esté habilitada en BIOS
- Verificar que Hyper-V esté habilitado
- Ejecutar Docker Desktop como Administrador

#### macOS - Error de permisos
```bash
# Dar permisos de ejecución
sudo chmod +x /Applications/Docker.app/Contents/Resources/bin/docker
```

#### Linux - Error "Permission denied"
```bash
# Agregar usuario al grupo docker
sudo usermod -aG docker $USER
# Cerrar sesión y volver a iniciar
```

### Problemas del Proyecto

#### Si ves Adminer en lugar de pgAdmin
- Asegúrate de acceder a **http://localhost:8080** (puerto correcto)
- Si el puerto 8080 está ocupado, cambiar el puerto en docker-compose.yml

#### Si hay errores de puerto ocupado
```bash
# Detener todos los servicios
docker-compose down

# Cambiar puertos en docker-compose.yml si es necesario
# Luego reiniciar
docker-compose up -d
```

#### Si no puedes conectar a la base de datos
- Verificar que ambos contenedores estén ejecutándose: `docker-compose ps`
- Usar exactamente estos valores en pgAdmin:
  - Host: `postgres`
  - Port: `5432` (interno del contenedor)
  - Maintenance database: `empresa_db`
  - Username: `admin` (no el email)
  - Password: `admin123`

#### Si ves errores de React en la consola del navegador
- **Error #200**: Es un problema común de pgAdmin con Chrome
- **Solución**: Limpiar caché del navegador (`Ctrl + Shift + Delete`)
- **Alternativa**: Usar Firefox o Edge
- **Otra opción**: Abrir en modo incógnito/privado
- **Nota**: El error no impide el funcionamiento de pgAdmin

#### Si los contenedores no inician
```bash
# Verificar logs de errores
docker-compose logs

# Limpiar todo y empezar de nuevo
docker-compose down -v
docker system prune -a
docker-compose up -d
```

#### Si la base de datos no tiene datos
```bash
# Verificar que el script init.sql se ejecutó
docker-compose logs postgres

# Si no hay datos, reiniciar con volumen limpio
docker-compose down -v
docker-compose up -d
```
