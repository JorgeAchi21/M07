/*
Creacion de la bbdd PIZZERIA
*/
/*creacion bbdd*/
CREATE DATABASE IF NOT EXISTS `M702Pizzeria`
USE M702Pizzeria

/* =================== Creacion tablas =================== */
CREATE TABLE `Clientes` (
  `idClientes` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `cp` varchar(5) DEFAULT NULL,
  `localidad` varchar(50) DEFAULT NULL,
  `provicincia` varchar(50) DEFAULT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`idClientes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Empleados` (
  `idEmpleados` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `nif` varchar(50) NOT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  `tipo_trabajo` set('cocinero','repartidor') DEFAULT NULL,
  PRIMARY KEY (`idEmpleados`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Pedidos` (
  `idPedidos` int unsigned NOT NULL AUTO_INCREMENT,
  `fechaHoraCreacion` timestamp NULL DEFAULT NULL,
  `domicilio_tienda` set('domicilio','tienda') DEFAULT NULL,
  `num_productos` int DEFAULT NULL,
  `tipo_producto` varchar(50) DEFAULT NULL,
  `precio_total` float DEFAULT NULL,
  PRIMARY KEY (`idPedidos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Pizzas` (
  `idPizzas` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `estado` set('activa','desactivada') DEFAULT NULL COMMENT 'si la pizza esta activa o desactivada.',
  PRIMARY KEY (`idPizzas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Categorias_pizza` (
  `idCategorias_pizza` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL,
  PRIMARY KEY (`idCategorias_pizza`));
  
CREATE TABLE `Provincias` (
  `idProvincias` int unsigned NOT NULL,
  `provincia` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idProvincias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Poblaciones` (
  `idPoblaciones` int unsigned NOT NULL AUTO_INCREMENT,
  `poblacion` varchar(50) DEFAULT NULL,
  `idProvincia` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idPoblaciones`),
  KEY `idx_provincias` (`idProvincia`),
  CONSTRAINT `fk_provincias` FOREIGN KEY (`idProvincia`) REFERENCES `Provincias` (`idProvincias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Productos` (
  `idProductos` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `tipo` set('pizza','hamburguesa','bebida') DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `imagen_url` varchar(100) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  PRIMARY KEY (`idProductos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Repartos_a_domicilio` (
  `idRepartos_a_domicilio` int unsigned NOT NULL AUTO_INCREMENT,
  `repartidor` varchar(50) DEFAULT NULL,
  `FechaHora_entrega` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idRepartos_a_domicilio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Tiendas` (
  `idTiendas` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `cp` varchar(5) DEFAULT NULL,
  `localidad` varchar(50) DEFAULT NULL,
  `provincia` varchar(50) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTiendas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Tiendas_empleados` (
  `idTiendasEmpleados` int unsigned NOT NULL AUTO_INCREMENT,
  `idTiendas` int unsigned DEFAULT NULL,
  `idEmpleados` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idTiendasEmpleados`),
  UNIQUE KEY `idEmpleados_UNIQUE` (`idEmpleados`),
  KEY `inx_tiendas` (`idTiendas`),
  KEY `inx_empleados` (`idEmpleados`),
  CONSTRAINT `fk_idTE_empleados` FOREIGN KEY (`idEmpleados`) REFERENCES `Empleados` (`idEmpleados`),
  CONSTRAINT `fk_idTE_tiendas` FOREIGN KEY (`idTiendas`) REFERENCES `Tiendas` (`idTiendas`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/* =================== Datos de pruebas=================== */
/* 01 - Clientes */
INSERT INTO `Clientes` VALUES 
(1,'Jorge','Rodriguez','Diagonal','08001','Barcelona','Barcelona','931234567'),
(2,'Antonio','Garcia','Constitucion','08002','Barcelona','Barcelona','931234567'),
(3,'Maria','Gonzalez','Entenza','08003','Barcelona','Barcelona','931234567'),
(4,'Carmen','Fernandez','Diagonal','08004','Barcelona','Barcelona','931234567'),
(5,'Julia','Lopez','Paso de Gracia','08005','Barcelona','Barcelona','931234567');

/* 02 - Empleados */
INSERT INTO `Empleados` VALUES 
(1,'Antonio','Fernandez','12345678A','931234567','repartidor'),
(2,'Jose','Lopez','12345678B','931234567','cocinero'),
(3,'Maria','Bonilla','12345678C','931234567','repartidor'),
(4,'Antonia','Sanz','12345678D','931234567','cocinero'),
(5,'Fernando','Solas','12345678E','931234567','repartidor');

/* 03 - Pedidos */
INSERT INTO `Pedidos` VALUES 
(1,'2021-02-28 23:00:00','domicilio',1,'1',10),
(8,'2021-03-01 23:00:00','tienda',2,'2',12),
(9,'2021-03-02 23:00:00','domicilio',2,'2',14),
(10,'2021-03-03 23:00:00','tienda',3,'2',15),
(11,'2021-03-04 23:00:00','domicilio',3,'3',16);

/* 04 - Pizzas */
INSERT INTO `Pizzas` VALUES 
(1,'Carbonara','carbonara','1','activa'),
(2,'4 estaciones','4 estaciones','1','activa'),
(3,'4 quesos','4 quesos','1','activa'),
(4,'6 quesos','6 quesos','2','activa'),
(5,'Hawaiana','Hawaiana','2','activa'),
(7,'Barbacoa','Barbacoa','3','activa'),
(8,'Mexicana','Mexicana','3','desactivada');

/* 05 - Categorias_pizza */
INSERT INTO `Categorias_pizza` VALUES 
(1,'precio bajo'),
(2,'precio moderado'),
(3,'precio alto');

/* 07 - Provincias */
INSERT INTO `Provincias` VALUES 
(1,'Barcelona'),
(2,'Tarragona'),
(3,'Leridad'),
(4,'Gerona');

/* 06 - Poblaciones */
INSERT INTO `Poblaciones` VALUES 
(1,'Barcelona',1),
(2,'Hospitalet',1),
(3,'Sant Feliu',1),
(4,'Santa Coloma',1);

/* 08 - Productos */
INSERT INTO `Productos` VALUES 
(1,'Hawaiana','pizza','pizza hawaiana','/etc/www/img/pizza1.jpg',5),
(2,'Cocacola','bebida','lata cocacola','/etc/www/img/coca1.jpg',1.5),
(3,'Hamburguesa grande','hamburguesa','hamburguesa grande','/etc/www/img/hamG.jpg',2),
(4,'Hamburguesa mediana','hamburguesa','hamburguesa mediana','/etc/www/img/hamM.jpg',1.5),
(5,'Hamburguesa pequeña','hamburguesa','hamburguesa pequeña','/etc/www/img/hamP.jpg',1),
(6,'Fanta Naranja','bebida','lata fanta','/etc/www/img/fanta.jpg',1.5),
(7,'Mexicana','pizza','pizza Mejicana','/etc/www/img/pizza2.jpg',5);

/* 09 - Repartos_a_domicilio */
INSERT INTO `Repartos_a_domicilio` VALUES 
(1,'1','2021-03-01 13:13:59'),
(2,'1','2021-03-02 13:14:52'),
(3,'1','2021-03-03 13:15:52'),
(4,'2','2021-03-04 13:16:52'),
(5,'2','2021-03-05 13:17:52'),
(6,'2','2021-03-06 13:18:52');

/* 10 - Tiendas */
INSERT INTO `Tiendas` VALUES 
(1,'Barcelona centro','Plaza Cataluña','08001','Barcelona','Barcelona','931234567'),
(2,'Hospitalet','Plaza del Ayuntamiento','08002','Hospitalet','Barcelona','931234567'),
(3,'Santa Coloma cntro Comer','Plaza Mayor','08003','Santa Coloma','Barcelona','931234567'),
(4,'Sant Feliu calle','Sant Feliu','08004','Sant Feliu','Barcelona','931234567'),
(5,'Cornella terraza','Sant Ildefonso','08005','Cornella','Barcelona','931234567');

INSERT INTO `Tiendas_empleados` VALUES 
(1,1,1),
(2,1,2),
(3,1,3),
(4,2,4),
(5,2,5);

