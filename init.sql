-- Crear base de datos empresa_db
-- Este script se ejecuta automáticamente al iniciar el contenedor PostgreSQL

-- Crear tabla sucursales
CREATE TABLE IF NOT EXISTS sucursales (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(20),
    ciudad VARCHAR(50) NOT NULL,
    fecha_apertura DATE NOT NULL
);

-- Crear tabla productos
CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    categoria VARCHAR(50),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla empleados
CREATE TABLE IF NOT EXISTS empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2),
    fecha_contratacion DATE NOT NULL,
    sucursal_id INTEGER REFERENCES sucursales(id)
);

-- Insertar datos de ejemplo en sucursales
INSERT INTO sucursales (nombre, direccion, telefono, ciudad, fecha_apertura) VALUES
('Sucursal Centro', 'Av. Principal 123', '555-0101', 'Ciudad Capital', '2020-01-15'),
('Sucursal Norte', 'Calle Norte 456', '555-0102', 'Ciudad Norte', '2020-03-20'),
('Sucursal Sur', 'Av. Sur 789', '555-0103', 'Ciudad Sur', '2020-06-10'),
('Sucursal Este', 'Calle Este 321', '555-0104', 'Ciudad Este', '2021-02-14'),
('Sucursal Oeste', 'Av. Oeste 654', '555-0105', 'Ciudad Oeste', '2021-05-30');

-- Insertar datos de ejemplo en productos
INSERT INTO productos (nombre, descripcion, precio, stock, categoria) VALUES
('Laptop Dell Inspiron', 'Laptop de 15 pulgadas con procesador Intel i5', 899.99, 25, 'Electrónicos'),
('Mouse Inalámbrico', 'Mouse óptico inalámbrico USB', 29.99, 150, 'Accesorios'),
('Teclado Mecánico', 'Teclado mecánico RGB con switches azules', 89.99, 40, 'Accesorios'),
('Monitor Samsung 24"', 'Monitor LED de 24 pulgadas Full HD', 199.99, 30, 'Electrónicos'),
('Impresora HP LaserJet', 'Impresora láser monocromática', 149.99, 15, 'Oficina'),
('Cafetera Eléctrica', 'Cafetera automática de 12 tazas', 79.99, 20, 'Hogar'),
('Silla Ergonómica', 'Silla de oficina con soporte lumbar', 199.99, 12, 'Muebles'),
('Escritorio de Madera', 'Escritorio de madera maciza 120cm', 299.99, 8, 'Muebles');

-- Insertar datos de ejemplo en empleados
INSERT INTO empleados (nombre, apellido, email, telefono, cargo, salario, fecha_contratacion, sucursal_id) VALUES
('Juan', 'Pérez', 'juan.perez@empresa.com', '555-1001', 'Gerente', 4500.00, '2020-01-15', 1),
('María', 'González', 'maria.gonzalez@empresa.com', '555-1002', 'Vendedora', 2800.00, '2020-02-01', 1),
('Carlos', 'Rodríguez', 'carlos.rodriguez@empresa.com', '555-1003', 'Vendedor', 2800.00, '2020-02-15', 1),
('Ana', 'Martínez', 'ana.martinez@empresa.com', '555-1004', 'Gerente', 4500.00, '2020-03-20', 2),
('Luis', 'Fernández', 'luis.fernandez@empresa.com', '555-1005', 'Vendedor', 2800.00, '2020-04-01', 2),
('Carmen', 'López', 'carmen.lopez@empresa.com', '555-1006', 'Vendedora', 2800.00, '2020-04-15', 2),
('Pedro', 'Sánchez', 'pedro.sanchez@empresa.com', '555-1007', 'Gerente', 4500.00, '2020-06-10', 3),
('Laura', 'García', 'laura.garcia@empresa.com', '555-1008', 'Vendedora', 2800.00, '2020-07-01', 3),
('Miguel', 'Hernández', 'miguel.hernandez@empresa.com', '555-1009', 'Vendedor', 2800.00, '2020-07-15', 3),
('Isabel', 'Jiménez', 'isabel.jimenez@empresa.com', '555-1010', 'Gerente', 4500.00, '2021-02-14', 4),
('Roberto', 'Moreno', 'roberto.moreno@empresa.com', '555-1011', 'Vendedor', 2800.00, '2021-03-01', 4),
('Patricia', 'Ruiz', 'patricia.ruiz@empresa.com', '555-1012', 'Vendedora', 2800.00, '2021-03-15', 4),
('Fernando', 'Díaz', 'fernando.diaz@empresa.com', '555-1013', 'Gerente', 4500.00, '2021-05-30', 5),
('Sandra', 'Álvarez', 'sandra.alvarez@empresa.com', '555-1014', 'Vendedora', 2800.00, '2021-06-15', 5),
('Antonio', 'Romero', 'antonio.romero@empresa.com', '555-1015', 'Vendedor', 2800.00, '2021-07-01', 5);

-- Crear algunos índices para mejorar el rendimiento
CREATE INDEX IF NOT EXISTS idx_empleados_sucursal ON empleados(sucursal_id);
CREATE INDEX IF NOT EXISTS idx_productos_categoria ON productos(categoria);
CREATE INDEX IF NOT EXISTS idx_sucursales_ciudad ON sucursales(ciudad);

-- Mostrar información de las tablas creadas
SELECT 'Tablas creadas exitosamente:' as mensaje;
SELECT 'Sucursales: ' || COUNT(*) as total FROM sucursales;
SELECT 'Productos: ' || COUNT(*) as total FROM productos;
SELECT 'Empleados: ' || COUNT(*) as total FROM empleados;
