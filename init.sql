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
    costo DECIMAL(10,2) NOT NULL DEFAULT 0,
    margen_ganancia DECIMAL(5,2) DEFAULT 0,
    unidades_vendidas INTEGER DEFAULT 0,
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
    comision DECIMAL(5,2) DEFAULT 0,
    horas_trabajadas INTEGER DEFAULT 40,
    ventas_realizadas INTEGER DEFAULT 0,
    fecha_contratacion DATE NOT NULL,
    sucursal_id INTEGER REFERENCES sucursales(id)
);

-- Crear tabla ventas
CREATE TABLE IF NOT EXISTS ventas (
    id SERIAL PRIMARY KEY,
    fecha_venta DATE NOT NULL,
    producto_id INTEGER REFERENCES productos(id),
    empleado_id INTEGER REFERENCES empleados(id),
    sucursal_id INTEGER REFERENCES sucursales(id),
    cantidad INTEGER NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    descuento DECIMAL(5,2) DEFAULT 0,
    metodo_pago VARCHAR(20) DEFAULT 'Efectivo'
);

-- Insertar datos de ejemplo en sucursales
INSERT INTO sucursales (nombre, direccion, telefono, ciudad, fecha_apertura) VALUES
('Sucursal Centro', 'Av. Principal 123', '555-0101', 'Ciudad Capital', '2020-01-15'),
('Sucursal Norte', 'Calle Norte 456', '555-0102', 'Ciudad Norte', '2020-03-20'),
('Sucursal Sur', 'Av. Sur 789', '555-0103', 'Ciudad Sur', '2020-06-10'),
('Sucursal Este', 'Calle Este 321', '555-0104', 'Ciudad Este', '2021-02-14'),
('Sucursal Oeste', 'Av. Oeste 654', '555-0105', 'Ciudad Oeste', '2021-05-30');

-- Insertar datos de ejemplo en productos
INSERT INTO productos (nombre, descripcion, precio, stock, categoria, costo, margen_ganancia, unidades_vendidas) VALUES
('Laptop Dell Inspiron', 'Laptop de 15 pulgadas con procesador Intel i5', 899.99, 25, 'Electrónicos', 650.00, 38.46, 45),
('Mouse Inalámbrico', 'Mouse óptico inalámbrico USB', 29.99, 150, 'Accesorios', 15.00, 99.93, 120),
('Teclado Mecánico', 'Teclado mecánico RGB con switches azules', 89.99, 40, 'Accesorios', 45.00, 99.98, 35),
('Monitor Samsung 24"', 'Monitor LED de 24 pulgadas Full HD', 199.99, 30, 'Electrónicos', 120.00, 66.66, 28),
('Impresora HP LaserJet', 'Impresora láser monocromática', 149.99, 15, 'Oficina', 80.00, 87.49, 12),
('Cafetera Eléctrica', 'Cafetera automática de 12 tazas', 79.99, 20, 'Hogar', 35.00, 128.54, 18),
('Silla Ergonómica', 'Silla de oficina con soporte lumbar', 199.99, 12, 'Muebles', 90.00, 122.21, 8),
('Escritorio de Madera', 'Escritorio de madera maciza 120cm', 299.99, 8, 'Muebles', 150.00, 99.99, 5),
('Tablet Samsung Galaxy', 'Tablet de 10 pulgadas con Android', 249.99, 18, 'Electrónicos', 180.00, 38.88, 22),
('Auriculares Bluetooth', 'Auriculares inalámbricos con cancelación de ruido', 89.99, 35, 'Accesorios', 40.00, 124.98, 30),
('Router WiFi 6', 'Router inalámbrico de alta velocidad', 129.99, 22, 'Electrónicos', 70.00, 85.70, 15),
('Disco Duro Externo 1TB', 'Disco duro portátil USB 3.0', 69.99, 28, 'Accesorios', 35.00, 99.97, 25);

-- Insertar datos de ejemplo en empleados
INSERT INTO empleados (nombre, apellido, email, telefono, cargo, salario, comision, horas_trabajadas, ventas_realizadas, fecha_contratacion, sucursal_id) VALUES
('Juan', 'Pérez', 'juan.perez@empresa.com', '555-1001', 'Gerente', 4500.00, 2.5, 40, 0, '2020-01-15', 1),
('María', 'González', 'maria.gonzalez@empresa.com', '555-1002', 'Vendedora', 2800.00, 5.0, 40, 45, '2020-02-01', 1),
('Carlos', 'Rodríguez', 'carlos.rodriguez@empresa.com', '555-1003', 'Vendedor', 2800.00, 5.0, 40, 38, '2020-02-15', 1),
('Ana', 'Martínez', 'ana.martinez@empresa.com', '555-1004', 'Gerente', 4500.00, 2.5, 40, 0, '2020-03-20', 2),
('Luis', 'Fernández', 'luis.fernandez@empresa.com', '555-1005', 'Vendedor', 2800.00, 5.0, 40, 42, '2020-04-01', 2),
('Carmen', 'López', 'carmen.lopez@empresa.com', '555-1006', 'Vendedora', 2800.00, 5.0, 40, 35, '2020-04-15', 2),
('Pedro', 'Sánchez', 'pedro.sanchez@empresa.com', '555-1007', 'Gerente', 4500.00, 2.5, 40, 0, '2020-06-10', 3),
('Laura', 'García', 'laura.garcia@empresa.com', '555-1008', 'Vendedora', 2800.00, 5.0, 40, 48, '2020-07-01', 3),
('Miguel', 'Hernández', 'miguel.hernandez@empresa.com', '555-1009', 'Vendedor', 2800.00, 5.0, 40, 41, '2020-07-15', 3),
('Isabel', 'Jiménez', 'isabel.jimenez@empresa.com', '555-1010', 'Gerente', 4500.00, 2.5, 40, 0, '2021-02-14', 4),
('Roberto', 'Moreno', 'roberto.moreno@empresa.com', '555-1011', 'Vendedor', 2800.00, 5.0, 40, 39, '2021-03-01', 4),
('Patricia', 'Ruiz', 'patricia.ruiz@empresa.com', '555-1012', 'Vendedora', 2800.00, 5.0, 40, 44, '2021-03-15', 4),
('Fernando', 'Díaz', 'fernando.diaz@empresa.com', '555-1013', 'Gerente', 4500.00, 2.5, 40, 0, '2021-05-30', 5),
('Sandra', 'Álvarez', 'sandra.alvarez@empresa.com', '555-1014', 'Vendedora', 2800.00, 5.0, 40, 37, '2021-06-15', 5),
('Antonio', 'Romero', 'antonio.romero@empresa.com', '555-1015', 'Vendedor', 2800.00, 5.0, 40, 43, '2021-07-01', 5),
('Elena', 'Torres', 'elena.torres@empresa.com', '555-1016', 'Vendedora', 2800.00, 5.0, 40, 36, '2021-08-15', 1),
('Diego', 'Vargas', 'diego.vargas@empresa.com', '555-1017', 'Vendedor', 2800.00, 5.0, 40, 40, '2021-09-01', 2),
('Lucía', 'Mendoza', 'lucia.mendoza@empresa.com', '555-1018', 'Vendedora', 2800.00, 5.0, 40, 46, '2021-10-15', 3),
('Ricardo', 'Silva', 'ricardo.silva@empresa.com', '555-1019', 'Vendedor', 2800.00, 5.0, 40, 33, '2021-11-01', 4),
('Valentina', 'Castro', 'valentina.castro@empresa.com', '555-1020', 'Vendedora', 2800.00, 5.0, 40, 47, '2021-12-15', 5);

-- Insertar datos de ejemplo en ventas
INSERT INTO ventas (fecha_venta, producto_id, empleado_id, sucursal_id, cantidad, precio_unitario, total, descuento, metodo_pago) VALUES
('2024-01-15', 1, 2, 1, 1, 899.99, 899.99, 0, 'Tarjeta'),
('2024-01-16', 2, 2, 1, 3, 29.99, 89.97, 5, 'Efectivo'),
('2024-01-17', 3, 3, 1, 1, 89.99, 89.99, 0, 'Tarjeta'),
('2024-01-18', 4, 2, 1, 2, 199.99, 399.98, 10, 'Tarjeta'),
('2024-01-19', 5, 3, 1, 1, 149.99, 149.99, 0, 'Efectivo'),
('2024-01-20', 6, 2, 1, 1, 79.99, 79.99, 0, 'Efectivo'),
('2024-01-21', 7, 3, 1, 1, 199.99, 199.99, 15, 'Tarjeta'),
('2024-01-22', 8, 2, 1, 1, 299.99, 299.99, 0, 'Tarjeta'),
('2024-01-23', 9, 3, 1, 2, 249.99, 499.98, 8, 'Tarjeta'),
('2024-01-24', 10, 2, 1, 1, 89.99, 89.99, 0, 'Efectivo'),
('2024-01-25', 11, 3, 1, 1, 129.99, 129.99, 0, 'Tarjeta'),
('2024-01-26', 12, 2, 1, 3, 69.99, 209.97, 12, 'Efectivo'),
('2024-01-27', 1, 3, 1, 1, 899.99, 899.99, 0, 'Tarjeta'),
('2024-01-28', 2, 2, 1, 5, 29.99, 149.95, 0, 'Efectivo'),
('2024-01-29', 3, 3, 1, 2, 89.99, 179.98, 0, 'Tarjeta'),
('2024-01-30', 4, 2, 1, 1, 199.99, 199.99, 0, 'Efectivo'),
('2024-02-01', 5, 3, 1, 1, 149.99, 149.99, 0, 'Tarjeta'),
('2024-02-02', 6, 2, 1, 2, 79.99, 159.98, 0, 'Efectivo'),
('2024-02-03', 7, 3, 1, 1, 199.99, 199.99, 0, 'Tarjeta'),
('2024-02-04', 8, 2, 1, 1, 299.99, 299.99, 0, 'Tarjeta'),
('2024-02-05', 9, 3, 1, 1, 249.99, 249.99, 0, 'Efectivo'),
('2024-02-06', 10, 2, 1, 2, 89.99, 179.98, 0, 'Tarjeta'),
('2024-02-07', 11, 3, 1, 1, 129.99, 129.99, 0, 'Efectivo'),
('2024-02-08', 12, 2, 1, 2, 69.99, 139.98, 0, 'Tarjeta'),
('2024-02-09', 1, 3, 1, 1, 899.99, 899.99, 0, 'Tarjeta'),
('2024-02-10', 2, 2, 1, 4, 29.99, 119.96, 0, 'Efectivo'),
('2024-02-11', 3, 3, 1, 1, 89.99, 89.99, 0, 'Tarjeta'),
('2024-02-12', 4, 2, 1, 1, 199.99, 199.99, 0, 'Efectivo'),
('2024-02-13', 5, 3, 1, 1, 149.99, 149.99, 0, 'Tarjeta'),
('2024-02-14', 6, 2, 1, 1, 79.99, 79.99, 0, 'Efectivo'),
('2024-02-15', 7, 3, 1, 1, 199.99, 199.99, 0, 'Tarjeta'),
('2024-02-16', 8, 2, 1, 1, 299.99, 299.99, 0, 'Tarjeta'),
('2024-02-17', 9, 3, 1, 1, 249.99, 249.99, 0, 'Efectivo'),
('2024-02-18', 10, 2, 1, 1, 89.99, 89.99, 0, 'Tarjeta'),
('2024-02-19', 11, 3, 1, 1, 129.99, 129.99, 0, 'Efectivo'),
('2024-02-20', 12, 2, 1, 1, 69.99, 69.99, 0, 'Tarjeta'),
('2024-02-21', 1, 3, 1, 1, 899.99, 899.99, 0, 'Tarjeta'),
('2024-02-22', 2, 2, 1, 3, 29.99, 89.97, 0, 'Efectivo'),
('2024-02-23', 3, 3, 1, 1, 89.99, 89.99, 0, 'Tarjeta'),
('2024-02-24', 4, 2, 1, 1, 199.99, 199.99, 0, 'Efectivo'),
('2024-02-25', 5, 3, 1, 1, 149.99, 149.99, 0, 'Tarjeta'),
('2024-02-26', 6, 2, 1, 2, 79.99, 159.98, 0, 'Efectivo'),
('2024-02-27', 7, 3, 1, 1, 199.99, 199.99, 0, 'Tarjeta'),
('2024-02-28', 8, 2, 1, 1, 299.99, 299.99, 0, 'Tarjeta'),
('2024-02-29', 9, 3, 1, 1, 249.99, 249.99, 0, 'Efectivo'),
('2024-03-01', 10, 2, 1, 1, 89.99, 89.99, 0, 'Tarjeta'),
('2024-03-02', 11, 3, 1, 1, 129.99, 129.99, 0, 'Efectivo'),
('2024-03-03', 12, 2, 1, 2, 69.99, 139.98, 0, 'Tarjeta'),
('2024-03-04', 1, 3, 1, 1, 899.99, 899.99, 0, 'Tarjeta'),
('2024-03-05', 2, 2, 1, 5, 29.99, 149.95, 0, 'Efectivo'),
('2024-03-06', 3, 3, 1, 1, 89.99, 89.99, 0, 'Tarjeta'),
('2024-03-07', 4, 2, 1, 1, 199.99, 199.99, 0, 'Efectivo'),
('2024-03-08', 5, 3, 1, 1, 149.99, 149.99, 0, 'Tarjeta'),
('2024-03-09', 6, 2, 1, 1, 79.99, 79.99, 0, 'Efectivo'),
('2024-03-10', 7, 3, 1, 1, 199.99, 199.99, 0, 'Tarjeta'),
('2024-03-11', 8, 2, 1, 1, 299.99, 299.99, 0, 'Tarjeta'),
('2024-03-12', 9, 3, 1, 1, 249.99, 249.99, 0, 'Efectivo'),
('2024-03-13', 10, 2, 1, 1, 89.99, 89.99, 0, 'Tarjeta'),
('2024-03-14', 11, 3, 1, 1, 129.99, 129.99, 0, 'Efectivo'),
('2024-03-15', 12, 2, 1, 1, 69.99, 69.99, 0, 'Tarjeta');

-- Crear algunos índices para mejorar el rendimiento
CREATE INDEX IF NOT EXISTS idx_empleados_sucursal ON empleados(sucursal_id);
CREATE INDEX IF NOT EXISTS idx_productos_categoria ON productos(categoria);
CREATE INDEX IF NOT EXISTS idx_sucursales_ciudad ON sucursales(ciudad);
CREATE INDEX IF NOT EXISTS idx_ventas_fecha ON ventas(fecha_venta);
CREATE INDEX IF NOT EXISTS idx_ventas_producto ON ventas(producto_id);
CREATE INDEX IF NOT EXISTS idx_ventas_empleado ON ventas(empleado_id);
CREATE INDEX IF NOT EXISTS idx_ventas_sucursal ON ventas(sucursal_id);

-- Mostrar información de las tablas creadas
SELECT 'Tablas creadas exitosamente:' as mensaje;
SELECT 'Sucursales: ' || COUNT(*) as total FROM sucursales;
SELECT 'Productos: ' || COUNT(*) as total FROM productos;
SELECT 'Empleados: ' || COUNT(*) as total FROM empleados;
SELECT 'Ventas: ' || COUNT(*) as total FROM ventas;
